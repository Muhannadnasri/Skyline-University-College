import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.vertical(bottom: Radius.circular(50.0)),
              color: Color(0xFF275d9b),
            ),
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Image.asset(
                    "images/blob_2.png",
                    width: 352,
                    height: 343,
                    color: Color(0xFF0e4481),
                  ),
                  top: -100,
                  right: -130,
                ),
                Positioned(
                  child: Image.asset(
                    "images/blob_1.png",
                    width: 302,
                    height: 343,
                    color: Color(0xFF0e4481),
                  ),
                  top: 20,
                  left: -100,
                ),
              ],
            ),
          ),
          flex: 2,
        ),
        Expanded(
            child: Container(
              height: 300,
            ),
            flex: 1)
      ],
    );
  }
}
