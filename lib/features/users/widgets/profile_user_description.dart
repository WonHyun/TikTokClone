import 'package:flutter/material.dart';

class ProfileUserDescription extends StatelessWidget {
  const ProfileUserDescription({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}
