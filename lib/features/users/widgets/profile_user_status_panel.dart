import 'package:flutter/material.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'user_state_panel_view.dart';

class ProfileUserStatusPanel extends StatelessWidget {
  const ProfileUserStatusPanel({
    super.key,
    required this.following,
    required this.follower,
    required this.likes,
  });

  final String following;
  final String follower;
  final String likes;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Sizes.size52,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          UserStatePanelView(
            title: "Following",
            score: following,
          ),
          VerticalDivider(
            width: Sizes.size32,
            thickness: Sizes.size1,
            color: Colors.grey.shade400,
            indent: Sizes.size14,
            endIndent: Sizes.size14,
          ),
          UserStatePanelView(
            title: "Followers",
            score: follower,
          ),
          VerticalDivider(
            width: Sizes.size32,
            thickness: Sizes.size1,
            color: Colors.grey.shade400,
            indent: Sizes.size14,
            endIndent: Sizes.size14,
          ),
          UserStatePanelView(
            title: "Likes",
            score: likes,
          ),
        ],
      ),
    );
  }
}
