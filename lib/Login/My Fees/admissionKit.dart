import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Home/home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

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
Map<String, int> body;

class _AdmissionKitState extends State<AdmissionKit> {
  @override
  void initState() {
    myLedgerJson.clear();
    getMyLedger();
    getAdmissionKit();
    getInvoices();
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 70,
                  decoration: new BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF104C90),
                        Color(0xFF3773AC),
                      ],
                      stops: [
                        0.7,
                        0.9,
                      ],
                    ),
                  ),
                ), 


              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.arrow_back_ios,
                            size: 15,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Back',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "Admission Kit",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                     logOut(context);},
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.powerOff,
                            color: Colors.red[300],
                            size: 15,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Logout',
                            style: TextStyle(fontSize: 15, color: Colors.red),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //TODO: Put all Icon Container
          ],
        ),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
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
                                  child: Text("Download Your Ledger Fees"),
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
                                      launch(myLedgerJson['data'] ==      requestAmountJson.isEmpty ? '':myLedgerJson['data'] );
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

  void _showLoading(isLoading) {
    if (isLoading) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () {},
              child: new AlertDialog(
                title: Image.asset(
                  'images/logo.png',
                  height: 50,
                ),
                shape: SuperellipseShape(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                content: Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: new CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: new Text('Please Wait....'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    } else {
      Navigator.pop(context);
    }
  }

  void _showError(String msg, IconData icon) {
    _showLoading(false);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {},
            child: new AlertDialog(
              title: Image.asset(
                'images/logo.png',
                height: 50,
              ),
              shape: SuperellipseShape(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: new Icon(icon),
                    ),
                    new Text(msg)
                  ],
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    getMyLedger();
                  },
                  child: new Text('Try again'),
                ),
              ],
            ),
          );
        });
  }

  Future getMyLedger() async {
    Future.delayed(Duration.zero, () {
      _showLoading(true);

    });

    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/getDownloadLink"),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
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
          _showLoading(false);
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
        _showError("Time out from server", FontAwesomeIcons.hourglassHalf);
      } else {
        _showError("Sorry, we can't connect", Icons.perm_scan_wifi);
      }
    }
  }

  Future getAdmissionKit() async {
    Future.delayed(Duration.zero, () {
    });

    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/getDownloadLink"),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
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
        _showError("Time out from server", FontAwesomeIcons.hourglassHalf);
      } else {
        _showError("Sorry, we can't connect", Icons.perm_scan_wifi);
      }
    }
  }

  Future getInvoices() async {
    Future.delayed(Duration.zero, () {
    });

    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/getDownloadLink"),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
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

        _showLoading(false);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        _showError("Time out from server", FontAwesomeIcons.hourglassHalf);
      } else {
        _showError("Sorry, we can't connect", Icons.perm_scan_wifi);
      }
    }
  }
}
