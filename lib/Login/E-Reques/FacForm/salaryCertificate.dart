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

void main() => runApp(SalaryCertificate());

class SalaryCertificate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SalaryCertificateState();
  }
}

final _salaryCertificate = GlobalKey<FormState>();
final _other = GlobalKey<FormState>();

// Map<String, int> body;

class _SalaryCertificateState extends State<SalaryCertificate> {
  Map salaryCertificateJson = {};
  List purposeJson = [];
  List countryJson = [];
  String address = '';
  String city = '';
  String country;
  String purpose;
  String other = '';
  // String other = '';

  @override
  void initState() {
    super.initState();
    getSalaryPurposeTypeAndCountry();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      bottomNavigationBar: bottomappBar(
        context,
        () {
          if (_salaryCertificate.currentState.validate()) {
            _salaryCertificate.currentState.save();
            sendSalaryCertificate();
          } else if (purpose == 'Others' && _other.currentState.validate())
            _other.currentState.save();
        },
      ),
      resizeToAvoidBottomPadding: true,
      appBar: appBarLogin(context, 'Salary Certificate'),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
          child: ListView(
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  dropDownWidget(context, 'Select Option', purpose, purposeJson,
                      'purposeid', 'PurposeName', (value) {
                    setState(() {
                      purpose = value;
                    });
                  }, 'Purpose of the application'),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: <Widget>[
                      Form(
                        key: _salaryCertificate,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            globalForms(context, '', (String value) {
                              if (value.trim().isEmpty) {
                                return 'Address is required';
                              }
                              return null;
                            }, (x) {
                              setState(() {
                                address = x;
                              });
                            }, 'Address', TextInputType.text),
                            globalForms(context, '', (String value) {
                              if (value.trim().isEmpty) {
                                return 'City is required';
                              }
                              return null;
                            }, (x) {
                              setState(() {
                                city = x;
                              });
                            }, 'City', TextInputType.text),
                          ],
                        ),
                      ),
                      purpose == '12'
                          ? Form(
                              key: _other,
                              child: globalForms(context, '', (String value) {
                                if (value.trim().isEmpty) {
                                  return 'other is required';
                                }
                                return null;
                              }, (x) {
                                setState(() {
                                  other = x;
                                });
                              }, 'Other Purpose ', TextInputType.text),
                            )
                          : SizedBox(),
                      SizedBox(
                        height: 15,
                      ),
                      dropDownWidget(context, 'Select Option', country,
                          countryJson, 'id', 'country', (value) {
                        setState(() {
                          country = value;
                        });
                      }, 'Country'),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future getSalaryPurposeTypeAndCountry() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/SalaryPurposeTypeAndCountry'),
        headers: {
          "API-KEY": API,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            purposeJson = json.decode(response.body)['data']['purpose_types'];
            countryJson = json.decode(response.body)['data']['country'];
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getSalaryPurposeTypeAndCountry);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getSalaryPurposeTypeAndCountry);
      }
    }
  }

  Future sendSalaryCertificate() async {
    Future.delayed(Duration.zero, () {});

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/salaryCertificateApplication'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'empid': studentJson['data']['user_id'],
          'PurposeID': purpose,
          'City': city,
          'Others': other,
          'Country': country,
          'address': address,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            salaryCertificateJson = json.decode(response.body);
          },
        );
      }
      showSuccessSnackBar(context, salaryCertificateJson['message']);
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, sendSalaryCertificate);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            sendSalaryCertificate);
      }
    }
  }
}
