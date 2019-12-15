// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:skyline_university/Global/appBarLogin.dart';
// import 'package:skyline_university/Global/bottomAppBar.dart';
// import 'package:skyline_university/Global/form.dart';
// import 'package:skyline_university/Global/global.dart';

// void main() => runApp(AdvisorAppointment());

// class AdvisorAppointment extends StatefulWidget {
//   final String myAdvisorName;
//   final String myAdvisorId;

//   const AdvisorAppointment({Key key, this.myAdvisorName, this.myAdvisorId})
//       : super(key: key);

//   @override
//   State<StatefulWidget> createState() {
//     return _AdvisorAppointmentState();
//   }
// }

// final _studentProblem = GlobalKey<FormState>();
// // Map<String, int> body;

// class _AdvisorAppointmentState extends State<AdvisorAppointment> {
//   List advisorApptTimeJson = [];
//   List advisorDateJson = [];
//   List advisorCaseJson = [];
//   Map advisorNameJson = {};

//   Map advisorAppointmentJson = {};

//   int groupValue;
//   String studentProblem = '';

//   String time;
//   String date;
//   String caseDescription;
//   String dates;
//   @override
//   void initState() {
//     super.initState();

//     getAdvisorDate();
//     groupValue = 2;
//   }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setEnabledSystemUIOverlays([]);
//     return Scaffold(
//       resizeToAvoidBottomPadding: false,
//       bottomNavigationBar: bottomappBar(context, () {
//         setState(() {
//           if (_studentProblem.currentState.validate() &&
//                   date != null &&
//                   time != null &&
//                   caseDescription != null &&
//                   groupValue == 1 ||
//               _studentProblem.currentState.validate() &&
//                   date != null &&
//                   time != null) {
//             getAdvisorAppointment();
//           } else {
//             return showErrorInput('Please check your input');
//           }
//         });
//       }),
//       appBar: appBarLogin(context, 'Advisor Appointment'),
//       body: GestureDetector(
//         onTap: () {
//           FocusScope.of(context).unfocus();
//         },
//         child: Stack(
//           children: <Widget>[
//             Container(
//                 decoration: BoxDecoration(
//                   gradient: isDark(context)
//                       ? LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.topRight,
//                           colors: [
//                             Color(0xFF1F1F1F),
//                             Color(0xFF1F1F1F),
//                           ],
//                           stops: [
//                             0.5,
//                             0.8,
//                           ],
//                         )
//                       : LinearGradient(
//                           begin: Alignment.topLeft,
//                           end: Alignment.topRight,
//                           colors: [
//                             Color(0xFF104C90),
//                             Color(0xFF3773AC),
//                           ],
//                           stops: [
//                             0.1,
//                             0.8,
//                           ],
//                         ),
//                 ),
//                 height: 50),
//             Padding(
//               padding: const EdgeInsets.only(top: 20),
//               child: ClipRect(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: new BorderRadius.only(
//                       topLeft: new Radius.circular(40),
//                       topRight: new Radius.circular(40),
//                     ),
//                   ),
//                   child: ListView(
//                     children: <Widget>[
//                       SizedBox(
//                         height: 25,
//                       ),
//                       Container(
//                         height: MediaQuery.of(context).size.height,
//                         child: Column(
//                           children: <Widget>[
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Container(
//                                 child: Center(
//                                   child: FittedBox(
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(
//                                         widget.myAdvisorName == null
//                                             ? ''
//                                             : widget.myAdvisorName,
//                                         style: TextStyle(color: Colors.white),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 decoration: new BoxDecoration(
//                                     borderRadius:
//                                         BorderRadius.all(Radius.circular(5)),
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
//                               ),
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Container(
//                                   alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(
//                                       'Appointment Date',
//                                       style: TextStyle(color: Colors.grey[600]),
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 15.0),
//                                   child: DropdownButton<String>(
//                                     isExpanded: true,
//                                     hint: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(
//                                         'Date',
//                                         style: TextStyle(color: Colors.black),
//                                       ),
//                                     ),
//                                     value: date,
//                                     items: advisorDateJson
//                                             ?.map(
//                                               (item) =>
//                                                   DropdownMenuItem<String>(
//                                                 value: item['days'],
//                                                 child: Padding(
//                                                   padding:
//                                                       const EdgeInsets.all(8.0),
//                                                   child: Text(item['days']),
//                                                 ),
//                                               ),
//                                             )
//                                             ?.toList() ??
//                                         [],
//                                     onChanged: (value) {
//                                       setState(() {
//                                         date = value;
//                                         getAdvisorApptTime();
//                                       });
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: <Widget>[
//                                 Container(
//                                   alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding: const EdgeInsets.only(left: 10.0),
//                                     child: Text(
//                                       'Appointment Time',
//                                       style: TextStyle(color: Colors.grey[600]),
//                                     ),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 15.0),
//                                   child: DropdownButton<String>(
//                                     value: time,
//                                     isExpanded: true,
//                                     hint: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Text(
//                                         'Time',
//                                         style: TextStyle(color: Colors.black),
//                                       ),
//                                     ),
//                                     items: advisorApptTimeJson
//                                             ?.map((item) =>
//                                                 DropdownMenuItem<String>(
//                                                     value: item['Session_Time'],
//                                                     child: Padding(
//                                                       padding:
//                                                           const EdgeInsets.all(
//                                                               8.0),
//                                                       child: Text(
//                                                           item['Session_Time']),
//                                                     )))
//                                             ?.toList() ??
//                                         [],
//                                     onChanged: (value) {
//                                       setState(() {
//                                         time = value;
//                                       });
//                                     },
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Padding(
//                                   padding: const EdgeInsets.only(left: 10.0),
//                                   child: Text(
//                                     "Register New Case",
//                                     style: TextStyle(color: Colors.grey[600]),
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding: const EdgeInsets.only(right: 10.0),
//                                   child: Row(
//                                     children: <Widget>[
//                                       Row(
//                                         children: <Widget>[
//                                           Text('Yes'),
//                                           Radio(
//                                             value: 1,
//                                             groupValue: groupValue,
//                                             onChanged: (int e) {
//                                               setState(() {
//                                                 groupValue = e;
//                                               });
//                                             },
//                                             activeColor: Colors.blue,
//                                           ),
//                                         ],
//                                       ),
//                                       Text('No'),
//                                       Radio(
//                                         value: 2,
//                                         groupValue: groupValue,
//                                         onChanged: (int e) {
//                                           setState(() {
//                                             groupValue = e;
//                                           });
//                                         },
//                                         activeColor: Colors.blue,
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             groupValue == 2
//                                 ? SizedBox()
//                                 : Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: <Widget>[
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Container(
//                                         alignment: Alignment.centerLeft,
//                                         child: Padding(
//                                           padding:
//                                               const EdgeInsets.only(left: 10.0),
//                                           child: Text(
//                                             'Case Description',
//                                             style: TextStyle(
//                                                 color: Colors.grey[600]),
//                                           ),
//                                         ),
//                                       ),
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 15.0),
//                                         child: DropdownButton<String>(
//                                           isExpanded: true,
//                                           value: caseDescription,
//                                           hint: Padding(
//                                             padding: const EdgeInsets.all(8.0),
//                                             child: Padding(
//                                               padding:
//                                                   const EdgeInsets.all(8.0),
//                                               child: Text(
//                                                 'Case Description',
//                                                 style: TextStyle(
//                                                     color: Colors.black),
//                                               ),
//                                             ),
//                                           ),
//                                           items: advisorCaseJson
//                                                   ?.map((item) =>
//                                                       DropdownMenuItem<String>(
//                                                           value:
//                                                               item['case_desc'],
//                                                           child: Text(item[
//                                                               'case_desc'])))
//                                                   ?.toList() ??
//                                               [],
//                                           onChanged: (value) {
//                                             setState(() {
//                                               caseDescription = value;
//                                             });
//                                           },
//                                         ),
//                                       ),
//                                       Form(
//                                         key: _studentProblem,
//                                         child: globalForms(context, '',
//                                             (String value) {
//                                           if (value.trim().isEmpty) {
//                                             return 'Student problem is required';
//                                           }
//                                           return null;
//                                         }, (x) {
//                                           setState(() {
//                                             studentProblem = x;
//                                           });
//                                         },
//                                             'Student Problem',
//                                             TextInputType.text,
//                                             FontAwesomeIcons.exclamation,
//                                             Colors.blue),
//                                       ),
//                                     ],
//                                   ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future getAdvisorDate() async {
//     Future.delayed(Duration.zero, () {
//       showLoading(true, context);
//     });

//     try {
//       final response = await http.post(
//         Uri.encodeFull(
//             'https://skylineportal.com/moappad/api/web/getAdvisorNameDateCasedesc'),
//         headers: {
//           "API-KEY": API,
//         },
//         body: {
//           'user_id': username,
//           'usertype': studentJson['data']['user_type'],
//           'ipaddress': '1',
//           'deviceid': '1',
//           'devicename': '1',
//         },
//       ).timeout(Duration(seconds: 35));

//       if (response.statusCode == 200) {
//         setState(
//           () {
//             advisorDateJson = json.decode(response.body)['data']['dates'];
//             advisorCaseJson =
//                 json.decode(response.body)['data']['case_description'];
//             advisorNameJson =
//                 json.decode(response.body)['data']['advisor_name'];
//           },
//         );
//         showLoading(false, context);
//       }
//     } catch (x) {
//       if (x.toString().contains("TimeoutException")) {
//         showLoading(false, context);

//         showError("Time out from server", FontAwesomeIcons.hourglassHalf,
//             context, getAdvisorDate);
//       } else {
//         showLoading(false, context);
//         showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
//             getAdvisorDate);
//       }
//     }
//   }

//   Future getAdvisorApptTime() async {
//     Future.delayed(Duration.zero, () {
//       showLoading(true, context);
//     });

//     try {
//       final response = await http.post(
//         Uri.encodeFull(
//             'https://skylineportal.com/moappad/api/web/getAdvisorApptTime'),
//         headers: {
//           "API-KEY": API,
//         },
//         body: {
//           'user_id': username,
//           'appt_date': date,
//           'token': '1',
//           'usertype': studentJson['data']['user_type'],
//           'ipaddress': '1',
//           'deviceid': '1',
//           'devicename': '1',
//         },
//       ).timeout(Duration(seconds: 35));

//       if (response.statusCode == 200) {
//         setState(
//           () {
//             advisorApptTimeJson = json.decode(response.body)['data'];
//           },
//         );
//         showLoading(false, context);
//       }
//     } catch (x) {
//       if (x.toString().contains("TimeoutException")) {
//         showLoading(false, context);

//         showError("Time out from server", FontAwesomeIcons.hourglassHalf,
//             context, getAdvisorDate);
//       } else {
//         showLoading(false, context);
//         showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
//             getAdvisorDate);
//       }
//     }
//   }

//   Future getAdvisorAppointment() async {
//     if (_studentProblem.currentState.validate()) {
//       _studentProblem.currentState.save();
//     }
//     Future.delayed(Duration.zero, () {
//       showLoading(true, context);
//     });

//     try {
//       final response = await http.post(
//         Uri.encodeFull(
//             'https://skylineportal.com/moappad/api/test/advisorAppointment'),
//         headers: {
//           "API-KEY": API,
//         },
//         body: {
//           'user_id': username,
//           'AdvisorID': widget.myAdvisorId,
//           'AppoinmentDate': date,
//           'AppoinmentTime': time,
//           'CaseDescription': caseDescription,
//           'StudentProblem': studentProblem,
//           'usertype': studentJson['data']['user_type'],
//         },
//       ).timeout(Duration(seconds: 35));

//       if (response.statusCode == 200) {
//         setState(
//           () {
//             advisorAppointmentJson = json.decode(response.body);
//           },
//         );
//         showLoading(false, context);
//       }

//       if (advisorAppointmentJson['success'] == '0') {
//         showfailureSnackBar(context, advisorAppointmentJson['message']);
//       }
//       if (advisorAppointmentJson['success'] == '1') {
//         showSuccessSnackBar(context, advisorAppointmentJson['message']);
//       }
//     } catch (x) {
//       print(x);

//       // if (x.toString().contains("TimeoutException")) {
//       //   showError("Time out from server", FontAwesomeIcons.hourglassHalf,
//       //       context, getAdvisorDate);
//       // } else {
//       //   showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
//       //       getAdvisorDate);
//       // }
//     }
//   }
// }
