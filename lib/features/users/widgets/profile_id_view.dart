import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/gaps.dart';
import 'package:tictok_clone/constants/sizes.dart';

class ProfileIdView extends StatelessWidget {
  const ProfileIdView({
    super.key,
    required this.id,
    required this.isCertified,
  });

  final String id;
  final bool isCertified;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          id,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: Sizes.size18,
          ),
        ),
        if (isCertified) ...[
          Gaps.h5,
          FaIcon(
            FontAwesomeIcons.solidCircleCheck,
            size: Sizes.size16,
            color: Colors.blue.shade500,
          ),
        ],
      ],
    );
  }
}
