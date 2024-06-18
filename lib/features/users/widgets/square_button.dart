import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SquareButton extends StatelessWidget {
  const SquareButton({
    super.key,
    required this.size,
    required this.iconSize,
    required this.icon,
  });

  final double size;
  final double iconSize;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey.shade300,
        ),
      ),
      child: Center(
        child: FaIcon(
          icon,
          size: iconSize,
        ),
      ),
    );
  }
}
