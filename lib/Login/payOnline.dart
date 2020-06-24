import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(PayOnline());

class PayOnline extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PayOnlineState();
  }
}

// Map<String, int> body;

class _PayOnlineState extends State<PayOnline> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  Map payOnlineJson = {};
  void initState() {
    super.initState();
    getPayOnline();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: appBarLogin(context, 'Pay Online'),
      body: payOnlineJson == null || payOnlineJson.isEmpty
          ? exception(context)
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
