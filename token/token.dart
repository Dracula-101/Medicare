import 'dart:convert';
import 'dart:io';
import 'package:crypto_keys/crypto_keys.dart';
import 'package:http/http.dart' as http;
import 'package:jose/jose.dart';
import 'package:medicare/util/util.dart';

void main(List<String> args) {
  try {
    GetToken().run();
  } catch (exc1) {
    print('Exception: $exc1');
    usage();
  }
}

void usage() {
  print(
      '\nGetToken: get an access token for a service account, given SA credentials.\n');
  print(
      'Usage:\n  GetToken --sakeyfile <sa-json-file> [--scope <desired scope>]');
}

class GetToken {
  final String _scope = 'https://www.googleapis.com/auth/cloud-platform';
  final String _grantType = 'urn:ietf:params:oauth:grant-type:jwt-bearer';
  final String _saCredsFilename = './ocr_secret.json';
  static const int _lifetimeInSeconds = 60;


  void run() async {
    var sakeyjson = jsonDecode(File(_saCredsFilename).readAsStringSync());
    String token = generateToken(sakeyjson);
    var response = requestAccessToken(token, sakeyjson['token_uri']);
    var responseJson = jsonDecode(await response);
    var accessToken = responseJson['access_token'].toString().trim();
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

  writeToken(Map<String, dynamic> token) {
    return jsonEncode(token);
  }

  readToken(tokenString) {
    return jsonDecode(tokenString);
  }
}
