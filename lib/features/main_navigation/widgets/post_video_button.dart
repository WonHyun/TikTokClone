import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tictok_clone/constants/sizes.dart';

class PostVideoButton extends StatefulWidget {
  const PostVideoButton({
    super.key,
    required this.onTap,
    required this.inverted,
  });

  final VoidCallback onTap;
  final bool inverted;

  @override
  State<PostVideoButton> createState() => _PostVideoButtonState();
}

class _PostVideoButtonState extends State<PostVideoButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) => setState(() => _isPressed = true),
      onTapUp: (details) => setState(() {
        widget.onTap();
        _isPressed = false;
      }),
      onTapCancel: () => setState(() => _isPressed = false),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            right: 20,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: _isPressed ? 40 : 30,
              width: _isPressed ? 30 : 25,
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size8),
              decoration: BoxDecoration(
                color: const Color(0xFF61D4F0),
                borderRadius: BorderRadius.circular(Sizes.size8),
              ),
            ),
          ),
          Positioned(
            left: 20,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: _isPressed ? 40 : 30,
              width: _isPressed ? 30 : 25,
              padding: const EdgeInsets.symmetric(horizontal: Sizes.size8),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(Sizes.size8),
              ),
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            height: _isPressed ? 40 : 30,
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size12),
            decoration: BoxDecoration(
              color: widget.inverted ? Colors.black : Colors.white,
              borderRadius: BorderRadius.circular(Sizes.size6),
            ),
            child: Center(
              child: FaIcon(
                FontAwesomeIcons.plus,
                size: 18,
                color: widget.inverted ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
