/// A static class that represents application wide configuration.
class Config {
  const Config._();

  /// Available build variant: 'staging' and 'production'
  static const String buildVariant = String.fromEnvironment(
    'BUILD_VARIANT',
    defaultValue: 'staging',
  );
  static const bool debug = buildVariant == 'staging' ||
      bool.hasEnvironment('DEBUG') && String.fromEnvironment('DEBUG') == 'true';

  static const String appId = 'BUKU-PENGHUBUNG';
  static const String appSecret = '';
  static const String appName = 'Buku Penghubung';
  static const String csPhone = '';
  static const String androidAppId = 'com.example.buku_penghubung';
  static const String iosAppId = '';
}
