import 'package:flutter/material.dart';

class ProfileCircleAvatar extends StatelessWidget {
  const ProfileCircleAvatar({
    super.key,
    required this.imgPath,
  });

  final String imgPath;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      foregroundImage: NetworkImage(imgPath),
      child: const Text("US"),
    );
  }
}
