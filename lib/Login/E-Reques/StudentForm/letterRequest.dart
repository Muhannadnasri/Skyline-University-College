import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'dropList.dart';

void main() => runApp(LetterRequest());

class LetterRequest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LetterRequestState();
  }
}

// Map<String, int> body;
final letterRequest = GlobalKey<FormState>();

class _LetterRequestState extends State<LetterRequest> {
  int miscID = 0;
  TextEditingController miscNameCnt = new TextEditingController();
  TextEditingController amountNameCnt = new TextEditingController();
  TextEditingController amountUrgentNameCnt = new TextEditingController();
  String addressTo = '';
  String remark = '';
  String requestType = '';
  int initialIndex = 0;

  bool isLoading = true;
  Map requestAmountJson = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      bottomNavigationBar: bottomappBar(
        context,
        () {
          if (letterRequest.currentState.validate()) {
            letterRequest.currentState.save();
            setState(() {
              sendOnlineRequest();
            });

            // showfailureSnackBar(context,
            //     'Your request submitted failed. Please contact IT department');
          }
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
                  requestTypeWidget(),
                  amount(),
                  amountUrgent(),
                  switchAmount(),
                  remarkAndAddressWidget(),
                  // letterRequest
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget requestTypeWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Request Type',
          style:
              TextStyle(color: isDark(context) ? Colors.white : Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DropList(
                  type: 'LETTER',
                ),
              ),
            ).then((val) async {
              setState(() {
                // miscName = val['MiscName'];
                miscID = val['MiscID'];
                miscNameCnt.text = val['MiscName'];
                getAmount();

                // print(requestAmountJson['data']['NormalFees']);
              });
            });
          },
          child: AbsorbPointer(
            child: TextFormField(
              validator: (x) => x.isEmpty ? "Please select request type" : null,
              onChanged: (x) {
                setState(() {
                  // isEditing = true;
                });
              },
              controller: miscNameCnt,
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Widget amount() {
    if (requestAmountJson['success'] == '1') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Normal Amount',
            style:
                TextStyle(color: isDark(context) ? Colors.white : Colors.black),
          ),
          IgnorePointer(
            child: AbsorbPointer(
              child: TextFormField(
                validator: (x) =>
                    x.isEmpty ? "Please select request type" : null,
                onChanged: (x) {
                  setState(() {
                    // isEditing = true;
                  });
                },
                controller: amountNameCnt,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
        ],
      );
    } else if (requestAmountJson['success'] == '0' ||
        requestAmountJson == null ||
        requestAmountJson.isEmpty) {
      return SizedBox();
    }
  }

  Widget amountUrgent() {
    if (requestAmountJson['success'] == '1' &&
        requestAmountJson['data']['UrgentFees'] != '0') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Urgent Amount',
            style:
                TextStyle(color: isDark(context) ? Colors.white : Colors.black),
          ),
          IgnorePointer(
            child: AbsorbPointer(
              child: TextFormField(
                validator: (x) =>
                    x.isEmpty ? "Please select request type" : null,
                onChanged: (x) {
                  setState(() {
                    // isEditing = true;
                  });
                },
                controller: amountUrgentNameCnt,
              ),
            ),
          ),
          SizedBox(
            height: 25,
          )
        ],
      );
    } else if (requestAmountJson == null ||
        requestAmountJson.isEmpty ||
        requestAmountJson['success'] == '0' ||
        requestAmountJson['data']['UrgentFees'] == '0') {
      return SizedBox();
    }
  }

  Widget switchAmount() {
    if (requestAmountJson['success'] == '1') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Request Type',
            style:
                TextStyle(color: isDark(context) ? Colors.white : Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          ToggleSwitch(
            minWidth: 90.0,
            initialLabelIndex: initialIndex,
            cornerRadius: 10.0,
            activeFgColor: Colors.white,
            inactiveBgColor: Colors.grey,
            inactiveFgColor: Colors.white,
            labels: ['Normal', 'Urgent'],
            activeBgColors: [Colors.green, Colors.red],
            onToggle: (index) {
              print('switched to: $index');
              setState(() {
                initialIndex = index;
                switch (initialIndex) {
                  case 0:
                    {
                      setState(() {
                        requestType = 'Normal';
                      });
                    }

                    break;
                  case 1:
                    {
                      setState(() {
                        requestType = 'Urgent';
                      });
                    }
                    break;
                  default:
                    {
                      setState(() {
                        requestType = 'Normal';
                      });
                    }
                }
              });
            },
          ),
          SizedBox(
            height: 25,
          ),
        ],
      );
    } else if (requestAmountJson['success'] == '0' ||
        requestAmountJson == null ||
        requestAmountJson.isEmpty) {
      return SizedBox();
    }
  }

  Widget remarkAndAddressWidget() {
    return Form(
      key: letterRequest,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          globalForms(
            context,
            '',
            (String value) {
              if (value.trim().isEmpty) {
                return 'Please enter address to';
              }
              return null;
            },
            (x) {
              setState(() {
                addressTo = x;
              });
            },
            'Address To',
            TextInputType.text,
          ),
        ],
      ),
    );
  }

  Future getAmount() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/OnlineRequestFees'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'MiscID': miscID.toString(),
          'Stud_ID': username,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            requestAmountJson = json.decode(response.body);
            amountNameCnt.text = requestAmountJson.isEmpty ||
                    requestAmountJson == null ||
                    requestAmountJson['data'] == null
                ? ''
                : requestAmountJson['data']['NormalFees'] == ("NA")
                    ? "Not Avalible"
                    : requestAmountJson['data']['NormalFees'].toString();

            amountUrgentNameCnt.text = requestAmountJson.isEmpty ||
                    requestAmountJson == null ||
                    requestAmountJson['data'] == null
                ? ''
                : requestAmountJson['data']['UrgentFees'] == ("NA")
                    ? "Not Avalible"
                    : requestAmountJson['data']['UrgentFees'].toString();
          },
        );

        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getAmount);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getAmount);
      }
    }
  }

  Future sendOnlineRequest() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/onlineRequest'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'StudentID': 'testuser',
          // username,
          'RequestType': requestType,
          'RequestTypeid': miscID.toString(),
          'AddressTo': addressTo,
          'Remarks': remark,
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
            context, sendOnlineRequest);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            sendOnlineRequest);
      }
    }
  }
}
