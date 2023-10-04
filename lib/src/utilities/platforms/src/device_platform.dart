import 'dart:io';

import 'package:buku_penghubung/src/di/injection_container.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:ios_utsname_ext/extension.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// A helper class to query device platform information.
abstract class DevicePlatformInfo {
  /// The build number. `CFBundleVersion` on iOS, `versionCode` on Android.
  int get appBuildNumber;

  /// The package version. `CFBundleShortVersionString` on iOS, `versionName`
  /// on Android.
  String get appVersion;

  /// The consumer-visible brand.
  ///
  /// Returns 'Unknown' if the brand isn't known.
  String get brand;

  /// Whether the operating system is a version of
  /// [Android](https://en.wikipedia.org/wiki/Android_%28operating_system%29).
  bool get isAndroid;

  /// Whether the operating system is a version of
  /// [iOS](https://en.wikipedia.org/wiki/IOS).
  bool get isIOS;

  /// The end-user-visible name for the end product.
  ///
  /// Returns 'Unknown' if the name isn't known.
  String get model;

  /// The user-visible operating system name.
  ///
  /// Returns 'Unknown' if the name isn't known.
  String get osName;

  /// The user-visible operating system version.
  ///
  /// Returns 'Unknown' if the version isn't known.
  String get osVersion;
}

@android
@LazySingleton(as: DevicePlatformInfo)
class DevicePlatformInfoAndroid implements DevicePlatformInfo {
  final PackageInfo _packageInfo;
  final AndroidDeviceInfo _androidInfo;

  /// Creates a helper class to query android device platform information.
  const DevicePlatformInfoAndroid(
    this._packageInfo,
    this._androidInfo,
  );

  @override
  int get appBuildNumber {
    return int.parse(_packageInfo.buildNumber);
  }

  @override
  String get appVersion {
    return _packageInfo.version;
  }

  @override
  String get brand {
    return _androidInfo.brand;
  }

  @override
  bool get isAndroid => true;

  @override
  bool get isIOS => false;

  @override
  String get model {
    return _androidInfo.model;
  }

  @override
  String get osName {
    return 'Android';
  }

  @override
  String get osVersion {
    return _androidInfo.version.sdkInt.toString();
  }
}

@ios
@LazySingleton(as: DevicePlatformInfo)
class DevicePlatformInfoIos implements DevicePlatformInfo {
  final bool _isJailBroken;
  final PackageInfo _packageInfo;
  final IosDeviceInfo _iosInfo;

  /// Creates a helper class to query device platform information.
  const DevicePlatformInfoIos(
    @Named('IsJailBroken') this._isJailBroken,
    this._packageInfo,
    this._iosInfo,
  );

  @override
  int get appBuildNumber {
    return int.parse(_packageInfo.buildNumber);
  }

  @override
  String get appVersion {
    return _packageInfo.version;
  }

  @override
  String get brand {
    return 'Apple';
  }

  @override
  bool get isAndroid => false;

  @override
  bool get isJailBroken => _isJailBroken;

  @override
  bool get isIOS => true;

  @override
  String get model {
    return _iosInfo.utsname.machine.iOSProductName;
  }

  @override
  String get osName {
    return 'iOS';
  }

  @override
  String get osVersion {
    return _iosInfo.systemVersion;
  }
}

@LazySingleton(
  env: [
    'fuchsia',
    'linux',
    'macos',
    'windows',
  ],
  as: DevicePlatformInfo,
)
class DevicePlatformInfoOther implements DevicePlatformInfo {
  final PackageInfo _packageInfo;

  /// Creates a helper class to query device platform information.
  const DevicePlatformInfoOther(
    this._packageInfo,
  );

  @override
  int get appBuildNumber {
    return int.parse(_packageInfo.buildNumber);
  }

  @override
  String get appVersion {
    return _packageInfo.version;
  }

  @override
  String get brand {
    return 'Other';
  }

  @override
  bool get isAndroid => false;

  @override
  bool get isJailBroken => true;

  @override
  bool get isIOS => false;

  @override
  String get model {
    return 'Unknown';
  }

  @override
  String get osName {
    return Platform.operatingSystem;
  }

  @override
  String get osVersion {
    return 'Unknown';
  }
}
