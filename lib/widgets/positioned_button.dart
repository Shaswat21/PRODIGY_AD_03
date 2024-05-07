import 'package:flutter/material.dart';

import '../screens/stopwatch_screen.dart';

class PositionedButton extends StatefulWidget {
  final WatchPainter watchPainter;
  final GlobalKey renderBoxKey;
  final Widget child;
  final void Function()? onTap;

  const PositionedButton({
    super.key,
    required this.watchPainter,
    required this.renderBoxKey,
    required this.child,
    required this.onTap,
  });

  @override
  State<PositionedButton> createState() => _PositionedButtonState();
}

class _PositionedButtonState extends State<PositionedButton> {
  late RenderBox renderBox;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      renderBox =
          widget.renderBoxKey.currentContext?.findRenderObject() as RenderBox;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (renderBox == null) {
      return SizedBox();
    }

    final size = renderBox.size;
    final centerX = size.width / 2;
    final centerY = size.height / 2;
    const double containerSize = 300 - 20 - 100;

    return Positioned(
      left: centerX - containerSize / 2 + centerX,
      top: centerY - containerSize / 2 + centerY,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          width: containerSize,
          height: containerSize,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Container(
              width: containerSize - 15,
              height: containerSize - 15,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  width: 7,
                ),
                shape: BoxShape.circle
              ),
              child: Center(child: widget.child),
            ),
          ),
        ),
      ),
    );
  }
}
