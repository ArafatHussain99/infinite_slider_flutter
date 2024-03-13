import 'dart:math';

import 'package:flutter/material.dart';
import 'package:infinite_slider_flutter/features/home/presentation/widgets/dragable_widget.dart';

class InfiniteDragableSlider extends StatefulWidget {
  const InfiniteDragableSlider({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    this.index = 0,
  });

  final Function(BuildContext context, int index) itemBuilder;
  final int itemCount;
  final int index;

  @override
  State<InfiniteDragableSlider> createState() => _InfiniteDragableSliderState();
}

class _InfiniteDragableSliderState extends State<InfiniteDragableSlider> {
  Offset getOffset(int stackIndex) {
    return {
          0: Offset(0, 30),
          1: Offset(-70, 30),
          2: Offset(70, 30)
        }[stackIndex] ??
        Offset(0, 0);
  }

  double getAngle(int stackIndex) {
    return {0: 0.0, 1: -pi / 6, 2: pi / 6}[stackIndex] ?? 0.0;
  }

  double getScale(int stackIndex) {
    return {0: 0.6, 1: 0.9, 2: 0.95}[stackIndex] ?? 1;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(4, (stackIndex) {
        return Transform.translate(
          offset: getOffset(stackIndex),
          child: Transform.scale(
            scale: getScale(stackIndex),
            child: Transform.rotate(
              angle: getAngle(stackIndex),
              child: DragableWidget(
                child: widget.itemBuilder(context, stackIndex),
                isEnableDrag: stackIndex == 3,
              ),
            ),
          ),
        );
      }),
    );
  }
}