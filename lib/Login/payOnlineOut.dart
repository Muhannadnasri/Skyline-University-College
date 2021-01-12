import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:http/http.dart' as http;

import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Home/home.dart';

void main() => runApp(PayOnlineOut());

class PayOnlineOut extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PayOnlineOutState();
  }
}

// Map<String, int> body;

class _PayOnlineOutState extends State<PayOnlineOut> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  bool isLoading = true;
  Map payOnlineJson = {};
  void initState() {
    super.initState();
    getPayOnline();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GradientAppBar(
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              setState(() {
                // logOut(context);
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => Home()),
                    (Route<dynamic> route) => false);
              });
            },
            child: Icon(
              FontAwesomeIcons.home,
              color: Colors.white,
              size: 17,
            )),
        title: Text(
          'Pay Online',
          style: TextStyle(fontSize: 17),
        ),
        gradient: isDark(context)
            ? LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF121212),
                  Color(0xFF121212),
                ],
                stops: [
                  0.7,
                  0.9,
                ],
              )
            : LinearGradient(
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
      body: payOnlineJson == null || payOnlineJson.isEmpty
          ? exception(context, isLoading)
          : WebviewScaffold(
              withZoom: true,
              withJavascript: true,
              clearCache: true,
              clearCookies: true,
              scrollBar: true,
              url: payOnlineJson['data'] == null || payOnlineJson.isEmpty
                  ? 'https://www.skylineuniversity.ac.ae/'
                  : payOnlineJson['data'].toString()),
    );
  }

  Future getPayOnline() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/test/PayOnlineLink"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'pay_for': 'feespayonline',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          payOnlineJson = json.decode(response.body);
          isLoading = false;
        });
        showLoading(false, context);
        if (payOnlineJson['success'] == '0') {
          showfailureSnackBar(context, payOnlineJson['message']);
        }
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getPayOnline);
      } else {
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getPayOnline);
      }
    }
  }
}
