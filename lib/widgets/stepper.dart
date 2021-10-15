import 'package:flutter/material.dart';

class StepperPainter extends CustomPainter {
  late int index;
  late int number;

  StepperPainter({required int index, required int number}) {
    this.index = index;
    this.number = number;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint2 = Paint()
      ..color = Color.fromRGBO(0x6b, 0x77, 0x9A, 0.24)
      ..style = PaintingStyle.fill;

    var n = 0;
    var start = 0;
    while (n < this.number) {
      if (n == index) {
        paintLarge(canvas, start);
        n++;
        start += 22;
        continue;
      }

      canvas.drawCircle(Offset(start + 3, 3), 3, paint2);
      start += 12;
      n++;
    }
  }

  void paintLarge(Canvas canvas, int start) {
    final paint1 = Paint()
      ..color = Color.fromRGBO(0x32, 0x95, 0xFF, 1)
      ..style = PaintingStyle.fill;

    canvas.drawRRect(
        RRect.fromRectAndRadius(
            Rect.fromCenter(center: Offset(start + 8, 3), width: 16, height: 6),
            Radius.circular(3)),
        paint1);
  }

  bool shouldRepaint(CustomPainter old) {
    return false;
  }
}

class KosyStepper extends StatelessWidget {
  final int index;
  final int number;

  const KosyStepper({required this.index, required this.number});

  Widget build(BuildContext context) {
    int less = number - 1;
    double width = (less * 12) + 16;
    Size size = Size(width, 6);

    return Container(
      child: CustomPaint(
        size: size,
        painter: StepperPainter(index: index, number: number),
      ),
    );
  }
}
