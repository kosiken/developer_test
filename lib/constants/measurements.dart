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
    width = 1440.0;
    multiplier = width / referenceWidth;
    return;
  }
}
