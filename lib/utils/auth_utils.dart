import 'package:flutter/services.dart';

const _authChannel = 'com.expin_book_official.flutter.expin_book/auth';
const _platform = MethodChannel(_authChannel);

class AuthUtils {
  const AuthUtils._();
  static const _authenticate = 'authenticate';
  static const _canAuth = 'canAuth';
  static const _checkBiometrics = 'checkBiometrics';

  static Future<bool?> authenticate() {
    return _platform.invokeMethod<bool>(_authenticate);
  }

  static Future<AuthHelperData?> canAuth() async {
    final map = await _platform.invokeMethod<Map>(_canAuth);
    return map == null ? null : AuthHelperData.fromMap(map);
  }
}

class AuthHelperData {
  final bool? canAuth;
  final String? authData;

  AuthHelperData(this.canAuth, this.authData);

  static AuthHelperData fromMap(Map map) {
    return AuthHelperData(
      map[AuthUtils._canAuth] as bool?,
      map[AuthUtils._checkBiometrics] as String?,
    );
  }
}
