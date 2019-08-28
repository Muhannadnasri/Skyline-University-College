import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
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
  String comapny = '';
  String address = '';
  String city = '';
  String _country;
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
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      bottomNavigationBar: bottomappBar(
        context,
        () {
          if (_salaryCertificate.currentState.validate()) {
            _salaryCertificate.currentState.save();
            getSalaryCertificate();
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
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Purpose of the application',
                                style: TextStyle(color: Colors.grey[600]),
                              )),
                        ),
                        DropdownButton<String>(
                          isExpanded: true,
                          hint: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Select',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          value: purpose,
                          items: purposeJson
                                  ?.map(
                                    (item) => DropdownMenuItem<String>(
                                        value: item['purposeid'].toString(),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0, left: 8),
                                          child: Text(item['PurposeName']),
                                        )),
                                  )
                                  ?.toList() ??
                              [],
                          onChanged: (value) {
                            setState(() {
                              purpose = value;

                              print(purpose);
                            });
                          },
                        ),
                      ],
                    ),
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
                                  return 'Comapny is required';
                                }
                                return null;
                              }, (x) {
                                setState(() {
                                  comapny = x;
                                });
                              },
                                  'Company and address',
                                  true,
                                  TextInputType.text,
                                  FontAwesomeIcons.building,
                                  Colors.blue),
                              globalForms(context, '', (String value) {
                                if (value.trim().isEmpty) {
                                  return 'Address is required';
                                }
                                return null;
                              }, (x) {
                                setState(() {
                                  address = x;
                                });
                              }, 'Address', true, TextInputType.text,
                                  FontAwesomeIcons.mapMarkedAlt, Colors.blue),
                              globalForms(context, '', (String value) {
                                if (value.trim().isEmpty) {
                                  return 'City is required';
                                }
                                return null;
                              }, (x) {
                                setState(() {
                                  city = x;
                                });
                              }, 'City', true, TextInputType.text,
                                  FontAwesomeIcons.city, Colors.blue),
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
                                }, 'Other Purpose ', true, TextInputType.text,
                                    FontAwesomeIcons.question, Colors.blue),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 15,
                        ),
                        Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Country',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ),
                            ),
                            DropdownButton<String>(
                              value: _country,
                              isExpanded: true,
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Select',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                              items: countryJson
                                      ?.map((item) => DropdownMenuItem<String>(
                                          value: item['id'].toString(),
                                          child: Text(item['country'])))
                                      ?.toList() ??
                                  [],
                              onChanged: (value) {
                                setState(() {
                                  _country = value;
                                });
                              },
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
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
            'https://skylineportal.com/moappad/api/web/getSalaryPurposeTypeAndCountry'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
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

  Future getSalaryCertificate() async {
    Future.delayed(Duration.zero, () {});

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/salaryCertificateApplication'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'app_purpose': purpose,
          'country': _country,
          'others': other,
          'company_address': comapny,
          'address': address,
          'city': city,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            salaryCertificateJson = json.decode(response.body);
          },
        );
      }
      if (salaryCertificateJson['success'] == '0') {
        showLoading(false, context);
        Fluttertoast.showToast(
            msg: salaryCertificateJson['message'],
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
            context, getSalaryCertificate);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getSalaryCertificate);
      }
    }
  }
}
