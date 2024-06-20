import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ColorState extends StateNotifier<Color> {
  ColorState() : super(Colors.blue); 

  void changeColor(Color newColor) {
    state = newColor;
  }
}

Color getTextColorForBackground(Color backgroundColor) {
  return backgroundColor.computeLuminance() > 0.5 ? Colors.black : Colors.white;
}

final colorProvider = StateNotifierProvider<ColorState, Color>((ref) {
  return ColorState();
});
