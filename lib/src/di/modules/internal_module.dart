import 'package:buku_penghubung/src/presentation/routers/router.dart';
import 'package:injectable/injectable.dart';

@module
abstract class InternalModule {
  @lazySingleton
  AppRouter get appRouter => AppRouter();
}
