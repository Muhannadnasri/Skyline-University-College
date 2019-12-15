import 'package:flutter/material.dart';

enum ClipType { waved }

class ZigZag extends StatelessWidget {
  Widget child;
  ClipType clipType;

  ZigZag({this.child, this.clipType = ClipType.waved});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: ZigZagClipper(clipType),
      child: child,
    );
  }
}

class ZigZagClipper extends CustomClipper<Path> {
  ClipType clipType;

  ZigZagClipper(this.clipType);

  @override
  Path getClip(Size size) {
    Path path = Path();

    if (clipType == ClipType.waved) {
      createWave(size, path);
    }
    path.close();
    return path;
  }

  createWave(Size size, Path path) {
    path.lineTo(0, size.height);
    path.quadraticBezierTo(
        size.width / 4, size.height - 40, size.width / 2, size.height - 20);
    path.quadraticBezierTo(
        3 / 4 * size.width, size.height, size.width, size.height - 30);
    path.lineTo(size.width, 0);
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
