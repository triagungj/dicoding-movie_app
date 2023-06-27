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

  static IOClient? _client;

  IOClient get client {
    return _client ??= ioClient();
  }

  IOClient ioClient() {
    final client = HttpClient(context: _securityContext)
      ..badCertificateCallback = (
        X509Certificate cert,
        String host,
        int port,
      ) =>
          false;
    return IOClient(client);
  }
}
