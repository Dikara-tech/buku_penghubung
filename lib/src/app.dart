import 'package:auto_route/auto_route.dart';
import 'package:buku_penghubung/gen/assets.gen.dart';
import 'package:buku_penghubung/src/di/injection_container.dart';
import 'package:buku_penghubung/src/presentation/blocs/authentication/auth_bloc.dart';
import 'package:buku_penghubung/src/presentation/routers/router.dart';
import 'package:buku_penghubung/src/presentation/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => inject<AuthBloc>(),
        ),
      ],
      child: ScreenUtilInit(
        useInheritedMediaQuery: true,
        designSize: const Size(428, 926),
        builder: (_, child) => MaterialApp.router(
          routerConfig: inject<AppRouter>().config(),
          title: 'Buku Penghubung',
          theme: GoTheme.lightTheme(),
          darkTheme: GoTheme.lightTheme(),
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: child!,
            );
          },
        ),
      ),
    );
  }
}

@RoutePage()
class MainScopePage extends StatelessWidget {
  const MainScopePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const AutoRouter();
  }
}

@RoutePage()
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (a, b) => a.isLoggedIn != b.isLoggedIn,
      builder: (context, state) {
        return AutoTabsScaffold(
          homeIndex: 0,
          animationCurve: Curves.fastOutSlowIn,
          extendBody: true,
          resizeToAvoidBottomInset: false,
          routes: const [
            AnnouncementRouter(),
            MessageListRouter(),
            AssignmentListRouter(),
            RecitationListRouter(),
            ProfileRouter(),
          ],
          bottomNavigationBuilder: (_, tabsRouter) {
            return BottomAppBar(
              color: Colors.transparent,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4).r,
                color: GoColor.albin,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _TabsContainer(
                      isActive: tabsRouter.activeIndex == 0,
                      asset: Assets.icon.systems.icHomeOutline,
                      assetActive: Assets.icon.systems.icHomeFill,
                      title: 'Home',
                      onTap: () {
                        tabsRouter.setActiveIndex(0);
                      },
                    ),
                    _TabsContainer(
                      isActive: tabsRouter.activeIndex == 1,
                      asset: Assets.icon.systems.icMedicineOutline,
                      assetActive: Assets.icon.systems.icMedicineFill,
                      title: 'Resep',
                      onTap: () {
                        tabsRouter.setActiveIndex(1);
                      },
                    ),
                    _TabsContainer(
                      isActive: tabsRouter.activeIndex == 2,
                      asset: Assets.icon.systems.icMenuGridOutline,
                      assetActive: Assets.icon.systems.icMenuGridFill,
                      title: 'Kategori',
                      onTap: () {
                        tabsRouter.setActiveIndex(2);
                      },
                    ),
                    _TabsContainer(
                      isActive: tabsRouter.activeIndex == 3,
                      asset: Assets.icon.systems.icMoneyOutline,
                      assetActive: Assets.icon.systems.icMoneyFill,
                      title: 'Transaksi',
                      onTap: () {
                        tabsRouter.setActiveIndex(3);
                      },
                    ),
                    _TabsContainer(
                      isActive: tabsRouter.activeIndex == 4,
                      asset: Assets.icon.systems.icUserOutline,
                      assetActive: Assets.icon.systems.icUserFill,
                      title: 'Profil',
                      onTap: () {
                        if (state.isLoggedIn) {
                          tabsRouter.setActiveIndex(4);
                        } else {
                          AutoRouter.of(context).push(const LoginRouter());
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _TabsContainer extends StatelessWidget {
  const _TabsContainer({
    Key? key,
    required this.isActive,
    required this.asset,
    required this.assetActive,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final bool isActive;
  final String asset;
  final String assetActive;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 1.sw * 0.19,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              isActive ? assetActive : asset,
              width: 24.sp,
              height: 24.sp,
              colorFilter: ColorFilter.mode(
                isActive ? GoColor.hydro : GoColor.anaesthesia,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              title,
              style: GoTypography.small(
                color: isActive ? GoColor.hydro : GoColor.anaesthesia,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
