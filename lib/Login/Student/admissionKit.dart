import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(AdmissionKit());

class AdmissionKit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdmissionKitState();
  }
}

String ledger = 'ledger';
String invoices = 'invoices';

String admissionkit = 'admissionkit';
// Map<String, int> body;

class _AdmissionKitState extends State<AdmissionKit> {
  Map requestAmountJson = {};
  Map admissionKitJson = {};
  Map invoicesJson = {};
  Map myLedgerJson = {};
  @override
  void initState() {
    getMyLedger();
    getAdmissionKit();
    getInvoices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: appBarLogin(context, 'Admission Kit'),
      body: Container(
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    elevation: 10,
                    child: DottedBorder(
                      color: Colors.blue,
                      gap: 3,
                      strokeWidth: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0),
                            child: Text("Download Your Ledger Fees"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 15.0, top: 5),
                            child: InkWell(
                              child: Text(
                                'Download',
                                style: TextStyle(color: Colors.blue),
                              ),
                              onTap: () {
                                launch(myLedgerJson['data'] ==
                                        requestAmountJson.isEmpty
                                    ? ''
                                    : myLedgerJson['data']);
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: admissionKitJson == null
                      ? Center(child: Text(''))
                      : Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          elevation: 10,
                          child: DottedBorder(
                            color: Colors.blue,
                            gap: 3,
                            strokeWidth: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text("Download Your Admission Kit"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15.0, top: 5),
                                  child: InkWell(
                                    child: Text(
                                      'Download',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    onTap: () {
                                      launch(admissionKitJson['data']);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: invoicesJson == null
                      ? Center(child: Text(''))
                      : Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          elevation: 10,
                          child: DottedBorder(
                            color: Colors.blue,
                            gap: 3,
                            strokeWidth: 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text("Download Your Invoices"),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15.0, top: 5),
                                  child: InkWell(
                                    child: Text(
                                      'Download',
                                      style: TextStyle(color: Colors.blue),
                                    ),
                                    onTap: () {
                                      launch(invoicesJson['data']);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future getMyLedger() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/getDownloadLink"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'type': ledger,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1'
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          myLedgerJson = json.decode(response.body);
        });

        if (myLedgerJson['success'] == '0') {
          showLoading(false, context);
          Fluttertoast.showToast(
              msg: myLedgerJson['message'],
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIos: 1,
              backgroundColor: Colors.grey[400],
              textColor: Colors.black87,
              fontSize: 13.0);
        }
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getMyLedger);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getMyLedger);
      }
    }
  }

  Future getAdmissionKit() async {
    Future.delayed(Duration.zero, () {});

    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/getDownloadLink"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'type': admissionkit,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1'
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          admissionKitJson = json.decode(response.body);
        });
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getAdmissionKit);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getAdmissionKit);
      }
    }
  }

  Future getInvoices() async {
    Future.delayed(Duration.zero, () {});

    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/getDownloadLink"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'type': invoices,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1'
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          invoicesJson = json.decode(response.body);
        });

        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getInvoices);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getInvoices);
      }
    }
  }
}
