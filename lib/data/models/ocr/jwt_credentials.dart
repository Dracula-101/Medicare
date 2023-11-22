import 'dart:convert';

class JwtCredentials {
  final JsonSettings settings;
  final String? scope;

  JwtCredentials({required this.settings, required this.scope});

  factory JwtCredentials.fromJson(Map<String, dynamic> json) {
    return JwtCredentials(
      settings: JsonSettings.fromJson(json['settings']),
      scope: json['scope'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['settings'] = settings.toJson();
    data['scope'] = scope;
    return data;
  }

  @override
  String toString() => jsonEncode(toJson());
}

class JsonSettings {
  final String type;
  final String projectId;
  final String projectKeyId;
  final String privateKey;
  final String clientEmail;
  final String clientId;
  final String authUri;
  final String tokenUri;
  final String authProviderX509CertUrl;
  final String clientX509CertUrl;

  JsonSettings(
      {required this.type,
      required this.projectId,
      required this.projectKeyId,
      required this.privateKey,
      required this.clientEmail,
      required this.clientId,
      required this.authUri,
      required this.tokenUri,
      required this.authProviderX509CertUrl,
      required this.clientX509CertUrl});

  factory JsonSettings.fromJson(Map<String, dynamic> json) {
    return JsonSettings(
      type: json['type'],
      projectId: json['project_id'],
      projectKeyId: json['private_key_id'],
      privateKey: json['private_key'],
      clientEmail: json['client_email'],
      clientId: json['client_id'],
      authUri: json['auth_uri'],
      tokenUri: json['token_uri'],
      authProviderX509CertUrl: json['auth_provider_x509_cert_url'],
      clientX509CertUrl: json['client_x509_cert_url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['project_id'] = projectId;
    data['private_key_id'] = projectKeyId;
    data['private_key'] = privateKey;
    data['client_email'] = clientEmail;
    data['client_id'] = clientId;
    data['auth_uri'] = authUri;
    data['token_uri'] = tokenUri;
    data['auth_provider_x509_cert_url'] = authProviderX509CertUrl;
    data['client_x509_cert_url'] = clientX509CertUrl;
    return data;
  }

  @override
  String toString() => jsonEncode(toJson());
}

class AccessToken {
  String? accessToken;
  String? scope;
  String? tokenType;
  String? refreshToken;
  DateTime? expiryDate;

  AccessToken(
      {required this.accessToken,
      required this.expiryDate,
      this.scope,
      required this.tokenType,
      this.refreshToken});

  factory AccessToken.fromJson(Map<String, dynamic> json) {
    return AccessToken(
      accessToken: (json['access_token'] != null)
          ? json['access_token']
          : (json['id_token'] != null)
              ? json['id_token']
              : null,
      expiryDate: DateTime.now().add(Duration(seconds: json['expires_in'])),
      scope: json['scope'],
      tokenType: json['token_type'],
      refreshToken: json['refresh_token'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['expires_in'] = expiryDate!.difference(DateTime.now()).inSeconds;
    data['scope'] = scope;
    data['token_type'] = tokenType;
    data['refresh_token'] = refreshToken;
    return data;
  }
}
