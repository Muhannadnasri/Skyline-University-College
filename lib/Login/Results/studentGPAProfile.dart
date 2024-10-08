import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(StudentGPAProfile());

class StudentGPAProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentGPAProfileState();
  }
}

// Map<String, int> body;

class _StudentGPAProfileState extends State<StudentGPAProfile> {
  Map studentGPAProfileJson = {};
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getStudentGPAProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarLogin(context, 'GPA'),
      body: studentGPAProfileJson == null || studentGPAProfileJson.isEmpty
          ? exception(context, isLoading)
          : Container(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    elevation: 5,
                    child: Column(
                      children: <Widget>[
                        Container(
                          decoration: new BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              gradient: isDark(context)
                                  ? LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: [
                                        Color(0xFF1F1F1F),
                                        Color(0xFF1F1F1F),
                                      ],
                                      stops: [
                                        0.7,
                                        0.9,
                                      ],
                                    )
                                  : LinearGradient(
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color(0xFF104C90),
                                        Color(0xFF3773AC),
                                      ],
                                      stops: [
                                        0.7,
                                        0.9,
                                      ],
                                    )),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 10.0, bottom: 5),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  child: Expanded(
                                    child: Text(
                                      studentGPAProfileJson['STUDENT NAME'] ==
                                              null
                                          ? ''
                                          : studentGPAProfileJson[
                                                  'STUDENT NAME']
                                              .toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        'TRANSFER OF CREDIT (TOC) : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isDark(context)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      studentGPAProfileJson[
                                                  'TRANSFER OF CREDIT (TOC)'] ==
                                              null
                                          ? ''
                                          : studentGPAProfileJson[
                                                  'TRANSFER OF CREDIT (TOC)']
                                              .toString(),
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        'TOTAL CREDIT EARNED : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isDark(context)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                    Text(
                                      studentGPAProfileJson[
                                                  'TOTAL CREDIT EARNED (INCLUDING TOC)'] ==
                                              null
                                          ? ''
                                          : studentGPAProfileJson[
                                                  'TOTAL CREDIT EARNED (INCLUDING TOC)']
                                              .toString(),
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        'GPA : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isDark(context)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      studentGPAProfileJson['CGPA'] == null
                                          ? ''
                                          : studentGPAProfileJson['CGPA']
                                              .toString(),
                                      style: TextStyle(
                                          fontSize: 13,
                                          letterSpacing: 0.5,
                                          color: isDark(context)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        'Level : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isDark(context)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      studentGPAProfileJson['LEVEL'] == null
                                          ? ''
                                          : studentGPAProfileJson['LEVEL']
                                              .toString(),
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        'Credit To Completed : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isDark(context)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      studentGPAProfileJson[
                                                  'CREDIT TO BE COMPLETED'] ==
                                              null
                                          ? ''
                                          : studentGPAProfileJson[
                                                  'CREDIT TO BE COMPLETED']
                                              .toString(),
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Text(
                                        'CREDIT ATTENDED : ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: isDark(context)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      studentGPAProfileJson[
                                                  'CREDIT ATTENDED'] ==
                                              null
                                          ? ''
                                          : studentGPAProfileJson[
                                                  'CREDIT ATTENDED']
                                              .toString(),
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Future getStudentGPAProfile() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      http.Response response = await http.post(
        Uri.parse(
            "https://skylineportal.com/moappad/api/test/StudentGPAProfile"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'StudID': username,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          studentGPAProfileJson = json.decode(response.body)['data'];
          isLoading = false;
        });

        showLoading(false, context);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getStudentGPAProfile);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getStudentGPAProfile);
      }
    }
  }
}
