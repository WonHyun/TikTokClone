import 'package:flutter/material.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';

class UserStatePanelView extends StatelessWidget {
  const UserStatePanelView({
    super.key,
    required this.score,
    required this.title,
  });

  final String score;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          score,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Sizes.size18,
          ),
        ),
        Gaps.v3,
        Text(
          title,
          style: TextStyle(
            color: Colors.grey.shade500,
          ),
        ),
      ],
    );
  }
}
