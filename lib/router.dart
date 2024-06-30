import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tictok_clone/common/widgets/main_navigation/main_navigaion_screen.dart';
import 'package:tictok_clone/features/authentication/login_screen.dart';
import 'package:tictok_clone/features/authentication/repo/authentication_repo.dart';
import 'package:tictok_clone/features/authentication/sign_up_screen.dart';
import 'package:tictok_clone/features/inbox/activity_screen.dart';
import 'package:tictok_clone/features/inbox/chat_detail_screen.dart';
import 'package:tictok_clone/features/inbox/chats_screen.dart';
import 'package:tictok_clone/features/onboarding/interests_screen.dart';
import 'package:tictok_clone/features/settings/settings_screen.dart';
import 'package:tictok_clone/features/users/user_profile_screen.dart';
import 'package:tictok_clone/features/videos/views/video_recording_screen.dart';

final routerProvider = Provider(
  (ref) {
    // ref.watch(authState);
    return GoRouter(
      initialLocation: "/home",
      redirect: (context, state) {
        final isLoggedIn = ref.read(authRepo).isLoggedIn;
        if (!isLoggedIn) {
          if (state.matchedLocation != SignUpScreen.routeURL &&
              state.matchedLocation != LoginScreen.routeURL) {
            return SignUpScreen.routeURL;
          }
        }
        return null;
      },
      routes: [
        GoRoute(
          name: SettingsScreen.routeName,
          path: SettingsScreen.routeURL,
          builder: (context, state) => const SettingsScreen(),
        ),
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
          name: ActivityScreen.routeName,
          path: ActivityScreen.routeURL,
          builder: (context, state) => const ActivityScreen(),
        ),
        GoRoute(
          name: ChatsScreen.routeName,
          path: ChatsScreen.routeURL,
          builder: (context, state) => const ChatsScreen(),
          routes: [
            GoRoute(
              name: ChatDetailScreen.routeName,
              path: ChatDetailScreen.routeURL,
              builder: (context, state) {
                final chatId = state.pathParameters["chatId"];
                return ChatDetailScreen(chatId: chatId ?? "");
              },
            ),
          ],
        ),
        GoRoute(
          name: VideoRecordingScreen.routeName,
          path: VideoRecordingScreen.routeURL,
          pageBuilder: (context, state) => CustomTransitionPage(
            child: const VideoRecordingScreen(),
            transitionDuration: const Duration(milliseconds: 200),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              final position = Tween(
                begin: const Offset(0, 1),
                end: Offset.zero,
              ).animate(animation);
              return SlideTransition(
                position: position,
                child: child,
              );
            },
          ),
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
  },
);
