import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(PassportRetaining());

class PassportRetaining extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PassportRetainingState();
  }
}

final _reasonPassportRetaining = GlobalKey<FormState>();

bool terms = true;

// Map<String, int> body;

class _PassportRetainingState extends State<PassportRetaining> {
  Map passportRetainingJson = {};
  Map underTakingJson = {};
  String reasonPassportRetaining = '';

  @override
  void initState() {
    super.initState();
    underTakingJson.clear();
    getRequestFormsText();
    terms = false;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: appBarLogin(context, 'Passport Retaining'),
      bottomNavigationBar: bottomappBar(
        context,
        () {
          if (_reasonPassportRetaining.currentState.validate()) {
            _reasonPassportRetaining.currentState.save();
            sendPassportRetaining();
          }
        },
      ),
      body: underTakingJson == null || underTakingJson.isEmpty
          ? Container()
          : Container(
              child: ListView(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                    },
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            elevation: 10,
                            child: Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      underTakingJson.isEmpty
                                          ? ''
                                          : underTakingJson[
                                                      'personal_undertaking'] ==
                                                  null
                                              ? ''
                                              : underTakingJson[
                                                  'personal_undertaking'],
                                      style: TextStyle(
                                          color: isDark(context)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'I agree the terms and conditions',
                                          style: TextStyle(
                                              color: isDark(context)
                                                  ? Colors.white
                                                  : Colors.black),
                                        ),
                                        Checkbox(
                                          activeColor: Colors.blue,
                                          value: terms,
                                          onChanged: (value) {
                                            setState(() {
                                              terms = value;
                                            });
                                          },
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Form(
                          key: _reasonPassportRetaining,
                          child: globalForms(
                            context,
                            '',
                            (String value) {
                              if (value.trim().isEmpty) {
                                return 'Remark is required';
                              }
                              return null;
                            },
                            (x) {
                              setState(() {
                                reasonPassportRetaining = x;
                              });
                            },
                            'Remark',
                            TextInputType.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future getRequestFormsText() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getRequestFormsText'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': studentJson['data']['user_id'],
          'name': 'passportretainingterms',
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            underTakingJson = json.decode(response.body)['data'];
          },
        );

        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getRequestFormsText);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getRequestFormsText);
      }
    }
  }

  Future sendPassportRetaining() async {
    Future.delayed(Duration.zero, () {
      if (_reasonPassportRetaining.currentState.validate()) {
        _reasonPassportRetaining.currentState.save();
      }
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/passportRetaining'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': studentJson['data']['user_id'],
          'terms_condition': terms.toString(),
          'reason': reasonPassportRetaining,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            passportRetainingJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }

      if (passportRetainingJson['success'] == '1') {
        showLoading(false, context);
        Fluttertoast.showToast(
            msg: passportRetainingJson['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey[400],
            textColor: Colors.black87,
            fontSize: 13.0);
      }
      if (passportRetainingJson['success'] == '0') {
        showLoading(false, context);
        Fluttertoast.showToast(
            msg: passportRetainingJson['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey[400],
            textColor: Colors.black87,
            fontSize: 13.0);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, sendPassportRetaining);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            sendPassportRetaining);
      }
    }
  }
}
