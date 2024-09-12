library marquee_ez;

import 'package:flutter/material.dart';

class MarqueeEZ extends StatefulWidget {
  const MarqueeEZ({
    super.key,
    required this.text,
    required this.width,
    this.style = const TextStyle(),
    required this.milliseconds,
  });

  final String text;
  final double width;
  final TextStyle style;
  final int milliseconds;
  @override
  _MarqueeEZ createState() => _MarqueeEZ();
}

class _MarqueeEZ extends State<MarqueeEZ> {
  final ScrollController _controller = ScrollController();
  final GlobalKey textKey = GlobalKey();
  late double textHight = getTextHeight(widget.text, widget.style);
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (_controller.hasClients) {
        double textWidth = getTextWidth();

        _animateTo(widget.width, textWidth);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double getTextHeight(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size.height;
  }

  double getTextWidth() {
    final RenderBox renderBox =
        textKey.currentContext!.findRenderObject() as RenderBox;
    return renderBox.size.width;
  }

  // double getTextHeight() {
  //   final RenderBox renderBox =
  //       textKey.currentContext!.findRenderObject() as RenderBox;
  //   return renderBox.size.height;
  // }

  void _animateTo(double deviceWidth, double textWidth) async {
    double target = deviceWidth + textWidth;
    await _controller.animateTo(target,
        duration: Duration(milliseconds: widget.milliseconds),
        curve: Curves.linear);
    if (_controller.hasClients) {
      _controller.jumpTo(0);
      _animateTo(deviceWidth, textWidth);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: textHight,
      child: ListView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          SizedBox(width: widget.width),
          Text(
            widget.text,
            key: textKey,
            maxLines: 1,
            textDirection: TextDirection.ltr,
            style: widget.style,
          ),
          SizedBox(width: widget.width),
        ],
      ),
    );
  }
}
