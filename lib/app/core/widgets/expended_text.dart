import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLines;

  const ExpandableText(this.text, {this.trimLines = 2, Key? key})
      : super(key: key);

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final span = TextSpan(
        text: widget.text,
        style: const TextStyle(color: Colors.black, fontSize: 14),
      );
      final tp = TextPainter(
        text: span,
        maxLines: widget.trimLines,
        textDirection: TextDirection.ltr,
      );
      tp.layout(maxWidth: constraints.maxWidth);

      final isOverflow = tp.didExceedMaxLines;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.text,
            maxLines: isExpanded ? null : widget.trimLines,
            overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 14),
          ),
          if (isOverflow)
            InkWell(
              onTap: () => setState(() => isExpanded = !isExpanded),
              child: Text(
                isExpanded ? "See less" : "See more",
                style: const TextStyle(
                    color: Colors.blue, fontWeight: FontWeight.w600),
              ),
            ),
        ],
      );
    });
  }
}
