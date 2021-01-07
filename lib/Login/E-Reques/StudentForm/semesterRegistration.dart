import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(SemesterRegistration());

class SemesterRegistration extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SemesterRegistrationState();
  }
}

// Map<String, int> body;

class _SemesterRegistrationState extends State<SemesterRegistration> {
  String date = DateFormat("yyyy-MM-dd").format(DateTime.now());

  final _semesterRegistration = GlobalKey<FormState>();

  List paymentRegistrationJson = [];
  bool isLoading = true;
  String remark = '';
  List<bool> selectedPaymnetJson = new List<bool>();
  int value;
  int selectedPayment;
  @override
  void initState() {
    super.initState();

    getPaymentRegistration();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     vottomSheetSuccess(context);
      //   },
      // ),
      resizeToAvoidBottomPadding: true,
      bottomNavigationBar: bottomappBar(
        context,
        () {
          if (_semesterRegistration.currentState.validate()
              // &&
              ) {
            _semesterRegistration.currentState.save();
            setState(() {
              insertSemesterRegistration();
            });
          }
          // showfailureSnackBar(context,
          //     'Your request submitted failed. Please contact IT department');
        },
      ),
      // bottomNavigationBar: BottomAppBar(
      //   elevation: 0,
      //   color: Colors.transparent,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       FloatingActionButton.extended(
      //         //
      //         backgroundColor:
      //             isDark(context) ? Color(0xFF121212) : Color(0xFF275d9b),

      //         label: const Text('Submit'),
      //         icon: const Icon(Icons.add),
      //         elevation: 4.0,
      //         // child: const Icon(Icons.add),
      //         onPressed: () {},
      //       ),
      //       // Material(
      //       //   borderRadius: BorderRadius.circular(25.0),
      //       //   color: isDark(context) ? Color(0xFF121212) : Color(0xFF275d9b),
      //       //   child: Padding(
      //       //     padding: const EdgeInsets.all(15.0),
      //       //     child: Text(
      //       //       "Submit",
      //       //       style: TextStyle(color: Colors.white, fontSize: 20),
      //       //     ),
      //       //   ),
      //       // ),
      //     ],
      //   ),
      // ),
      // bottomNavigationBar: bottomappBar(
      //   context,
      //   () {},
      // ),
      appBar: appBarLogin(context, 'Letter Request'),

      // appBar: appBarLogin(context, 'Letter Request'),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        // color: Color(0xffbF8F9FB),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  coursesReset(),

                  // letterRequest
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget coursesReset() {
    return Form(
      key: _semesterRegistration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mode of Payment: ',
            style:
                TextStyle(color: isDark(context) ? Colors.white : Colors.black),
          ),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            child: ListView.builder(
                shrinkWrap: true,
                itemCount: paymentRegistrationJson.length,
                itemBuilder: (context, index) {
                  return RadioListTile(
                    value: index,
                    groupValue: value,
                    onChanged: (ind) {
                      setState(() {
                        value = ind;
                        // print(selectedPayment);
                        selectedPayment =
                            paymentRegistrationJson[value]['DebitCategoryID'];
                      });
                    },
                    title: Text(
                      paymentRegistrationJson[index]['DebitCategoryName']
                          .toString(),
                      style: TextStyle(
                          color: isDark(context) ? Colors.white : Colors.black),
                    ),
                  );
                }),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'I hereby confirm that I have cleared all my dues and submitted cheque /auto debit authorization for the next semester.',
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: isDark(context) ? Colors.white : Colors.black),
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'Remarks',
            style:
                TextStyle(color: isDark(context) ? Colors.white : Colors.black),
          ),
          TextFormField(
            validator: (x) => x.isEmpty ? "Please enter remark" : null,
            onChanged: (x) {
              setState(() {
                // isEditing = true;
              });
            },
            // initialValue: widget.sessionId == null
            //     ? ''
            //     : widget.sessionInfo['remarks'],
            onSaved: (x) {
              setState(() {
                remark = x;
              });
              // sessionRemarks = x;
            },
            keyboardType: TextInputType.text,
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  Future getPaymentRegistration() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      selectedPaymnetJson = [];
      paymentRegistrationJson = [];
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/PaymentSemesterRegistration'),
        headers: {
          "API-KEY": API,
        },
      );

      if (response.statusCode == 200) {
        setState(
          () {
            paymentRegistrationJson = json.decode(response.body)['data'];
            for (int i = 0; i < paymentRegistrationJson.length; i++) {
              selectedPaymnetJson.add(false);
            }
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getPaymentRegistration);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getPaymentRegistration);
      }
    }
  }

  Future insertSemesterRegistration() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/InsertSemesterRegistrations'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'Stud_ID': username,
          'DebitCategoryID': selectedPayment.toString(),
          'Semester_ID': 'Semester_ID',
          'Remarks': remark,
          'IsOnline': '1',
          'CreatedBy': username,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        showLoading(false, context);

        vottomSheetSuccess(context);
      } else {
        showLoading(false, context);

        bottomSheetFailure(context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, insertSemesterRegistration);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            insertSemesterRegistration);
      }
    }

    //send confirmation
  }
}

//
