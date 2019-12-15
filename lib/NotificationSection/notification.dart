// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:skyline_university/Global/appBarLogin.dart';
// import 'package:skyline_university/Global/exception.dart';
// import 'package:skyline_university/Global/global.dart';
// import 'package:intl/intl.dart';

// void main() => runApp(Notifications());

// class Notifications extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _NotificationsState();
//   }
// }

// // // Map<String, int> body;

// class _NotificationsState extends State<Notifications> {
//   var now = new DateTime.now();
//   var formatter = new DateFormat('yyyy-MM-dd');
//   List notificationsJson = [];
//   Map notificationsMessageJson = {};
//   @override
//   void initState() {
//     print(username);
//     super.initState();
//     getNotifications();
//   }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setEnabledSystemUIOverlays([]);
//     return Scaffold(
//         appBar: appBarLogin(context, 'Notifications'),
//         body: notificationsJson == null
//             ? exception(context, FontAwesomeIcons.exclamationTriangle,
//                 notificationsMessageJson['message'])
//             : Container(
//                 color: Colors.white,
//                 child: ListView.builder(
//                   itemCount: notificationsJson.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Card(
//                         elevation: 10,
//                         child: Column(
//                           children: <Widget>[
//                             Padding(
//                               padding: const EdgeInsets.all(5.0),
//                               child: Container(
//                                 height: 30,
//                                 decoration: new BoxDecoration(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10)),
//                                     gradient: LinearGradient(
//                                         begin: Alignment.topLeft,
//                                         end: Alignment.bottomRight,
//                                         colors: [
//                                           Color(0xFF104C90),
//                                           Color(0xFF3773AC),
//                                         ],
//                                         stops: [
//                                           0.7,
//                                           0.9,
//                                         ])),
//                                 child: Padding(
//                                   padding: const EdgeInsets.only(left: 10.0),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: <Widget>[
//                                       Text(
//                                         notificationsJson[index]['title'],
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                       Padding(
//                                         padding: const EdgeInsets.all(8.0),
//                                         child: Text(
//                                           notificationsJson[index]
//                                                   ['published_datetime']
//                                               .toString(),
//                                           style: TextStyle(color: Colors.white),
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               height: 15,
//                             ),
//                             Text(notificationsJson[index]['description']),
//                             SizedBox(
//                               height: 15,
//                             ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ));
//   }

//   Future getNotifications() async {
//     Future.delayed(Duration.zero, () {
//       showLoading(true, context);
//     });
//     try {
//       http.Response response = await http.post(
//         Uri.encodeFull(
//             "https://skylineportal.com/moappad/api/web/getNotifications"),
//         headers: {
//           "API-KEY": API,
//         },
//         body: {
//           'user_id': username,
//           'usertype': studentJson['data']['user_type'],
//           'token': '1',
//           'ipaddress': '1',
//           'deviceid': '1',
//           'devicename': '1',
//         },
//       ).timeout(Duration(seconds: 35));

//       if (response.statusCode == 200) {
//         setState(() {
//           notificationsJson = json.decode(response.body)['data'];
//           notificationsMessageJson = json.decode(response.body);
//         });

//         showLoading(false, context);
//       }
//     } catch (x) {
//       if (x.toString().contains("TimeoutException")) {
//         showLoading(false, context);

//         showError("Time out from server", FontAwesomeIcons.hourglassHalf,
//             context, getNotifications);
//       } else {
//         showLoading(false, context);
//         showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
//             getNotifications);
//       }
//     }
//   }
// }
