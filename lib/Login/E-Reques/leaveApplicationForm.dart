// import 'dart:convert';

// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:skyline_university/Global/appBarLogin.dart';
// import 'package:skyline_university/Global/bottomAppBar.dart';
// import 'package:skyline_university/Global/form.dart';
// import 'package:skyline_university/Global/global.dart';

// void main() => runApp(LeaveApplicationForm());

// class LeaveApplicationForm extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _LeaveApplicationFormState();
//   }
// }

// final _leaveApplicationForm = GlobalKey<FormState>();

// // Map<String, int> body;

// class _LeaveApplicationFormState extends State<LeaveApplicationForm> {
//   List leaveTypesJson = [];
//   Map leaveApplicationFormJson = {};
//   final format = DateFormat("yyyy-MM-dd HH:mm");
//   final initialValue = DateTime.now();

//   String from;
//   String to;

//   String contactNo = '';
//   String residenceContactNumber = '';
//   String mobileNumber = '';
//   String documentSubmitted = '';
//   String reasonLeave = '';
//   String addressTo = '';

//   @override
//   void initState() {
//     super.initState();

//     getLeaveTypes();
//   }

//   @override
//   Widget build(BuildContext context) {
//     SystemChrome.setEnabledSystemUIOverlays([]);
//     return Scaffold(
//       resizeToAvoidBottomPadding: true,
//       bottomNavigationBar: bottomappBar(
//         context,
//         () {
//           if (_leaveApplicationForm.currentState.validate()) {
//             _leaveApplicationForm.currentState.save();
//             getLeaveApplication();
//           }

