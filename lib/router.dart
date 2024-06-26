import 'package:go_router/go_router.dart';
import 'package:tictok_clone/common/widgets/main_navigation/main_navigaion_screen.dart';
import 'package:tictok_clone/features/authentication/login_screen.dart';
import 'package:tictok_clone/features/authentication/sign_up_screen.dart';
import 'package:tictok_clone/features/onboarding/interests_screen.dart';
import 'package:tictok_clone/features/users/user_profile_screen.dart';

final router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      name: SignUpScreen.routeName,
      path: SignUpScreen.routeURL,
      builder: (context, state) => const SignUpScreen(),
      // routes: [
      //   GoRoute(
      //     name: UsernameScreen.routeName,
      //     path: UsernameScreen.routeURL,
      //     builder: (context, state) => const UsernameScreen(),
      //     routes: [
      //       GoRoute(
      //         name: EmailScreen.routeName,
      //         path: EmailScreen.routeURL,
      //         builder: (context, state) {
      //           final extra = state.extra as EmailScreenArguments;
      //           return EmailScreen(username: extra.username);
      //         },
      //       ),
      //     ],
      //     // pageBuilder: (context, state) {
      //     //   return CustomTransitionPage(
      //     //     transitionsBuilder:
      //     //         (context, animation, secondaryAnimation, child) {
      //     //       return FadeTransition(
      //     //         opacity: animation,
      //     //         child: ScaleTransition(
      //     //           scale: animation,
      //     //           child: child,
      //     //         ),
      //     //       );
      //     //     },
      //     //     child: const UsernameScreen(),
      //     //   );
      //     // },
      //   ),
      // ],
    ),
    GoRoute(
      name: LoginScreen.routeName,
      path: LoginScreen.routeURL,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      name: InterestsScreen.routeName,
      path: InterestsScreen.routeURL,
      builder: (context, state) => const InterestsScreen(),
    ),
    GoRoute(
      path: "/:tab(home|discover|inbox|profile)",
      name: MainNavigaionScreen.routeName,
      builder: (context, state) {
        final tab = state.pathParameters["tab"];
        return MainNavigaionScreen(tab: tab ?? "");
      },
    ),
    GoRoute(
      path: "/users/:username",
      builder: (context, state) {
        final username = state.pathParameters["username"];
        final tab = state.uri.queryParameters["show"];
        return UserProfileScreen(
          username: username ?? "",
          tab: tab ?? "",
        );
      },
    ),
  ],
);
