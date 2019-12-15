// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:skyline_university/Global/appBarLogin.dart';
// import 'package:skyline_university/Global/global.dart';

// void main() => runApp(PayOnline());

// class PayOnline extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _PayOnlineState();
//   }
// }

// // Map<String, int> body;

// class _PayOnlineState extends State<PayOnline> {
//   Map payOnlineJson;

//   void initState() {
//     super.initState();
//     getPayOnline();
//   }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setEnabledSystemUIOverlays([]);
//     return Scaffold(
//       appBar: appBarLogin(context, 'Pay Online'),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: MediaQuery.of(context).size.width,
//         child: payOnlineJson == null
//             ? SizedBox()
//             : WebviewScaffold(
              
//                 hidden: true,
//                 withZoom: true,
//                 enableAppScheme: true,
//                 clearCache: true,
//                 clearCookies: true,
//                 scrollBar: true,
                
//                 url: payOnlineJson == null
//                     ? 'https://skylineuniversity.ac.ae/'
//                     : payOnlineJson['data']),
//       ),
//     );
//   }

//   Future getPayOnline() async {
//     Future.delayed(Duration.zero, () {
//       showLoading(true, context);
//     });

//     try {
//       http.Response response = await http.post(
//         Uri.encodeFull(
//             "https://skylineportal.com/moappad/api/web/getPayOnlineLink"),
//         headers: {
//           "API-KEY": API,
//         },
//         body: {
//           'user_id': username,
//           'pay_for': 'feespayonline',
//           'usertype': studentJson['data']['user_type'],
//           'ipaddress': '1',
//           'deviceid': '1',
//           'devicename': '1'
//         },
//       ).timeout(Duration(seconds: 35));

//       if (response.statusCode == 200) {
//         setState(() {
//           payOnlineJson = json.decode(response.body);
//         });
//         showLoading(false, context);
//         if (payOnlineJson['success'] == '0') {
//           showLoading(false, context);
//           Fluttertoast.showToast(
//               msg: payOnlineJson['message'],
//               toastLength: Toast.LENGTH_SHORT,
//               gravity: ToastGravity.BOTTOM,
//               timeInSecForIos: 1,
//               backgroundColor: Colors.grey[400],
//               textColor: Colors.black87,
//               fontSize: 13.0);
//         }
//       }
//     } catch (x) {
//       if (x.toString().contains("TimeoutException")) {
//         showError("Time out from server", FontAwesomeIcons.hourglassHalf,
//             context, getPayOnline);
//       } else {
//         showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
//             getPayOnline);
//       }
//     }
//   }
// }
