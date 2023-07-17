import 'dart:io';

import 'package:dependencies/http/http.dart';
import 'package:flutter/services.dart';

class ClientHandler {
  factory ClientHandler() => _clientHandler ?? ClientHandler._instance();

  ClientHandler._instance() {
    _clientHandler = this;
  }

  static ClientHandler? _clientHandler;

  static SecurityContext? _securityContext;

  Future<SecurityContext> get securityContext async {
    return _securityContext ??= await initContext();
  }

  Future<SecurityContext> initContext() async {
    final globalContext = SecurityContext();
    final sslCert = await rootBundle.load('certificates/certificate.pem');
    globalContext.setTrustedCertificatesBytes(sslCert.buffer.asInt8List());
    return globalContext;
  }

  IOClient ioClient(SecurityContext contextSecurity) {
    final client = HttpClient(context: contextSecurity)
      ..badCertificateCallback = (
        X509Certificate cert,
        String host,
        int port,
      ) =>
          false;
    return IOClient(client);
  }
}
