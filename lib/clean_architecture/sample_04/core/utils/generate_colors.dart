import 'package:flutter/material.dart';

List<Color> generateColors(Color baseColor) {
  HSVColor hsvColorBase = HSVColor.fromColor(baseColor);
  List<Color> colors = [];
  colors.add(baseColor);
  double step = (240 / 10);
  for (var i = 1; i <= 10; i++) {
    HSVColor hslColor = HSVColor.fromAHSV(
      hsvColorBase.alpha,
      (hsvColorBase.hue + (step * i)) % 240,
      hsvColorBase.saturation,
      hsvColorBase.value,
    );
    colors.add(hslColor.toColor());
  }
  return colors;
}
