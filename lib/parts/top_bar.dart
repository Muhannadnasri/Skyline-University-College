import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      child: Container(
        height: 400.0,
      ),
      painter: CurvePainter(),
    );
  }
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path();
    Paint paint = Paint();

    // path.lineTo(0, size.height * 0.75);
    // path.quadraticBezierTo(size.width * 0.10, size.height * 0.70,
    //     size.width * 0.17, size.height * 0.90);
    // path.quadraticBezierTo(
    //     size.width * 0.20, size.height, size.width * 0.25, size.height * 0.90);
    // path.quadraticBezierTo(size.width * 0.40, size.height * 0.40,
    //     size.width * 0.50, size.height * 0.70);
    // path.quadraticBezierTo(size.width * 0.60, size.height * 0.85,
    //     size.width * 0.65, size.height * 0.65);
    // path.quadraticBezierTo(
    //     size.width * 0.70, size.height * 0.90, size.width, 0);
    // path.close();

    // paint.color = Color(0xFF3877b2);
    // canvas.drawPath(path, paint);

    // path = Path();
    // path.lineTo(0, size.height * 0.50);
    // path.quadraticBezierTo(size.width * 0.10, size.height * 0.80,
    //     size.width * 0.15, size.height * 0.60);
    // path.quadraticBezierTo(size.width * 0.20, size.height * 0.45,
    //     size.width * 0.27, size.height * 0.60);
    // path.quadraticBezierTo(
    //     size.width * 0.45, size.height, size.width * 0.50, size.height * 0.80);
    // path.quadraticBezierTo(size.width * 0.55, size.height * 0.45,
    //     size.width * 0.75, size.height * 0.75);
    // path.quadraticBezierTo(
    //     size.width * 0.85, size.height * 0.93, size.width, size.height * 0.60);
    // path.lineTo(size.width, 0);
    // path.close();

    // paint.color = Color(0xFF3773AC);
    // canvas.drawPath(path, paint);

    path = Path();
    path.lineTo(0, size.height * 0.75);
 path.lineTo(0, size.height - 80);
    path.lineTo(size.width * .7, size.height - 10);
    path.quadraticBezierTo(
        size.width * .8, size.height, size.width * .95, size.height * .90);

    path.lineTo(size.width, size.height*.87);
    path.lineTo(size.width, 0);



    path.lineTo(size.width, 0);
    path.close();

    paint.color = Color(0xFF144C90);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
