// import 'dart:convert';

// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:skyline_university/Global/appBarLogin.dart';
// import 'package:skyline_university/Global/exception.dart';
// import 'package:skyline_university/Global/global.dart';

// import 'attendanceCalendar.dart';

// void main() => runApp(Attendance());

// class Attendance extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _AttendanceState();
//   }
// }

// // // Map<String, int> body;

// class _AttendanceState extends State<Attendance> {
//   List attendanceJson = [];

//   Map attendanceMessageJson = {};

//   @override
//   void initState() {
//     super.initState();
//     getStudentAttendance();
//     attendanceJson = [];
//   }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setEnabledSystemUIOverlays([]);
//     return Scaffold(
//         appBar: appBarLogin(context, 'Attendance'),
//         body: attendanceJson == null
//             ? exception(context, FontAwesomeIcons.exclamationTriangle,
//                 attendanceMessageJson['message'])
//             : Container(
//                 child: ListView.builder(
//                   itemCount: attendanceJson.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return GestureDetector(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => AttendanceCalendar(
//                               index: index,
//                               classSectionID: attendanceJson[index]
//                                       ['ClassSectionID']
//                                   .toString(),
//                               className: attendanceJson[index]
//                                       ['Cdd_Description']
//                                   .toString(),
//                             ),
//                           ),
//                         );
//                       },
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Card(
//                           shape: RoundedRectangleBorder(
//                               borderRadius:
//                                   BorderRadius.all(Radius.circular(10))),
//                           elevation: 5,
//                           color: isDark(context) ? Colors.black : Colors.white,
//                           child: Column(
//                             children: <Widget>[
//                               Container(
                                
//                                 decoration: new BoxDecoration(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(10)),
//                                     gradient: isDark(context)
//                                         ? LinearGradient(
//                                             begin: Alignment.topCenter,
//                                             end: Alignment.bottomCenter,
//                                             colors: [
//                                               Color(0xFF1F1F1F),
//                                               Color(0xFF1F1F1F),
//                                             ],
//                                             stops: [
//                                               0.7,
//                                               0.9,
//                                             ],
//                                           )
//                                         : LinearGradient(
//                                             begin: Alignment.topLeft,
//                                             end: Alignment.bottomRight,
//                                             colors: [
//                                               Color(0xFF104C90),
//                                               Color(0xFF3773AC),
//                                             ],
//                                             stops: [
//                                               0.7,
//                                               0.9,
//                                             ],
//                                           )),
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(5.0),
//                                   child: Row(
//                                     children: <Widget>[
//                                       Expanded(
//                                         child: Padding(
//                                           padding:
//                                               const EdgeInsets.only(left: 5),
//                                           child: Text(
//                                             attendanceJson[index]
//                                                 ['Cdd_Description'],
//                                             style:
//                                                 TextStyle(color: Colors.white),
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: Row(
//                                   children: <Widget>[
//                                     Text(
//                                       'Faculty Name : ',
//                                       style: TextStyle(
//                                           color: isDark(context)
//                                               ? Colors.white
//                                               : Colors.black),
//                                     ),
//                                     Expanded(
//                                       child: Text(
//                                         attendanceJson[index]['FName']
//                                             .toString(),
//                                         style: TextStyle(
//                                             color: isDark(context)
//                                                 ? Colors.white
//                                                 : Colors.black),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
                            
//                               Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text(
//                                       "Class Absent: ",
//                                       style: TextStyle(
//                                           color: isDark(context)
//                                               ? Colors.white
//                                               : Colors.black),
//                                     ),
//                                     Expanded(
//                                       child: Text(
//                                           attendanceJson[index]['NATT']
//                                                       .toString() ==
//                                                   "null"
//                                               ? "0"
//                                               : attendanceJson[index]['NATT'],
//                                           style: TextStyle(
//                                               color: isDark(context)
//                                                   ? Colors.white
//                                                   : Colors.black)),
//                                     ),
//                                   ],
//                                 ),
//                               ),
                             
//                               Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: Row(
//                                   children: <Widget>[
//                                     Text("Percentage Absent: ",
//                                         style: TextStyle(
//                                             color: isDark(context)
//                                                 ? Colors.white
//                                                 : Colors.black)),
//                                     Expanded(
//                                       child: Text(
//                                           attendanceJson[index]['NATT']
//                                                       .toString() ==
//                                                   ("null")
//                                               ? "0.0"
//                                               : attendanceJson[index]['NATT']
//                                                   .toString(),
//                                           style: TextStyle(
//                                               color: isDark(context)
//                                                   ? Colors.white
//                                                   : Colors.black)),
//                                     ),
//                                   ],
//                                 ),
//                               ),
                             
//                               Padding(
//                                 padding: const EdgeInsets.all(10.0),
//                                 child: Row(children: <Widget>[
//                                   Text('Batch Code : ',
//                                       style: TextStyle(
//                                           color: isDark(context)
//                                               ? Colors.white
//                                               : Colors.black)),
//                                   Expanded(
//                                     child: Text(
//                                         attendanceJson[index]['BatchCode']
//                                             .toString(),
//                                         style: TextStyle(
//                                             color: isDark(context)
//                                                 ? Colors.white
//                                                 : Colors.black)),
//                                   ),
//                                 ]),
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ));
//   }

//   Future getStudentAttendance() async {
//     Future.delayed(Duration.zero, () {
//       showLoading(true, context);
//     });
//     try {
//       http.Response response = await http.post(
//         Uri.encodeFull(
//             "https://skylineportal.com/moappad/api/test/StudentAttendance"),
//         headers: {
//           "API-KEY": API,
//         },
//         body: {
//           'student_id': username,
//         },
//       ).timeout(Duration(seconds: 35));

//       if (response.statusCode == 200) {
//         setState(() {
//           attendanceJson = json.decode(response.body)['data'];

//           attendanceMessageJson = json.decode(response.body);
//         });

//         showLoading(false, context);
//       }
//     } catch (x) {
//       if (x.toString().contains("TimeoutException")) {
//         showLoading(false, context);

//         showError("Time out from server", FontAwesomeIcons.hourglassHalf,
//             context, getStudentAttendance);
//       } else {
//         showLoading(false, context);
//         showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
//             getStudentAttendance);
//       }
//     }
//   }
// }
