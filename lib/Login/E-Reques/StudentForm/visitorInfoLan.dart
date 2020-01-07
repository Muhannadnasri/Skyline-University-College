import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skyline_university/Global/appBarLogin.dart';

void main() => runApp(VisitorInfoLan());

class VisitorInfoLan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VisitorInfoLanState();
  }
}

class _VisitorInfoLanState extends State<VisitorInfoLan> {
  @override
  void initState() {
    super.initState();

    // getCurrentAndNewShift();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: appBarLogin(
          context,
          'Visitor Information',
        ),
        body: ListView(
          children: <Widget>[
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/visitorInfoEn');
                      },
                      child: Container(
                          child: Icon(
                        Icons.language,
                        color: Colors.white,
                      ))),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/visitorInfoAr');
                      },
                      child: Container(
                          child: Icon(
                        Icons.local_drink,
                        color: Colors.white,
                      ))),
                ],
              ),
            )
          ],
        ));
  }
}
