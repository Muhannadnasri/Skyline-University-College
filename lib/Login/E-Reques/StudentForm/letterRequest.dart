import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/customdropdown.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';

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
  List sendletterRequestJson = [];
  TextEditingController urgentAmount = new TextEditingController();
  TextEditingController normalAmount = new TextEditingController();

  Map requestAmountJson = {};
  List letterRequestTypeJson = [];
  String requestId;
  String address = '';
  String remark = '';
  @override
  void initState() {
    super.initState();

    getRequestType();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      bottomNavigationBar: BottomAppBar(

        elevation: 0,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FloatingActionButton.extended(
              //
              backgroundColor:
                  isDark(context) ? Color(0xFF121212) : Color(0xFF275d9b),

              label: const Text('Submit'),
              icon: const Icon(Icons.add),
              elevation: 4.0,
              // child: const Icon(Icons.add),
              onPressed: () {},
            ),
            // Material(
            //   borderRadius: BorderRadius.circular(25.0),
            //   color: isDark(context) ? Color(0xFF121212) : Color(0xFF275d9b),
            //   child: Padding(
            //     padding: const EdgeInsets.all(15.0),
            //     child: Text(
            //       "Submit",
            //       style: TextStyle(color: Colors.white, fontSize: 20),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
      // bottomNavigationBar: bottomappBar(
      //   context,
      //   () {},
      // ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        // leading: Icon(
        //   Icons.chevron_left,
        //   size: 30,
        //   color: Colors.black,
        // ),
        // title: Text(
        //   'Letter Request',
        //   style: TextStyle(color: Colors.black),
        // ),
        // flexibleSpace: FlexibleSpaceBar(

        //   collapseMode: CollapseMode.pin,
        //   centerTitle: true,
        //   title: Text(
        //     'Letter Request',
        //     style: TextStyle(color: Colors.black),
        //   ),
        // ),
      ),

      // appBar: appBarLogin(context, 'Letter Request'),
      body: letterRequestTypeJson == null || letterRequestTypeJson.isEmpty
          ? exception(context)
          : Container(
              color: Color(0xffbF8F9FB),
              child: ListView(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 5,
                      left: 30,
                    ),
                    child: Container(
                      child: Text(
                        'Letter Request',
                        style: TextStyle(
                            fontSize: 23, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      margin: EdgeInsets.all(20.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      color: Color(0xffbFFFFFF),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ListView(
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          children: <Widget>[
                            // Center(
                            //   child: Text('Enter Details'),
                            // ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 0.0, 20.0, 5.0),
                                child: Text(
                                  'Request Type',
                                  style: TextStyle(
                                    color: isDark(context)
                                        ? Colors.white
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ),

                            CustomDropDown(
                              isExpanded: true,
                              items: letterRequestTypeJson
                                      ?.map(
                                        (item) => DropdownMenuItem<String>(
                                          value: item['MiscID'].toString(),
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20.0, 0.0, 20.0, 5.0),
                                            child: FittedBox(
                                              child: Text(
                                                item['MiscName'].toString(),
                                                style: TextStyle(
                                                    color: isDark(context)
                                                        ? Colors.white
                                                        : Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                      ?.toList() ??
                                  [],
                              value: requestId,
                              hint: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                    20.0, 0.0, 20.0, 5.0),
                                child: new Text(
                                  'Select One',
                                  style: TextStyle(
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.black),
                                ),
                              ),
                              underline: Container(
                                height: 1,
                                color: Color(0xFF2f2f2f),
                              ),
                              searchHint: new Text(
                                'Select One',
                                style: new TextStyle(
                                    fontSize: 20,
                                    color: isDark(context)
                                        ? Colors.white
                                        : Colors.black),
                              ),
                              onChanged: (value) {
                                setState(() async {
                                  requestId = value;
                                  getAmount();
                                });
                              },
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: Text(
                                    'Normal Amount',
                                    style: TextStyle(
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10.0, 0.0, 20.0, 5.0),
                                  child: TextFormField(
                                    controller: normalAmount,
                                    style: TextStyle(
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black),
                                    enabled: false,
                                    decoration: new InputDecoration(
                                      disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: isDark(context)
                                              ? Colors.white.withOpacity(0.2)
                                              : Colors.black,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          15.0, 0.0, 20.0, 5.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      20.0, 0.0, 20.0, 0.0),
                                  child: Text(
                                    'Urgent Amount',
                                    style: TextStyle(
                                      color: isDark(context)
                                          ? Colors.white
                                          : Colors.grey,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      10.0, 0.0, 20.0, 5.0),
                                  child: TextFormField(
                                    controller: urgentAmount,
                                    style: TextStyle(
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black),
                                    enabled: false,
                                    decoration: new InputDecoration(
                                      disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color: isDark(context)
                                              ? Colors.white.withOpacity(0.2)
                                              : Colors.black,
                                        ),
                                      ),
                                      contentPadding: const EdgeInsets.fromLTRB(
                                          15.0, 0.0, 20.0, 5.0),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Form(
                              key: letterRequest,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  globalForms(context, '', (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Address  is required';
                                    }
                                    return null;
                                  }, (x) {
                                    setState(() {
                                      address = x;
                                    });
                                  }, 'Address', TextInputType.text),
                                  globalForms(context, '', (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Remark is required';
                                    }
                                    return null;
                                  }, (x) {
                                    setState(() {
                                      remark = x;
                                    });
                                  }, 'Remark', TextInputType.text),
                                ],
                              ),
                            ),

                            SizedBox(
                              height: 10,
                            ),

                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Future getRequestType() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/OnlineRequestOnline'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'Operation': 'LETTER',
        },
      );

      if (response.statusCode == 200) {
        setState(
          () {
            letterRequestTypeJson = json.decode(response.body)['data'];
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getRequestType);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getRequestType);
      }
    }
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
          'MiscID': requestId,
          'Stud_ID':username
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            requestAmountJson = json.decode(response.body);
            normalAmount.text =
                requestAmountJson.isEmpty || requestAmountJson == null
                    ? ''
                    : requestAmountJson['data']['NormalFees'] == ("NA")
                        ? "Not Avalible"
                        : requestAmountJson['data']['NormalFees'].toString();
            urgentAmount.text = requestAmountJson == null
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
          'user_id': username,
          // 'request_type': requestAmountJson['data']['MiscName'],
          // 'request_process': groupValue == 1 ? "Normal" : "Urgent",
          // 'address': address,
          // 'remarks': remark,
          // 'amount': groupValue == 1 ? "NormalAmount" : "UrgentAmount",
          // 'BatchCode': againstMarksJson[i]['BatchCode'],
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        sendletterRequestJson = json.decode(response.body)['data'];
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

    showLoading(false, context);
  }
}
