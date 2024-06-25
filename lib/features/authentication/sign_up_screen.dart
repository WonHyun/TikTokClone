import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/authentication/login_screen.dart';
import 'package:tictok_clone/features/authentication/username_screen.dart';
import 'package:tictok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tictok_clone/utils.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  static String routeName = "signUp";
  static String routeURL = "/";

  void _onScaffoldTap(BuildContext context) {
    FocusScope.of(context).unfocus();
  }

  Future<void> _onLoginTap(BuildContext context) async {
    // final result = await Navigator.of(context).push(MaterialPageRoute(
    //   builder: (context) => const LoginScreen(),
    // ));
    // print(result); // "Return to SignUp"

    // final result = await Navigator.pushNamed(context, LoginScreen.routeName);
    // print(result); // "Return to SignUp"

    context.push(LoginScreen.routeURL);
  }

  void _onUsernameTap(BuildContext context) {
    // Navigator.of(context).push(
    //   PageRouteBuilder(
    //     transitionDuration: const Duration(milliseconds: 200),
    //     reverseTransitionDuration: const Duration(milliseconds: 200),
    //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //       final offsetAnimation = Tween(
    //         begin: const Offset(1, 0),
    //         end: Offset.zero,
    //       ).animate(animation);

    //       final opacityAnimation = Tween(
    //         begin: 0.5,
    //         end: 1.0,
    //       ).animate(animation);

    //       return SlideTransition(
    //         position: offsetAnimation,
    //         child: FadeTransition(
    //           opacity: opacityAnimation,
    //           child: child,
    //         ),
    //       );
    //     },
    //     pageBuilder: (context, animation, secondaryAnimation) =>
    //         const UsernameScreen(),
    //   ),
    // );

    // Navigator.of(context).pushNamed(UsernameScreen.routeName);

    // context.push(UsernameScreen.routeName);
    context.pushNamed(UsernameScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onScaffoldTap(context),
      child: OrientationBuilder(
        builder: (context, orientation) {
          // if (orientation == Orientation.landscape) {
          //   return const Scaffold(
          //     body: Center(
          //       child: Text("Please rotate your phone"),
          //     ),
          //   );
          // }
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: Sizes.size32),
                child: Column(
                  children: [
                    Gaps.v80,
                    const Text(
                      "Sign up for TikTok",
                      style: TextStyle(
                        fontSize: Sizes.size24,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Gaps.v20,
                    const Opacity(
                      opacity: 0.7,
                      child: Text(
                        "Create a profile, follow other accounts, make your own videos, and more.",
                        style: TextStyle(fontSize: Sizes.size16),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Gaps.v40,
                    if (orientation == Orientation.portrait) ...[
                      AuthButton(
                        onTap: () => _onUsernameTap(context),
                        icon: const FaIcon(FontAwesomeIcons.user),
                        text: "Use email & password",
                      ),
                      Gaps.v16,
                      AuthButton(
                        onTap: () => {},
                        icon: const FaIcon(FontAwesomeIcons.apple),
                        text: "Continue with Apple",
                      ),
                    ],
                    if (orientation == Orientation.landscape)
                      Row(
                        children: [
                          Expanded(
                            child: AuthButton(
                              onTap: () => _onUsernameTap(context),
                              icon: const FaIcon(FontAwesomeIcons.user),
                              text: "Use email & password",
                            ),
                          ),
                          Gaps.h16,
                          Expanded(
                            child: AuthButton(
                              onTap: () => {},
                              icon: const FaIcon(FontAwesomeIcons.apple),
                              text: "Continue with Apple",
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              color: isDarkMode(context) ? null : Colors.grey.shade50,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: Sizes.size24,
                  bottom: Sizes.size64,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    Gaps.h5,
                    GestureDetector(
                      onTap: () => _onLoginTap(context),
                      child: Text(
                        "Log in",
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
