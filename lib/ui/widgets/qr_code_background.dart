import 'package:flutter/material.dart';

class QRCodeBackground extends StatelessWidget {
  const QRCodeBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: ((context, constraints) {
        return CustomPaint(
          painter: _BackgroundPainter(
            Size(
              constraints.maxWidth,
              constraints.maxHeight,
            ),
            Size(
              MediaQuery.of(context).size.width / 1.75,
              MediaQuery.of(context).size.width / 1.75,
            ),
          ),
        );
      }),
    );
  }
}

class _BackgroundPainter extends CustomPainter {
  final Size backgroundSize;
  final Size qrCodeSize;

  _BackgroundPainter(this.backgroundSize, this.qrCodeSize);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black.withOpacity(.7);
    canvas.drawPath(
      Path.combine(
        PathOperation.difference,
        Path()
          ..addRect(
            Rect.fromLTRB(0, 0, backgroundSize.width, backgroundSize.height),
          ),
        Path()
          ..addRect(
            Rect.fromLTRB(
              backgroundSize.width / 2 - qrCodeSize.width / 2,
              backgroundSize.height / 2 - qrCodeSize.height / 2,
              backgroundSize.width / 2 + qrCodeSize.width / 2,
              backgroundSize.height / 2 + qrCodeSize.height / 2,
            ),
          ),
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
