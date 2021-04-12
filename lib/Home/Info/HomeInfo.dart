import 'package:flutter/material.dart';
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/rowSection.dart';

void main() => runApp(HomeInfo());

class Item {
  final name;
  final clipType;

  Item(this.name, this.clipType);
}

class HomeInfo extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeInfoState();
  }
}

class _HomeInfoState extends State<HomeInfo> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: true,
      appBar: appBar(context, 'SUC Info'),
      body: Container(
        child: ListView(
          children: <Widget>[
            FittedBox(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  rowSection(
                      context,
                      isDark(context)
                          ? 'images-white/admission.png'
                          : 'images/admission.png',
                      'images-white/admission.png',
                      'Virtual Tour',
                      '/virtual'),
                  rowSection(
                      context,
                      isDark(context)
                          ? 'images-white/admission.png'
                          : 'images/admission.png',
                      'images-white/admission.png',
                      'Faculty Members',
                      '/faculty'),
                  rowSection(
                      context,
                      isDark(context)
                          ? 'images-white/admission.png'
                          : 'images/admission.png',
                      'images-white/admission.png',
                      'SUC Info',
                      '/info'),
                  rowSection(
                      context,
                      isDark(context)
                          ? 'images-white/admission.png'
                          : 'images/admission.png',
                      'images-white/admission.png',
                      'Student Life',
                      '/studentLife'),
                  rowSection(
                      context,
                      isDark(context)
                          ? 'images-white/admission.png'
                          : 'images/admission.png',
                      'images-white/admission.png',
                      'Virtual Support',
                      '/virtualSupportList'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
