import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(Scholarship());

class Scholarship extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ScholarshipState();
  }
}

class _ScholarshipState extends State<Scholarship> {
  List infoJson = [];
  bool isLoading = true;
  Map infoJsonMessage = {};
  @override
  void initState() {
    super.initState();
    getScholarships();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBar(context, 'Scholarships'),
      body: infoJson == null || infoJson.isEmpty
          ? exception(context, isLoading)
          : ListView.builder(
// index
              itemCount: infoJson.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: <Widget>[
                    infoJson[index]['type'] == 'url'
                        ? Container(
                            child: Image.network(
                              infoJson[index]['page_content'].toString(),
                              fit: BoxFit.contain,
                            ),
                          )
                        : SizedBox(),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          infoJson[index]['type'] == 'url'
                              ? SizedBox()
                              : Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    infoJson[index]['title'],
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: isDark(context)
                                            ? Colors.white
                                            : Colors.black),
                                  ),
                                ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0, top: 5),
                            child: infoJson[index]['type'] == 'url'
                                ? SizedBox()
                                : Container(
                                    width: 100,
                                    decoration: UnderlineTabIndicator(
                                        borderSide: BorderSide(
                                            width: 3,
                                            color: Colors.blue,
                                            style: BorderStyle.solid)),
                                  ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: infoJson[index]['type'] == 'url'
                                ? SizedBox()
                                : Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: new BorderRadius.only(
                                          topLeft: Radius.circular(35.0),
                                          topRight: Radius.circular(35.0),
                                        )),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Html(
                                          data: infoJson[index]
                                              ['page_content']),
                                    ),
                                  ),
                          )
                        ],
                      ),
                    ),
                  ],
                );
              }),
    );
  }

  Future getScholarships() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull("https://skylineportal.com/moappad/api/test/PageInfo"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'name': 'Scholarships',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          infoJson = json.decode(response.body)['data'];
          infoJsonMessage = json.decode(response.body);
          isLoading = false;
        });

        showLoading(false, context);
        if (infoJsonMessage['success'] == '0') {
          showfailureSnackBar(context, infoJsonMessage['message']);
        }
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getScholarships);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getScholarships);
      }
    }
  }
}
