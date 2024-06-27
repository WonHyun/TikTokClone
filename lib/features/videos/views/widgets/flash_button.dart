import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FlashButton extends StatelessWidget {
  const FlashButton({
    super.key,
    required this.flashMode,
    required this.onPressed,
    required this.isOn,
  });

  final FlashMode flashMode;
  final Function(FlashMode) onPressed;
  final bool isOn;

  IconData _getIcon(FlashMode mode) {
    switch (mode) {
      case FlashMode.off:
        return Icons.flash_off_rounded;
      case FlashMode.auto:
        return Icons.flash_auto_rounded;
      case FlashMode.always:
        return Icons.flash_on_rounded;
      case FlashMode.torch:
        return Icons.flashlight_on_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: isOn ? Colors.amber.shade200 : Colors.white,
      onPressed: () => onPressed(flashMode),
      icon: Icon(
        _getIcon(flashMode),
      ),
    );
  }
}
