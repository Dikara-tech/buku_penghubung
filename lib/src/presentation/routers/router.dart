import 'package:auto_route/auto_route.dart';
import 'package:buku_penghubung/src/app.dart';
import 'package:buku_penghubung/src/data/repositories/repositories.dart';
import 'package:buku_penghubung/src/di/injection_container.dart';
import 'package:buku_penghubung/src/presentation/features/features.dart';
import 'package:injectable/injectable.dart';

part 'router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Router')
class AppRouter extends _$AppRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      path: '/main',
      page: MainScopeRouter.page,
      maintainState: true,
      children: [
        AutoRoute(
          path: 'home',
          page: MainRouter.page,
          children: [
            AutoRoute(
              path: '',
              page: AnnouncementRouter.page,
              initial: true,
            ),
            AutoRoute(
              path: 'message-list',
              page: MessageListRouter.page,
            ),
            AutoRoute(
              path: 'assignment-list',
              page: AssignmentListRouter.page,
            ),
            AutoRoute(
              path: 'recitation-list',
              page: RecitationListRouter.page,
            ),
            AutoRoute(
              path: 'profile',
              page: ProfileRouter.page,
              maintainState: true,
            ),
          ],
        ),
      ],
    ),

    /// Authentication
    AutoRoute(
      guards: [inject<AuthGuard>()],
      path: '/',
      initial: true,
      page: LoginRouter.page,
    ),

    // AutoRoute(
    //   path: '/success',
    //   page: SuccessRouter.page,
    // ),
  ];
}

@lazySingleton
class AuthGuard extends AutoRouteGuard {
  final AuthenticationRepository _authenticationRepository;

  AuthGuard(this._authenticationRepository);

  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final isLoggedIn = await _authenticationRepository.userIsLoggedIn();

    if (!isLoggedIn) {
      resolver.next(true);
    } else {
      await router.push(const MainScopeRouter());
      resolver.next(false);
    }
  }
}
