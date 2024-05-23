import 'package:flutter/material.dart';
import 'package:tictok_clone/constants/sizes.dart';

class FormButton extends StatelessWidget {
  const FormButton({
    super.key,
    this.isEnabled = true,
    required this.onTap,
  });

  final bool isEnabled;
  final VoidCallback onTap;

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
                : Colors.grey.shade300,
          ),
          child: AnimatedDefaultTextStyle(
            duration: Durations.short3,
            style: TextStyle(
              color: isEnabled ? Colors.white : Colors.grey.shade400,
              fontWeight: FontWeight.w600,
            ),
            child: const Text("Next", textAlign: TextAlign.center),
          ),
        ),
      ),
    );
  }
}
