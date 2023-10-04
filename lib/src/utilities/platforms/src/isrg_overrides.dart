import 'dart:convert';
import 'dart:io';

const String isrgRootX1 = '';

/// A class that overrides HttpClient to inject ISRG Root X1 CA Root.
class IsrgOverrides extends HttpOverrides {
  static bool _initIsrg = false;

  /// Create a class that overrides HttpClient to inject ISRG Root X1 CA Root.
  IsrgOverrides() {
    if (!_initIsrg && Platform.isAndroid) {
      SecurityContext.defaultContext.setTrustedCertificatesBytes(
        ascii.encode(isrgRootX1),
      );

      _initIsrg = true;
    }
  }
}
