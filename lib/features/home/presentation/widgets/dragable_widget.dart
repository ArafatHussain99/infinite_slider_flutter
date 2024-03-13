import 'package:flutter/material.dart';

enum SlideDirection { left, right }

class DragableWidget extends StatefulWidget {
  const DragableWidget(
      {super.key,
      required this.child,
      this.onSlideOut,
      this.onPressed,
      required this.isEnableDrag});

  final Widget child;
  final ValueChanged<SlideDirection>? onSlideOut;
  final VoidCallback? onPressed;
  final bool isEnableDrag;

  @override
  State<DragableWidget> createState() => _DragableWidgetState();
}

class _DragableWidgetState extends State<DragableWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController restoreController;

  final _widgetKey = GlobalKey();
  Offset startOffset = Offset.zero;
  Offset panOffset = Offset.zero;

  Size size = Size.zero;
  double agle = 0.0;

  void onPanStart(DragStartDetails details) {
    if (!restoreController.isAnimating) {
      setState(() {
        startOffset = details.globalPosition;
      });
    }
  }

  void onPanUpdate(DragUpdateDetails details) {
    if (!restoreController.isAnimating) {
      setState(() {
        panOffset = details.globalPosition - startOffset;
      });
    }
  }

  void onPanEnd(DragUpdateDetails details) {
    if (restoreController.isAnimating) {
      return;
    }
  }

  @override
  void initState() {
    restoreController =
        AnimationController(vsync: this, duration: kThemeAnimationDuration);
    super.initState();
  }

  @override
  void dispose() {
    restoreController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final child = SizedBox(
      key: _widgetKey,
      child: widget.child,
    );
    if (!widget.isEnableDrag) {
      return child;
    }
    return GestureDetector(
      onPanStart: onPanStart,
      onPanUpdate: onPanUpdate,
      child: Transform.translate(offset: panOffset, child: widget.child),
    );
  }
}