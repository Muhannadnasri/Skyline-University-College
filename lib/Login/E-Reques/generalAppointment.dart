// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:skyline_university/Global/appBarLogin.dart';
// import 'package:skyline_university/Global/bottomAppBar.dart';
// import 'package:skyline_university/Global/form.dart';
// import 'package:skyline_university/Global/global.dart';

// void main() => runApp(GeneralAppointment());

// class GeneralAppointment extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _GeneralAppointmentState();
//   }
// }

// final _generalAppointment = GlobalKey<FormState>();

// // Map<String, int> body;

// class _GeneralAppointmentState extends State<GeneralAppointment> {
//   List generalAPPtDepartmentJson = [];
//   List generalAPPtTimeJson = [];
//   List generalAPPtJson = [];
//   List generalApptDate = [];
//   Map generalRequestJson = {};
//   String remarkAppointment = '';

//   String _categoryID;
//   String _departmentID;
//   String _appointDate;
//   String _caseType;
//   String _appointTime;
//   @override
//   void initState() {
//     super.initState();

//     getGeneralApptCatDeptTime();
//   }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setEnabledSystemUIOverlays([]);
//     return Scaffold(
//       resizeToAvoidBottomPadding: false,
//       bottomNavigationBar: bottomappBar(
//         context,
//         () {
//           setState(() {
//             if (_generalAppointment.currentState.validate() &&
//                     _caseType != null ||
//                 _generalAppointment.currentState.validate() &&
//                     _caseType != null &&
//                     _categoryID != null &&
//                     _departmentID != null &&
//                     _appointDate != null &&
//                     _appointTime != null) {
//               _generalAppointment.currentState.save();
//               getGeneralAppointment();
//             }
//             return showErrorInput('Check your input please');
//           });
//         },
//       ),
//       appBar: appBarLogin(context, 'General Appointment'),
//       body: ListView(
//         children: <Widget>[
//           GestureDetector(
//             onTap: () {
//               FocusScope.of(context).requestFocus(new FocusNode());
//             },
//             child: Container(
//               color: Colors.white,
//               child: Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   children: <Widget>[
//                     SizedBox(
//                       height: 25,
//                     ),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: const EdgeInsets.only(left: 10.0),
//                         child: Text(
//                           'Case Category',
//                           style: TextStyle(color: Colors.grey[600]),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Column(
//                       children: <Widget>[
//                         DropdownButton<String>(
//                           isExpanded: true,
//                           value: _caseType,
//                           hint: Padding(
//                             padding: const EdgeInsets.only(left: 8.0),
//                             child: Text(
//                               'Select Option',
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ),
//                           items: [
//                                 'General Appointment',
//                                 'Suggestions',
//                                 'Complaints',
//                                 'Improverments'
//                               ]
//                                   ?.map(
//                                     (item) => DropdownMenuItem<String>(
//                                       value: item,
//                                       child: Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 8.0),
//                                         child: Text(item),
//                                       ),
//                                     ),
//                                   )
//                                   ?.toList() ??
//                               [],
//                           onChanged: (value) {
//                             setState(() {
//                               _caseType = value;
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Container(
//                       alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: const EdgeInsets.all(8.0),
//                         child: Text(
//                           'Case Category',
//                           style: TextStyle(color: Colors.grey[600]),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Column(
//                       children: <Widget>[
//                         DropdownButton<String>(
//                           isExpanded: true,
//                           value: _categoryID,
//                           hint: Padding(
//                             padding: const EdgeInsets.only(left: 8.0),
//                             child: Text(
//                               'Select Option',
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ),
//                           items: generalAPPtJson
//                                   ?.map(
//                                     (item) => DropdownMenuItem<String>(
//                                       value: item['CATEGORY_ID'].toString(),
//                                       child: Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 10.0),
//                                         child: Text(item['CATEGORY_DESCRIPTION']
//                                             .toString()),
//                                       ),
//                                     ),
//                                   )
//                                   ?.toList() ??
//                               [],
//                           onChanged: (value) {
//                             setState(() {
//                               _categoryID = value;
//                               getGeneralApptCatDeptTime();
//                             });
//                           },
//                         ),
//                       ],
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     _caseType == 'General Appointment'
//                         ? Column(
//                             children: <Widget>[
//                               Container(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     'Department',
//                                     style: TextStyle(color: Colors.grey[600]),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               Column(
//                                 children: <Widget>[
//                                   DropdownButton<String>(
//                                     isExpanded: true,
//                                     value: _departmentID,
//                                     hint: Padding(
//                                       padding:
//                                           const EdgeInsets.only(left: 10.0),
//                                       child: Text(
//                                         'Select option',
//                                         style: TextStyle(color: Colors.black),
//                                       ),
//                                     ),
//                                     items: generalAPPtDepartmentJson
//                                             ?.map(
//                                               (item) =>
//                                                   DropdownMenuItem<String>(
//                                                 value: item['EmpNumber'],
//                                                 child: Column(
//                                                   children: <Widget>[
//                                                     Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               left: 10.0),
//                                                       child: Text(
//                                                           item['Department']),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             )
//                                             ?.toList() ??
//                                         [],
//                                     onChanged: (value) {
//                                       setState(() {
//                                         _departmentID = value;
//                                         getGeneralApptDate();
//                                       });
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               Container(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     'Appointment Date',
//                                     style: TextStyle(color: Colors.grey[600]),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(
//                                 height: 5,
//                               ),
//                               Column(
//                                 children: <Widget>[
//                                   DropdownButton<String>(
//                                     isExpanded: true,
//                                     value: _appointDate,
//                                     hint: Padding(
//                                       padding:
//                                           const EdgeInsets.only(left: 10.0),
//                                       child: Text(
//                                         'Select option',
//                                         style: TextStyle(color: Colors.black),
//                                       ),
//                                     ),
//                                     items: generalApptDate
//                                             ?.map(
//                                               (item) =>
//                                                   DropdownMenuItem<String>(
//                                                 value: item.toString(),
//                                                 child: Column(
//                                                   children: <Widget>[
//                                                     Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               left: 10.0),
//                                                       child: Text(item['date']
//                                                           .toString()),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             )
//                                             ?.toList() ??
//                                         [],
//                                     onChanged: (value) {
//                                       setState(() {
//                                         _appointDate = value;
//                                         getGeneralApptCatDeptTime();
//                                       });
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               Container(
//                                 alignment: Alignment.centerLeft,
//                                 child: Padding(
//                                   padding: const EdgeInsets.all(8.0),
//                                   child: Text(
//                                     'Appointment Time',
//                                     style: TextStyle(color: Colors.grey[600]),
//                                   ),
//                                 ),
//                               ),
//                               Column(
//                                 children: <Widget>[
//                                   DropdownButton<String>(
//                                     isExpanded: true,
//                                     value: _appointTime,
//                                     hint: Padding(
//                                       padding:
//                                           const EdgeInsets.only(left: 10.0),
//                                       child: Text(
//                                         'Select option',
//                                         style: TextStyle(color: Colors.black),
//                                       ),
//                                     ),
//                                     items: generalAPPtTimeJson
//                                             ?.map(
//                                               (item) =>
//                                                   DropdownMenuItem<String>(
//                                                 value: item.toString(),
//                                                 child: Column(
//                                                   children: <Widget>[
//                                                     Padding(
//                                                       padding:
//                                                           const EdgeInsets.only(
//                                                               left: 10.0),
//                                                       child: Text(
//                                                           item['timevalue']
//                                                               .toString()),
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ),
//                                             )
//                                             ?.toList() ??
//                                         [],
//                                     onChanged: (value) {
//                                       setState(() {
//                                         _appointTime = value;
//                                       });
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 height: 15,
//                               ),
//                             ],
//                           )
//                         : SizedBox(),
//                     Container(
//                       alignment: Alignment.center,
//                       child: Form(
//                         key: _generalAppointment,
//                         child: globalForms(context, '', (String value) {
//                           if (value.trim().isEmpty) {
//                             return 'Reason is required';
//                           }
//                           return null;
//                         }, (x) {
//                           setState(() {
//                             remarkAppointment = x;
//                           });
//                         }, 'Reason', TextInputType.text,
//                             FontAwesomeIcons.question, Colors.blue),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Future getGeneralApptDate() async {
//     Future.delayed(Duration.zero, () {
//       showLoading(true, context);
//     });

//     try {
//       final response = await http.post(
//         Uri.encodeFull(
//             'https://skylineportal.com/moappad/api/web/getGeneralApptDate'),
//         headers: {
//           "API-KEY": API,
//         },
//         body: {
//           'user_id': username,
//           'usertype': studentJson['data']['user_type'],
//           'emp_no': _departmentID,
//           'department': '1',
//           'token': '1',
//           'ipaddress': '1',
//           'deviceid': '1',
//           'devicename': '1',
//         },
//       ).timeout(Duration(seconds: 35));

//       if (response.statusCode == 200) {
//         setState(
//           () {
//             generalApptDate = json.decode(response.body)['data'];
//           },
//         );

//         showLoading(false, context);
//       }
//     } catch (x) {
//       if (x.toString().contains("TimeoutException")) {
//         showLoading(false, context);

//         showError("Time out from server", FontAwesomeIcons.hourglassHalf,
//             context, getGeneralApptCatDeptTime);
//       } else {
//         showLoading(false, context);
//         showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
//             getGeneralApptCatDeptTime);
//       }
//     }
//   }

//   Future getGeneralApptCatDeptTime() async {
//     Future.delayed(Duration.zero, () {
//       showLoading(true, context);
//     });

//     try {
//       final response = await http.post(
//         Uri.encodeFull(
//             'https://skylineportal.com/moappad/api/web/getGeneralApptCatDeptTime'),
//         headers: {
//           "API-KEY": API,
//         },
//         body: {
//           'usertype': studentJson['data']['user_type'],
//           'token': '1',
//           'ipaddress': '1',
//           'deviceid': '1',
//           'devicename': '1',
//         },
//       ).timeout(Duration(seconds: 35));

//       if (response.statusCode == 200) {
//         setState(
//           () {
//             generalAPPtJson = json.decode(response.body)['data']['category'];
//             generalAPPtDepartmentJson =
//                 json.decode(response.body)['data']['department'];
//             generalAPPtTimeJson = json.decode(response.body)['data']['time'];
//           },
//         );

//         showLoading(false, context);
//       }
//     } catch (x) {
//       if (x.toString().contains("TimeoutException")) {
//         showLoading(false, context);

//         showError("Time out from server", FontAwesomeIcons.hourglassHalf,
//             context, getGeneralApptCatDeptTime);
//       } else {
//         showLoading(false, context);
//         showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
//             getGeneralApptCatDeptTime);
//       }
//     }
//   }

//   Future getGeneralAppointment() async {
//     Future.delayed(Duration.zero, () {
//       showLoading(true, context);
//     });

//     try {
//       final response = await http.post(
//         Uri.encodeFull(
//             'https://skylineportal.com/moappad/api/web/generalAppointment'),
//         headers: {
//           "API-KEY": API,
//         },
//         body: {
//           'user_id': username,
//           'case_type': _caseType,
//           'case_category': _categoryID,
//           'department': _caseType == 'Suggestions'
//               ? "null"
//               : _caseType == 'Complaints'
//                   ? "null"
//                   : _caseType == 'Improverments' ? "null" : _departmentID,
//           'appt_date': _caseType == 'Suggestions'
//               ? "null"
//               : _caseType == 'Complaints'
//                   ? "null"
//                   : _caseType == 'Improverments' ? "null" : _appointDate,
//           'appt_time': _caseType == 'Suggestions'
//               ? "null"
//               : _caseType == 'Complaints'
//                   ? "null"
//                   : _caseType == 'Improverments' ? "null" : '',
//           'description': remarkAppointment,
//           'token': '1',
//           'usertype': studentJson['data']['user_type'],
//           'ipaddress': '1',
//           'deviceid': '1',
//           'devicename': '1',
//         },
//       );
//       if (response.statusCode == 200) {
//         setState(
//           () {
//             generalRequestJson = json.decode(response.body);
//           },
//         );
//         showLoading(false, context);
//       }

//       if (generalRequestJson['success'] == '1') {
//         showDoneInput(generalRequestJson['message'], context);
//       }
//     } catch (x) {
//       if (x.toString().contains("TimeoutException")) {
//         showLoading(false, context);

//         showError("Time out from server", FontAwesomeIcons.hourglassHalf,
//             context, getGeneralApptCatDeptTime);
//       } else {
//         showLoading(false, context);
//         showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
//             getGeneralApptCatDeptTime);
//       }
//     }
//   }
// }
