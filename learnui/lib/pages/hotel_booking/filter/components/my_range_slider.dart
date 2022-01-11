import 'package:flutter/material.dart';
import 'package:learnui/pages/hotel_booking/theme.dart';

class MyRangeSlider extends StatelessWidget {
  const MyRangeSlider({
    Key? key,
    required this.onChangeRangeValues,
    required this.values,
  }) : super(key: key);

  final Function(RangeValues) onChangeRangeValues;
  final RangeValues values;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Stack(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  flex: values.start.round(),
                  child: const SizedBox(),
                ),
                SizedBox(
                  width: 54,
                  child: Text(
                    '\$${values.start.round()}',
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1000 - values.start.round(),
                  child: const SizedBox(),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: values.end.round(),
                  child: const SizedBox(),
                ),
                SizedBox(
                  width: 54,
                  child: Text(
                    '\$${values.end.round()}',
                    textAlign: TextAlign.center,
                  ),
                ),
                Expanded(
                  flex: 1000 - values.end.round(),
                  child: const SizedBox(),
                ),
              ],
            ),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            rangeThumbShape: CustomRangeThumbShape(),
          ),
          child: RangeSlider(
            values: values,
            min: 0.0,
            max: 1000.0,
            activeColor: HotelBookingTheme.buildLightTheme().primaryColor,
            inactiveColor: Colors.grey.withOpacity(0.4),
            divisions: 1000,
            onChanged: (v) {
              try {
                onChangeRangeValues(v);
              } catch (e) {
                print(e);
              }
            },
          ),
        ),
      ],
    );
  }
}

class CustomRangeThumbShape extends RangeSliderThumbShape {
  static const double _thumbSize = 3.0;
  static const double _disabledThumbSize = 3.0;

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return isEnabled
        ? const Size.fromRadius(_thumbSize)
        : const Size.fromRadius(_disabledThumbSize);
  }

  static final Animatable<double> sizeTween = Tween<double>(
    begin: _disabledThumbSize,
    end: _thumbSize,
  );

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    bool? isPressed,
    required SliderThemeData sliderTheme,
    TextDirection textDirection = TextDirection.ltr,
    Thumb thumb = Thumb.start,
  }) {
    final Canvas canvas = context.canvas;
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );

    final double size = _thumbSize * sizeTween.evaluate(enableAnimation);
    Path thumbPath;
    switch (textDirection) {
      case TextDirection.rtl:
        switch (thumb) {
          case Thumb.start:
            thumbPath = _rightTriangle(size, center);
            break;
          case Thumb.end:
            thumbPath = _leftTriangle(size, center);
            break;
        }
        break;
      case TextDirection.ltr:
        switch (thumb) {
          case Thumb.start:
            thumbPath = _leftTriangle(size, center);
            break;
          case Thumb.end:
            thumbPath = _rightTriangle(size, center);
            break;
        }
        break;
    }

    canvas.drawPath(
        Path()
          ..addOval(Rect.fromPoints(Offset(center.dx + 12, center.dy + 12),
              Offset(center.dx - 12, center.dy - 12)))
          ..fillType = PathFillType.evenOdd,
        Paint()
          ..color = Colors.black.withOpacity(0.5)
          ..maskFilter =
              MaskFilter.blur(BlurStyle.normal, convertRadiusToSigma(8)));

    final Paint cPaint = Paint();
    cPaint.color = Colors.white;
    cPaint.strokeWidth = 14 / 2;
    canvas.drawCircle(Offset(center.dx, center.dy), 12, cPaint);
    cPaint.color = colorTween.evaluate(enableAnimation)!;
    canvas.drawCircle(Offset(center.dx, center.dy), 10, cPaint);
    canvas.drawPath(thumbPath, Paint()..color = Colors.white);
  }

  double convertRadiusToSigma(double radius) {
    return radius * 0.57735 + 0.5;
  }

  Path _rightTriangle(double size, Offset thumbCenter, {bool invert = false}) {
    final Path thumbPath = Path();
    final double sign = invert ? -1.0 : 1.0;
    thumbPath.moveTo(thumbCenter.dx + 5 * sign, thumbCenter.dy);
    thumbPath.lineTo(thumbCenter.dx - 3 * sign, thumbCenter.dy - 5);
    thumbPath.lineTo(thumbCenter.dx - 3 * sign, thumbCenter.dy + 5);
    thumbPath.close();
    return thumbPath;
  }

  Path _leftTriangle(double size, Offset thumbCenter) =>
      _rightTriangle(size, thumbCenter, invert: true);
}
