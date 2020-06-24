import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:skyline_university/Global/appBarLoginImage.dart';

import 'package:skyline_university/Global/rowSection.dart';

void main() => runApp(HomeSuggestion());

class Item {
  final name;
  final clipType;

  Item(this.name, this.clipType);
}

class HomeSuggestion extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeSuggestionState();
  }
}

class _HomeSuggestionState extends State<HomeSuggestion> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: Container(
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Column(
                children: <Widget>[
                  rowSection(context, 'images/orequest.png',
                      'images-white/orequest.png', 'Complains', "/complains"),
                  rowSection(
                      context,
                      'images/orequest.png',
                      'images-white/orequest.png',
                      'Suggestions',
                      "/suggestions"),
                  // rowSection(
                  //     context,
                  //     'images/orequest.png',
                  //     'images-white/orequest.png',
                  //     'Leave Application Form',
                  //     "/leaveApplicationForm"),
                ],
              ),
            ],
          ),
        ),
        key: _scaffoldKey,
        appBar: appBarLoginImage(context));
  }
}
