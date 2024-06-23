import 'package:flutter/material.dart';

class ProfileUserDescription extends StatelessWidget {
  const ProfileUserDescription({
    super.key,
    required this.description,
    this.textAlign = TextAlign.start,
  });

  final String description;
  final TextAlign textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
    );
  }
}
