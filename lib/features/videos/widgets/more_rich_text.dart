import 'package:flutter/material.dart';

class MoreRichText extends StatefulWidget {
  const MoreRichText({
    super.key,
    required this.text,
    required this.textStyle,
    this.maxLines = 1,
  });

  final String text;
  final TextStyle textStyle;
  final int maxLines;

  @override
  State<MoreRichText> createState() => _MoreRichTextState();
}

class _MoreRichTextState extends State<MoreRichText> {
  bool _isTapping = false;
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final TextSpan textSpan = TextSpan(
        text: widget.text,
        style: widget.textStyle,
      );

      final TextPainter textPainter = TextPainter(
        text: textSpan,
        maxLines: widget.maxLines,
        textDirection: TextDirection.ltr,
      );

      textPainter.layout(maxWidth: constraints.maxWidth - 70);

      return RichText(
        maxLines: _isExpanded ? null : widget.maxLines,
        overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
        text: TextSpan(
          children: [
            TextSpan(
              text: widget.text,
              style: widget.textStyle,
            ),
            WidgetSpan(
              child: Offstage(
                offstage: _isExpanded || !textPainter.didExceedMaxLines,
                child: GestureDetector(
                  onTap: () => setState(() => _isExpanded = true),
                  onTapDown: (details) => setState(() => _isTapping = true),
                  onTapUp: (details) => setState(() => _isTapping = false),
                  onTapCancel: () => setState(() => _isTapping = false),
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 100),
                    style: widget.textStyle.copyWith(
                      color: _isTapping
                          ? Theme.of(context).primaryColor
                          : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    child: const Text("See More"),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