//           // getLeaveApplication();
//         },
//       ),
//       appBar: appBarLogin(context, 'Leave Application'),
//       body: GestureDetector(
//         onTap: () {
//           FocusScope.of(context).requestFocus(new FocusNode());
//         },
//         child: Container(
//           color: Colors.white,
//           child: ListView(
//             children: <Widget>[
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     SizedBox(
//                       height: 15,
//                     ),
//                     Form(
//                       key: _leaveApplicationForm,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           SizedBox(
//                             height: 10,
//                           ),
//                           datePickers(context, (date) {
//                             from = date.toString();
//                           }, 'Leave From'),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           datePickers(context, (date) {
//                             to = date.toString();
//                           }, 'Leave To'),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           globalForms(context, '', (String value) {
//                             if (value.trim().isEmpty) {
//                               return 'Contact number is required';
//                             }
//                             return null;
//                           }, (x) {
//                             setState(() {
//                               residenceContactNumber = x;
//                             });
//                           }, 'Residence Contact Number', TextInputType.number,
//                               FontAwesomeIcons.phoneAlt, Colors.blue),
//                           globalForms(context, '', (String value) {
//                             if (value.trim().isEmpty) {
//                               return 'Mobile number is required';
//                             }
//                             return null;
//                           }, (x) {
//                             setState(() {
//                               mobileNumber = x;
//                             });
//                           }, 'Mobile Number', TextInputType.number,
//                               FontAwesomeIcons.phoneAlt, Colors.blue),
//                           globalForms(context, '', (String value) {
//                             if (value.trim().isEmpty) {
//                               return 'Document is required';
//                             }
//                             return null;
//                           }, (x) {
//                             setState(() {
//                               documentSubmitted = x;
//                             });
//                           }, 'Document Submitted', TextInputType.text,
//                               FontAwesomeIcons.fileAlt, Colors.blue),
//                           globalForms(context, '', (String value) {
//                             if (value.trim().isEmpty) {
//                               return 'Adress is required';
//                             }
//                             return null;
//                           }, (x) {
//                             setState(() {
//                               addressTo = x;
//                             });
//                           }, 'Address To', TextInputType.text,
//                               FontAwesomeIcons.mapMarkerAlt, Colors.blue),
//                           globalForms(context, '', (String value) {
//                             if (value.trim().isEmpty) {
//                               return 'Reason is required';
//                             }
//                             return null;
//                           }, (x) {
//                             setState(() {
//                               reasonLeave = x;
//                             });
//                           }, 'Reason For Leave', TextInputType.text,
//                               FontAwesomeIcons.question, Colors.blue),
//                           SizedBox(
//                             height: 10,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Future getLeaveTypes() async {
//     Future.delayed(Duration.zero, () {
//       showLoading(true, context);
//     });

//     try {
//       final response = await http.post(
//         Uri.encodeFull(
//             'https://skylineportal.com/moappad/api/web/getLeaveTypes'),
//         headers: {
//           "API-KEY": API,
//         },
//         body: {
//           'user_id': studentJson['data']['user_id'],
//           'usertype': studentJson['data']['user_type'],
//           'ipaddress': '1',
//           'deviceid': '1',
//           'devicename': '1',
//         },
//       ).timeout(Duration(seconds: 35));

//       if (response.statusCode == 200) {
//         setState(
//           () {
//             leaveTypesJson = json.decode(response.body)['data'];
//           },
//         );

//         showLoading(false, context);
//       }
//     } catch (x) {
//       if (x.toString().contains("TimeoutException")) {
//         showLoading(false, context);
//         showError("Time out from server", FontAwesomeIcons.hourglassHalf,
//             context, getLeaveTypes);
//       } else {
//         showLoading(false, context);
//         showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
//             getLeaveTypes);
//       }
//     }
//   }

//   Future getLeaveApplication() async {
//     Future.delayed(Duration.zero, () {
//       showLoading(true, context);
//     });

//     try {
//       final response = await http.post(
//         Uri.encodeFull(
//             'https://skylineportal.com/moappad/api/web/leaveApplication'),
//         headers: {
//           "API-KEY": API,
//         },
//         body: {
//           'user_id': username,
//           'from': from.toString(),
//           'to': to.toString(),
//           'contact_no': residenceContactNumber,
//           'mobile_no': mobileNumber,
//           'document_submitted': documentSubmitted,
//           'address_to': addressTo,
//           'reason': reasonLeave,
//           'usertype': studentJson['data']['user_type'],
//           'ipaddress': '1',
//           'deviceid': '1',
//           'devicename': '1',
//         },
//       ).timeout(Duration(seconds: 35));

//       if (response.statusCode == 200) {
//         setState(
//           () {
//             leaveApplicationFormJson = json.decode(response.body);
//           },
//         );
//         showLoading(false, context);
//       }

//       if (leaveApplicationFormJson['success'] == '1') {
//         showDoneInput(leaveApplicationFormJson['message'], context);
//       }
//     } catch (x) {
//       if (x.toString().contains("TimeoutException")) {
//         showLoading(false, context);
//         showError("Time out from server", FontAwesomeIcons.hourglassHalf,
//             context, getLeaveApplication);
//       } else {
//         showLoading(false, context);
//         showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
//             getLeaveApplication);
//       }
//     }
//   }

//   Widget datePickers(BuildContext context, onSaved, labelText) {
//     return Column(children: <Widget>[
//       Padding(
//         padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
//         child: DateTimeField(
//           format: format,
//           onShowPicker: (context, currentValue) async {
//             final date = await showDatePicker(
//                 context: context,
//                 firstDate: DateTime(1900),
//                 initialDate: currentValue ?? DateTime.now(),
//                 lastDate: DateTime(2100));
//             if (date != null) {
//               final time = await showTimePicker(
//                 context: context,
//                 initialTime:
//                     TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
//               );
//               return DateTimeField.combine(date, time);
//             } else {
//               return currentValue;
//             }
//           },
//           // validator: validator,
//           initialValue: initialValue,
//           onSaved: onSaved,
//           readOnly: true,
//           decoration: InputDecoration(
//             labelText: labelText,
//             icon: Icon(
//               Icons.date_range,
//               color: Colors.blue,
//             ),
//           ),
//         ),
//       ),
//     ]);
//   }
// }
