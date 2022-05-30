import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/customdropdown.dart';
import 'package:skyline_university/Global/dropDownWidget.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Login/E-Reques/StudentForm/dropList.dart';

void main() => runApp(AdmissionForm());

class AdmissionForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdmissionFormState();
  }
}

final personalDetails = GlobalKey<FormState>();

// Map<String, int> body;

class _AdmissionFormState extends State<AdmissionForm> {
  var countryNameCnt = TextEditingController();
  var countryIDCnt = TextEditingController();
  var programNameCnt = TextEditingController();
  var programIDCnt = TextEditingController();
  var knowNameCnt = TextEditingController();
  Map admissionForm = {};
  String fullName = '';
  bool isLoading = true;

  String mobile = '';
  String email = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBar(context, 'Application Form'),
      bottomNavigationBar: bottomappBar(
        context,
        () {
          if (personalDetails.currentState.validate() &&
              countryNameCnt != null &&
              programNameCnt != null &&
              knowNameCnt != null) {
            personalDetails.currentState.save();
            setState(() {
              sendAdmissionForm();
            });
          }
        },
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child:
            // admissionFormDropdownCountriesJson == null ||
            //         admissionFormDropdownCountriesJson.isEmpty
            //     ? exception(context, isLoading)
            //     :

            ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Form(
                    key: personalDetails,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        globalForms(
                          context,
                          '',
                          (String value) {
                            if (value.trim().isEmpty) {
                              return 'First name is requiblue';
                            }
                            return null;
                          },
                          (x) {
                            setState(() {
                              fullName = x;
                            });
                          },
                          'Full Name',
                          TextInputType.text,
                        ),
                        globalForms(
                          context,
                          '',
                          (String value) {
                            if (value.trim().isEmpty) {
                              return 'Email name is requiblue';
                            }
                            return null;
                          },
                          (x) {
                            setState(() {
                              email = x;
                            });
                          },
                          'Email',
                          TextInputType.emailAddress,
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Mobile Number',
                              style: TextStyle(
                                color: isDark(context)
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                            IntlPhoneField(
                              // onChanged: (phone) {
                              //   setState(() {
                              //     mobile = phone.completeNumber;
                              //     print(phone.completeNumber);
                              //   });
                              //   // print(phone.completeNumber);
                              // },
                              // textInputAction: TextInputAction.next,
                              initialValue: '',
                              initialCountryCode: 'AE',
                              // onChanged: onSaveds,
                              onSaved: (phone) {
                                setState(() {
                                  mobile = phone.completeNumber;
                                });
                              },
                              validator: (phone) {
                                if (phone.completeNumber.trim().isEmpty) {
                                  return 'Mobile is requiblue';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                              // textCapitalization: TextCapitalization.words,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black),
                              decoration: new InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: isDark(context)
                                        ? Colors.white.withOpacity(0.2)
                                        : Colors.black,
                                  ),
                                ),
                                fillColor: Colors.green,
                              ),
                            ),
                            SizedBox(
                              height: 25,
                            ),
                          ],
                        ),
                        // globalForms(
                        //   context,
                        //   '',
                        //   (String value) {
                        //     if (value.trim().isEmpty) {
                        //       return 'Mobile is requiblue';
                        //     }
                        //     return null;
                        //   },
                        //   (x) {
                        //     setState(() {
                        //       mobile = x;
                        //     });
                        //   },
                        //   'Mobile',
                        //   TextInputType.number,
                        // ),
                        countryWidget(),
                        programWidget(),
                        knowWidget(),
                      ],
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

  Widget countryWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Country',
          style:
              TextStyle(color: isDark(context) ? Colors.white : Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DropList(
                  type: 'Country',
                ),
              ),
            ).then((val) async {
              setState(() {
                countryNameCnt.text = val['NationalityName'];
                countryIDCnt.text = val['NationalityID'].toString();
              });
            });
          },
          child: AbsorbPointer(
            child: TextFormField(
              validator: (x) => x.isEmpty ? "Please select country" : null,
              onChanged: (x) {
                setState(() {
                  // isEditing = true;
                });
              },
              controller: countryNameCnt,
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Widget programWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Program',
          style:
              TextStyle(color: isDark(context) ? Colors.white : Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DropList(
                  type: 'Program',
                ),
              ),
            ).then((val) async {
              setState(() {
                programNameCnt.text = val['DegreeType_Desc'];
                programIDCnt.text = val['DegreeType_Id'].toString();
              });
            });
          },
          child: AbsorbPointer(
            child: TextFormField(
              validator: (x) => x.isEmpty ? "Please select Program" : null,
              onChanged: (x) {
                setState(() {
                  // isEditing = true;
                });
              },
              controller: programNameCnt,
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Widget knowWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How did you come to know?',
          style:
              TextStyle(color: isDark(context) ? Colors.white : Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DropList(
                  type: 'know',
                ),
              ),
            ).then((val) async {
              setState(() {
                knowNameCnt.text = val['know'];
              });
            });
          },
          child: AbsorbPointer(
            child: TextFormField(
              validator: (x) => x.isEmpty ? "Please select know us" : null,
              onChanged: (x) {
                setState(() {
                  // isEditing = true;
                });
              },
              controller: knowNameCnt,
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Future sendAdmissionForm() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.parse('https://skylineportal.com/moappad/api/test/admissionForm'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'FullName': fullName.toString(),
          'Email': email.toString(),
          'country_id': countryIDCnt.text.toString(),
          'MobileNO': mobile.toString(),
          'tbl_type': knowNameCnt.text.toString(),
          'ProgramofInterest': programIDCnt.text.toString(),
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            admissionForm = json.decode(response.body);
          },
        );
      }
      showLoading(false, context);

      if (admissionForm['success'] == '0') {
        bottomSheetFailure(context);
      }
      if (admissionForm['success'] == '1') {
        bottomSheetSuccess(context);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, sendAdmissionForm);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            sendAdmissionForm);
      }
    }
  }
}
