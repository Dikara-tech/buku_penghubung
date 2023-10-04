import 'package:buku_penghubung/src/di/injection_container.config.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

/// Annotate and register dependencies under android environment.
const android = Environment('android');

/// Annotate and register dependencies under ios environment.
const ios = Environment('ios');

/// Annotate and register dependencies under staging environment.
const staging = Environment('staging');

/// Annotate and register dependencies under production environment.
const production = Environment('production');

/// Manually inject the dependencies with GetIt.
///
/// Useful if you want to do field injection.
final inject = GetIt.instance;

/// Initialize and configure the dependencies of this app.
@InjectableInit(
  preferRelativeImports: false,
)
Future<void> configureDependencies({
  required EnvironmentFilter environmentFilter,
}) =>
    inject.init(environmentFilter: environmentFilter);
