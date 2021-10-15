import 'dart:io';

import 'package:flutter/services.dart';

/// Singleton class to get the width of a device for
/// various purposes
class Measurements {
  double multiplier = 1;
  double width = 414.0;
  Measurements._privateConstructor();

// default Iphone 11 Screen width
  final double referenceWidth = 414.0;

  Measurements() {
    _getValues();
  }

  static final Measurements _instance = Measurements._privateConstructor();
  static Measurements get instance => _instance;
  double getValue(double value) => multiplier * value;

  void _getValues() async {
    if (!(Platform.isAndroid || Platform.isIOS)) {
      width = 1440.0;
      multiplier = width / referenceWidth;
      return;
    }
    const platform = const MethodChannel("medapp.relic.com/methods");
    if (!(Platform.isAndroid || Platform.isIOS)) return;
    try {
      final double result = await platform.invokeMethod('deviceWidth');
      width = result;
      multiplier = width / referenceWidth;
      // print(multiplier);
    } on PlatformException catch (e) {
      print("Failed to get the device dimensions '${e.message}'.");
    }
  }
}
