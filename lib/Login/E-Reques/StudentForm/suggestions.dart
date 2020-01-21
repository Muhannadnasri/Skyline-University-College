import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';

import 'package:skyline_university/Global/dropDownWidget.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(Suggestions());

class Suggestions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SuggestionsState();
  }
}

final _generalAppointment = GlobalKey<FormState>();

// Map<String, int> body;

class _SuggestionsState extends State<Suggestions> {
  List generalAPPtJson = [];

  Map generalRequestJson = {};
  String studentDescription = '';

  String _categoryID;

  @override
  void initState() {
    super.initState();

    getGeneralApptCatDeptTime();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      bottomNavigationBar: generalAPPtJson.isEmpty
          ? Container()
          : bottomappBar(
              context,
              () {
                setState(() {
                  if (_generalAppointment.currentState.validate() &&
                      _categoryID != null) {
                    _generalAppointment.currentState.save();
                    sendGeneralAppointment();
                  }
                });
              },
            ),
      appBar: appBarLogin(context, 'Suggestions'),
      body: generalAPPtJson.isEmpty
          ? Container()
          : GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: ListView(
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      SizedBox(
                        height: 25,
                      ),
                      dropDownWidget(
                          context,
                          'Select Option',
                          _categoryID,
                          generalAPPtJson,
                          'CATEGORY_ID',
                          'CATEGORY_DESCRIPTION', (value) {
                        setState(() {
                          _categoryID = value;
                          getGeneralApptCatDeptTime();
                        });
                      }, 'Case Category'),
                      SizedBox(
                        height: 5,
                      ),
                      Form(
                        key: _generalAppointment,
                        child: globalForms(
                          context,
                          '',
                          (String value) {
                            if (value.trim().isEmpty) {
                              return 'Reason is required';
                            }
                            return null;
                          },
                          (x) {
                            setState(() {
                              studentDescription = x;
                            });
                          },
                          'Reason',
                          TextInputType.text,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }

  Future getGeneralApptCatDeptTime() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/GeneralApptCatDeptTime'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'usertype': studentJson['data']['user_type'],
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            generalAPPtJson = json.decode(response.body)['data']['category'];
          },
        );

        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getGeneralApptCatDeptTime);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getGeneralApptCatDeptTime);
      }
    }
  }

  Future sendGeneralAppointment() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/generalAppointment'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'Stud_ID': username,
          'CASETYPE_ID': '2',
          'CATEGORY_ID': _categoryID.toString(),
          'StudentDescription': studentDescription,
        },
      );
      if (response.statusCode == 200) {
        setState(
          () {
            generalRequestJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
        if (generalRequestJson['success'] == '0') {
          showfailureSnackBar(context, generalRequestJson['message']);
        }
        if (generalRequestJson['success'] == '1') {
          showSuccessSnackBar(context, generalRequestJson['message']);
        }
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, sendGeneralAppointment);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            sendGeneralAppointment);
      }
    }
  }
}
