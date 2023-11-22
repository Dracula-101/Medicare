import 'dart:convert';
import 'dart:io';

import 'package:crypto_keys/crypto_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:jose/jose.dart';
import 'package:medicare/data/models/ocr/jwt_credentials.dart';
import 'package:medicare/data/models/ocr/ocr_response_model.dart';
import 'package:medicare/data/models/ocr/ocr_secret_model.dart';
import 'package:medicare/injector/injector.dart';
import 'package:medicare/services/local_storage_service/local_storage_service.dart';
import 'package:medicare/util/util.dart';
import 'package:mime/mime.dart';

import '../log_service/log_service.dart';

class OCRService {

  OCRService({
    required this.logger,
  });

  final LogService logger;
  late final TokenManager tokenManager = TokenManager(logger: logger);
  Dio? _dio;
  OCRSecret? _secrets;
  static const String secretPath = "assets/secrets/secret.json";
  static const String baseUrl = "https://us-documentai.googleapis.com/v1";
  AccessToken? token;
  JwtCredentials? jwtCredentials;
  final String accept = 'application/json';
  final String contentType = 'application/json';


  Future<void> init() async {
    try{
      String secret = await rootBundle.loadString(secretPath);
      _secrets = OCRSecret.fromJson(jsonDecode(secret));
      _dio = Dio(BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        contentType: 'application/json',
      ));
      // log errors
      _dio!.interceptors.add(LogInterceptor(
        requestHeader: true,
        requestBody: false,
        responseHeader: true,
        responseBody: true,
      ));
      token ??= await tokenManager.getToken();
    }
    catch(e){
      logger.e('Error initializing OCRService', e, StackTrace.current);
    }
    finally{
      Injector.instance.signalReady(this);
    }
  }

  Future<void> checkToken() async {
    if (token!.expiryDate != null) {
      if (token!.expiryDate!.isBefore(DateTime.now())) {
        token = await refreshToken();
      }
    }
  }

  Future<AccessToken?> refreshToken() async {
    token = await tokenManager.refreshToken( token!.accessToken!, token!.refreshToken! );
    return token;
  }

  Future<OCRDocument?> getOCRDetection(String filePath) async {
    await checkToken();
    final String url =
        "/projects/${_secrets!.projectId}/locations/${_secrets!.processorLocation}/processors/${_secrets!.processorId}:process";
    final File imageFile = File(filePath);
    // mime type
    final String mimeType = lookupMimeType(imageFile.path) ?? 'image/jpeg';
    final String base64Image = base64Encode(await imageFile.readAsBytes());
    final String body = json.encode({
      "rawDocument": {"content": base64Image, "mimeType": mimeType},
      "name":
          "projects/${_secrets!.projectId}/locations/${_secrets!.processorLocation}/processors/${_secrets!.processorId}"
    });
    // add token
    final Map<String, String> headers = {
      "Authorization": 'Bearer ${token!.accessToken}',
      HttpHeaders.contentTypeHeader: contentType,
      HttpHeaders.acceptHeader: accept,
    };
    final Response response =
        await _dio!.post(url, data: body, options: Options(headers: headers));
    final OCRResponse ocrResponse = OCRResponse.fromJson(response.data);
    return ocrResponse.document;
  }
}

class TokenManager {

  TokenManager({
    required this.logger,
  });

  final LogService logger;

  final String _scope = 'https://www.googleapis.com/auth/cloud-platform';
  final String _grantType = 'urn:ietf:params:oauth:grant-type:jwt-bearer';
  final String _saCredsFilename = 'assets/secrets/ocr_secret.json';
  // storage keys
  final String TOKEN_STORAGE_KEY = "google_access_token";
  final String EXPIRY_STORAGE_KEY = "google_access_token_expiry";
  final String SCOPE_STORAGE_KEY = "google_scope";
  final String TOKEN_TYPE_STORAGE_KEY = "google_token_type";
  final String REFRESH_TOKEN_STORAGE_KEY = "google_refresh_token";

  Future<AccessToken> getToken() async {
    var sakeyjson = jsonDecode(await rootBundle.loadString(_saCredsFilename));
    String token = generateToken(sakeyjson);
    var response = requestAccessToken(token, sakeyjson['token_uri']);
    var responseJson = jsonDecode(await response);
    logger.i('Got Token from Server');
    return AccessToken.fromJson(responseJson);
  }

  Future<AccessToken> refreshToken(String accessToken, String refreshToken) async {
    var sakeyjson = jsonDecode(await rootBundle.loadString(_saCredsFilename));
    String token = generateToken(sakeyjson);
    var formParams = {'assertion': token, 'grant_type': 'refresh_token', 'refresh_token': refreshToken};
    var response = await http.post(
      Uri.parse(sakeyjson['token_uri']),
      body: formParams,
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to get access token: ${response.body}');
    }
    var responseJson = jsonDecode(response.body);
    logger.i('Refresh Token request');
    return AccessToken.fromJson(responseJson);
  }

  String generateToken(Map<String, dynamic> sakeyjson) {
    final key = JsonWebKey.fromPem(sakeyjson['private_key']!);
    final privateKey = key.cryptoKeyPair;
    final signer = privateKey.createSigner(algorithms.signing.rsa.sha256);
    final header = Util.base64GCloudString('{"alg":"RS256","typ":"JWT"}');
    final claim = Util.base64GCloudString(
        '{"iss": "${sakeyjson['client_email']}","scope": "$_scope","aud": "https://oauth2.googleapis.com/token", "exp": ${Util.unixTimeStamp(DateTime.now().add(const Duration(minutes: 60)))},"iat": ${Util.unixTimeStamp(DateTime.now())}}');
    final signature = signer.sign('$header.$claim'.codeUnits);
    final jwt = '$header.$claim.${Util.base64GCloudList(signature.data)}';
    return jwt;
  }

  Future<String> requestAccessToken(String tokenString, String uri) async {
    var formParams = {'assertion': tokenString, 'grant_type': _grantType};

    var response = await http.post(
      Uri.parse(uri),
      body: formParams,
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to get access token: ${response.body}');
    } else {
      return response.body;
    }
  }
}
