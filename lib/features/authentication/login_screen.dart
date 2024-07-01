import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/features/authentication/login_form_screen.dart';
import 'package:tictok_clone/features/authentication/view_models/social_auth_view_model.dart';
import 'package:tictok_clone/features/authentication/widgets/auth_button.dart';
import 'package:tictok_clone/utils.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  static String routeName = "login";
  static String routeURL = "/login";

  void _onSignUpTap(BuildContext context) {
    // Navigator.of(context).pop("Return to SignUp");

    context.pop();
  }

  void _onEmailLoginTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginFormScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: Sizes.size40),
          child: Column(
            children: [
              Gaps.v80,
              const Text(
                "Log in to TikTok",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Gaps.v20,
              const Opacity(
                opacity: 0.7,
                child: Text(
                  "Manage your account. check notifications. comment on videos, and more.",
                  style: TextStyle(fontSize: Sizes.size16),
                  textAlign: TextAlign.center,
                ),
              ),
              Gaps.v40,
              AuthButton(
                text: "Use email & password",
                onTap: () => _onEmailLoginTap(context),
                icon: const FaIcon(FontAwesomeIcons.user),
              ),
              Gaps.v16,
              AuthButton(
                onTap: () =>
                    ref.read(socialAuthProvider.notifier).githubSignIn(context),
                icon: const FaIcon(FontAwesomeIcons.github),
                text: "Continue with Github",
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
              const Text("Don't have an account?"),
              Gaps.h5,
              GestureDetector(
                onTap: () => _onSignUpTap(context),
                child: Text(
                  "Sign up",
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
  }
}
