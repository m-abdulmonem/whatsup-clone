import 'package:get/get.dart';
import 'package:whats_app_clone/future/camera/presentation/camera_view.dart';
import 'package:whats_app_clone/future/main/presentation/main_view.dart';
import 'package:whats_app_clone/future/splash/presentation/SplashView.dart';

import 'app_routes.dart';

class AppPages {
  static const String  initial = Routes.SPLASH;

  static final routes = <GetPage<dynamic>>[
    GetPage(name: Routes.SPLASH, page: () => const SplashView()),
    // GetPage(name: Routes.ON_BOARDING, page: () => const BoardingView()),
    // GetPage(
    //   name: Routes.AUTH,
    //   page: () => const AuthView(),
    //   binding: AuthBinding(),
    //   children: [
    //     GetPage(name: Routes.LOGIN, page: () => const LoginView()),
    //     GetPage(name: Routes.Register, page: () => const RegisterView()),
    //     GetPage(name: Routes.FORGET_PASSWORD, page: () => const ForgetPasswordView()),
    //   ],
    // ),

    GetPage(
        name: Routes.MAIN,
        page: () => MainView(),
        children: [
          GetPage(name: Routes.CAMERA, page: () => CameraView()),
          // GetPage(name: Routes.HOME, page: () => const HomeView())
        ])
  ];
}
