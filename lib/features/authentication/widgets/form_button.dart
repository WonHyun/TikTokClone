import 'package:flutter/material.dart';
import 'package:tictok_clone/constants/sizes.dart';
import 'package:tictok_clone/utils.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isEnabled = true,
  });

  final String text;
  final VoidCallback onTap;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnabled ? onTap : () => {},
      child: FractionallySizedBox(
        widthFactor: 1.0,
        child: AnimatedContainer(
          duration: Durations.short3,
          padding: const EdgeInsets.symmetric(vertical: Sizes.size16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.size5),
            color: isEnabled
                ? Theme.of(context).primaryColor
                : isDarkMode(context)
                    ? Colors.grey.shade800
                    : Colors.grey.shade300,
          ),
          child: AnimatedDefaultTextStyle(
            duration: Durations.short3,
            style: TextStyle(
              color: isEnabled ? Colors.white : Colors.grey.shade400,
              fontWeight: FontWeight.w600,
            ),
            child: Text(text, textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
