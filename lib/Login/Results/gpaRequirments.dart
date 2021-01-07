import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(GetGPARequirments());

class GetGPARequirments extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GetGPARequirmentsState();
  }
}

// Map<String, int> body;

class _GetGPARequirmentsState extends State<GetGPARequirments> {
  List gpaRequirmentsJson = [];
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getGpaRequirments();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarLogin(context, 'GPA Requirments'),
        body:

            // null
            gpaRequirmentsJson == null
                ? exception(context, isLoading)
                : Container(
                    child: ListView.builder(
                      itemCount: gpaRequirmentsJson.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Card(
                            shape: BeveledRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            elevation: 15,
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 30,
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
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15.0),
                                        // child: Text(
                                        //   gpaRequirmentsJson[]
                                        //        ['Requirement'] ,
                                        //   style: TextStyle(color: Colors.white),
                                        // ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text(
                                      gpaRequirmentsJson[index]['Requirement'],
                                      style: TextStyle(
                                          color: isDark(context)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ));
  }

  Future getGpaRequirments() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/test/GPARequirments"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          gpaRequirmentsJson = json.decode(response.body)['data'];
          isLoading = false;
        });
      }
      showLoading(false, context);
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getGpaRequirments);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getGpaRequirments);
      }
    }
  }
}
