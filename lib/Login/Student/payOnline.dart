import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

void main() => runApp(PayOnline());

class PayOnline extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PayOnlineState();
  }
}

// Map<String, int> body;

class _PayOnlineState extends State<PayOnline> {
  Map payOnlineJson;
  String feesPayOnline = 'feespayonline';

  void initState() {
    super.initState();
    getPayOnline();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: appBarLogin(context, 'Pay Online'),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: payOnlineJson == null
            ? SizedBox()
            : WebviewScaffold(
                hidden: true,
                withZoom: true,
                enableAppScheme: true,
                clearCache: true,
                clearCookies: true,
                scrollBar: true,
                url: payOnlineJson['data']),
      ),
    );
  }

  void _showError(String msg, IconData icon) {
    showLoading(false, context);
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
                    getPayOnline();
                  },
                  child: new Text('Try again'),
                ),
              ],
            ),
          );
        });
  }

  Future getPayOnline() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/getPayOnlineLink"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'pay_for': feesPayOnline,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1'
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          payOnlineJson = json.decode(response.body);
        });
        showLoading(false, context);
        if (payOnlineJson['success'] == '0') {
          showLoading(false, context);
          Fluttertoast.showToast(
              msg: payOnlineJson['message'],
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
}
