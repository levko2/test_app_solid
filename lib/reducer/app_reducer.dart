import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test_app_solid/action/color_generator.dart';
import 'package:test_app_solid/models/app_state.dart';

AppState appStateReducer(AppState state, action) {
  return AppState(
      bgColor: changeBg(Random().nextInt(255), Random().nextInt(255),
          Random().nextInt(255), Random().nextInt(255), action));
}

Color changeBg(int a, int r, int g, int b, action) {
  if (action is ColorGenerationAction) return Color.fromARGB(a, r, g, b);
  return Colors.white;
}
