import 'package:flutter/material.dart';
import 'package:tictok_clone/constants/sizes.dart';

class ProfileFollowButton extends StatelessWidget {
  const ProfileFollowButton({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: Sizes.size12),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: const BorderRadius.all(
            Radius.circular(Sizes.size4),
          ),
        ),
        child: const Text(
          "Follow",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
