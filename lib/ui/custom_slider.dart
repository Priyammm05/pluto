import 'dart:ui';

import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final ValueChanged<double> onChanged;
  final double value;
  final double? min;
  final double? max;
  final String? label;
  final String? valueLabel;

  const CustomSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min,
    this.max,
    this.label,
    this.valueLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (label != null) ...[
          Text(label!),
          const SizedBox(height: 12),
        ],
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: const SliderThemeData(
                  thumbShape: RectangleThumbShape(),
                  overlayShape: RectangleThumbShape(),
                  trackHeight: 4,
                  trackShape: RectangularSliderTrackShape(),
                ),
                child: Slider(
                  value: value,
                  min: min ?? 0,
                  max: max ?? 100,
                  activeColor: Colors.black,
                  inactiveColor: Colors.black.withOpacity(0.1),
                  onChanged: onChanged,
                ),
              ),
            ),
            const SizedBox(width: 8),
            if (valueLabel != null)
              ColoredBox(
                color: Colors.grey.shade200,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  child: Text(
                    valueLabel!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      height: 1.2,
                      fontFeatures: [
                        FontFeature.tabularFigures(),
                      ],
                    ),
                  ),
                ),
              ),
            const SizedBox(width: 6),
          ],
        ),
      ],
    );
  }
}

class RectangleThumbShape extends SliderComponentShape {
  final double width;
  final double height;

  const RectangleThumbShape({this.width = 10, this.height = 22});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size(width, height);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    assert(sliderTheme.thumbColor != null);

    final Canvas canvas = context.canvas;
    final topLeft = center.translate(-width / 2, -height / 2);
    canvas.drawRect(topLeft & Size(width, height),
        Paint()..color = sliderTheme.thumbColor!);
  }
}
