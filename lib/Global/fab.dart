import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:url_launcher/url_launcher.dart';

class NewFab extends StatefulWidget {
  @override
  _NewFabState createState() => _NewFabState();
}

class _NewFabState extends State<NewFab> with TickerProviderStateMixin {
  AnimationController _controller;

  static const List<IconData> icons = const [
    Icons.email,
    FontAwesomeIcons.rocketchat,
    Icons.phone
  ];

  void _pressFab(int id) {
    print("button pressed: $id");
    switch (id) {
      case 1:
        launch("mailto:info@firstart.ae");
        break;

      case 2:
        launch("http://m.me/217495261595386", forceSafariVC: false);
        break;

      case 3:
        phoneCall();
        break;
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
   Color backgroundColor = Colors.indigoAccent;
    Color foregroundColor = Colors.white;

    return new Column(
      mainAxisSize: MainAxisSize.min,
      children: new List.generate(icons.length, (int index) {
        Widget child = new Container(
          height: 70.0,
          width: 56.0,
          alignment: FractionalOffset.topCenter,
          child: new ScaleTransition(
            scale: new CurvedAnimation(
              parent: _controller,
              curve: new Interval(0.0, 1.0 - index / icons.length / 1.0,
                  curve: Curves.easeOut),
            ),
            child: new FloatingActionButton(
              heroTag: null,
              backgroundColor: backgroundColor,
              mini: true,
              child: new Icon(icons[index], color: foregroundColor),
              onPressed: () => _pressFab(index + 1),
            ),
          ),
        );
        return child;
      }).toList()
        ..add(
          new FloatingActionButton(
            backgroundColor: Colors.indigoAccent,
            foregroundColor: Colors.white,
            heroTag: null,
            child: new AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, Widget child) {
                return new Transform(
                  transform:
                      new Matrix4.rotationZ(_controller.value * 0.5 * math.pi),
                  alignment: FractionalOffset.center,
                  child: new Icon(
                    _controller.isDismissed
                        ? Icons.question_answer
                        : Icons.close,
                  ),
                );
              },
            ),
            onPressed: () {
              if (_controller.isDismissed) {
                _controller.forward();
              } else {
                _controller.reverse();
              }
            },
          ),
        ),
    );
  }
}
