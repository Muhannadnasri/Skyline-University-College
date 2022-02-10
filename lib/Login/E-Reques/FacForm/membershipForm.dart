// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:http/http.dart' as http;
// import 'package:skyline_university/Global/appBarLogin.dart';
// import 'package:skyline_university/Global/bottomAppBar.dart';
// import 'package:skyline_university/Global/form.dart';
// import 'package:skyline_university/Global/global.dart';

// void main() => runApp(MembershipForm());

// class MembershipForm extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return _MembershipFormState();
//   }
// }

// final _membershipForm = GlobalKey<FormState>();

// String name = '';

// String residential = '';
// String homeNumber = '';
// String workNumber = '';
// String mobileNumber = '';

// // Map<String, int> body;

// class _MembershipFormState extends State<MembershipForm> {
//   List membershipRelationsJson = [
//     {"name": "Employer"},
//     {"name": "Relative"},
//     {"name": "Friend"}
//   ];
//   Map membershipFormJson = {};

//   String _relations;
//   String _gender;

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     
//     return Scaffold(
//       bottomNavigationBar: bottomappBar(
//         context,
//         () {
//           if (_membershipForm.currentState.validate()) {
//             _membershipForm.currentState.save();
//             sendMembershipForm();
//           } else {
//             return showErrorInput('Please check your input');
//           }
//         },
//       ),
//       appBar: appBarLogin(context, 'MemberShip Form'),
//       body: GestureDetector(
//         onTap: () {
//           FocusScope.of(context).requestFocus(new FocusNode());
//         },
//         child: ListView(
//           children: <Widget>[
//             Container(
//               child: Column(
//                 children: <Widget>[
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Form(
//                     key: _membershipForm,
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         globalForms(context, '', (String value) {
//                           if (value.trim().isEmpty) {
//                             return 'Name is required';
//                           }
//                           return null;
//                         }, (x) {
//                           setState(() {
//                             name = x;
//                           });
//                         }, 'Name', TextInputType.text),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: const EdgeInsets.fromLTRB(
//                                   20.0, 0.0, 20.0, 5.0),
//                               child: Text(
//                                 'Gender',
//                                 style: TextStyle(
//                                     color: isDark(context)
//                                         ? Colors.white
//                                         : Colors.black),
//                               ),
//                             )),
//                         Padding(
//                           padding:
//                               const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
//                           child: DropdownButton<String>(
//                             value: _gender,
//                             isExpanded: true,
//                             hint: Text(
//                               'Select Gender',
//                               style: TextStyle(
//                                   color: isDark(context)
//                                       ? Colors.white
//                                       : Colors.black),
//                             ),
//                             items: <String>['Male', 'Female']
//                                     ?.map((item) => DropdownMenuItem<String>(
//                                         value: item,
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Text(item),
//                                         )))
//                                     ?.toList() ??
//                                 [],
//                             onChanged: (value) {
//                               setState(() {
//                                 _gender = value;
//                               });
//                             },
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: const EdgeInsets.fromLTRB(
//                                   20.0, 0.0, 20.0, 5.0),
//                               child: Text(
//                                 'Select Relations',
//                                 style: TextStyle(
//                                     color: isDark(context)
//                                         ? Colors.white
//                                         : Colors.black),
//                               ),
//                             )),
//                         Padding(
//                           padding:
//                               const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 5.0),
//                           child: DropdownButton<String>(
//                             value: _relations,
//                             isExpanded: true,
//                             hint: Text(
//                               'Select Relations',
//                               style: TextStyle(
//                                   color: isDark(context)
//                                       ? Colors.white
//                                       : Colors.black),
//                             ),
//                             items: membershipRelationsJson
//                                     ?.map((item) => DropdownMenuItem<String>(
//                                         value: item['name'].toString(),
//                                         child: Padding(
//                                           padding: const EdgeInsets.all(8.0),
//                                           child: Text(item['name']),
//                                         )))
//                                     ?.toList() ??
//                                 [],
//                             onChanged: (value) {
//                               setState(() {
//                                 _relations = value;
//                               });
//                             },
//                           ),
//                         ),
//                         globalForms(context, '', (String value) {
//                           if (value.trim().isEmpty) {
//                             return 'Address is required';
//                           }
//                           return null;
//                         }, (x) {
//                           setState(() {
//                             residential = x;
//                           });
//                         }, 'Residential Address', TextInputType.text),
//                         globalForms(context, '', (String value) {
//                           if (value.trim().isEmpty) {
//                             return 'Home number is required';
//                           }
//                           return null;
//                         }, (x) {
//                           setState(() {
//                             homeNumber = x;
//                           });
//                         }, 'Home Contact Number', TextInputType.number),
//                         globalForms(context, '', (String value) {
//                           if (value.trim().isEmpty) {
//                             return 'Work number is required';
//                           }
//                           return null;
//                         }, (x) {
//                           setState(() {
//                             workNumber = x;
//                           });
//                         }, 'Work Contact Number', TextInputType.number),
//                         globalForms(context, '', (String value) {
//                           if (value.trim().isEmpty) {
//                             return 'Mobile number is required';
//                           }
//                           return null;
//                         }, (x) {
//                           setState(() {
//                             mobileNumber = x;
//                           });
//                         }, 'Mobile Contact Number', TextInputType.number),
//                       ],
//                     ),
//                   ),
//                   SizedBox(
//                     height: 15,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future sendMembershipForm() async {
//     Future.delayed(Duration.zero, () {});

//     try {
//       final response = await http.post(
//         Uri.parse(
//             'https://skylineportal.com/moappad/api/test/membershipForm'),
//         headers: {
//           "API-KEY": API,
//         },
//         body: {
//           'user_id': username,
//           'name': name,
//           'gender': _gender,
//           'relation': _relations,
//           'address': residential,
//           'contact_home': homeNumber,
//           'contact_work': workNumber,
//           'contact_mobile': mobileNumber,
//           'usertype': studentJson['data']['user_type'],
//           'ipaddress': '1',
//           'deviceid': '1',
//           'devicename': '1',
//         },
//       ).timeout(Duration(seconds: 35));

//       if (response.statusCode == 200) {
//         setState(
//           () {
//             membershipFormJson = json.decode(response.body);
//           },
//         );
//       }
//       showSuccessSnackBar(context, membershipFormJson['message']);
//     } catch (x) {
//       if (x.toString().contains("TimeoutException")) {
//         showLoading(false, context);
//         showError("Time out from server", FontAwesomeIcons.hourglassHalf,
//             context, sendMembershipForm);
//       } else {
//         showLoading(false, context);
//         showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
//             sendMembershipForm);
//       }
//     }
//   }
// }
