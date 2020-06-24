// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:skyline_university/Global/appBar.dart';
// import 'package:skyline_university/Global/global.dart';

// void main() => runApp(Profile());

// class Profile extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _ProfileState();
//   }
// }

// // // Map<String, int> body;

// class _ProfileState extends State<Profile> {
//   List announcementsJson = [];
//   Map announcementsMessageJson = {};
//   @override
//   void initState() {
//     print(username);
//     super.initState();
//     getAnnouncements();
//   }

//   @override
//   Widget build(BuildContext context) {
//     
//     return Scaffold(
//       appBar: appBar(context, 'Announcements'),
//       body: Stack(
//         overflow: Overflow.visible,
//         children: <Widget>[
//           Container(
//             height: MediaQuery.of(context).size.height / 5,
//             width: double.infinity,
//             decoration: BoxDecoration(
//               color: const Color(0xBB8338f4),
//               image: DecorationImage(
//                   colorFilter: ColorFilter.mode(
//                       Color.fromARGB(120, 20, 10, 40), BlendMode.srcOver),
//                   image: AssetImage(
//                     'images/logosmall.png',
//                   ),
//                   fit: BoxFit.cover),
//             ),
//           ),
//           Positioned.fill(
//             bottom: -40,
//             child: Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 height: 90,
//                 width: 90,
//                 decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.black, width: 5),
//                     borderRadius:
//                         new BorderRadius.all(new Radius.circular(50.0)),
//                     image: DecorationImage(
//                       image: AssetImage('images/logosmall.png'),
//                       fit: BoxFit.cover,
//                     )),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future getAnnouncements() async {
//     Future.delayed(Duration.zero, () {
//       showLoading(true, context);
//     });
//     try {
//       http.Response response = await http.post(
//         Uri.encodeFull(
//             "https://skylineportal.com/moappad/api/web/getAnnouncements"),
//         headers: {
//           "API-KEY": API,
//         },
//         body: {
//           'usertype': 'Guset',
//           'ipaddress': '1',
//           'deviceid': '1',
//           'devicename': '1',
//         },
//       ).timeout(Duration(seconds: 35));

//       if (response.statusCode == 200) {
//         setState(() {
//           announcementsJson = json.decode(response.body)['data'];
//           announcementsMessageJson = json.decode(response.body);
//         });

//         showLoading(false, context);
//       }
//     } catch (x) {
//       if (x.toString().contains("TimeoutException")) {
//         showLoading(false, context);

//         showError("Time out from server", FontAwesomeIcons.hourglassHalf,
//             context, getAnnouncements);
//       } else {
//         showLoading(false, context);
//         showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
//             getAnnouncements);
//       }
//     }
//   }
// }
