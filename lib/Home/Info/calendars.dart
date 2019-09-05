import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/pdfView.dart';

void main() => runApp(Calendars());

class Calendars extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CalendarsState();
  }
}

class _CalendarsState extends State<Calendars> {
  List infoJson = [];

  @override
  void initState() {
    super.initState();
    infoJson = [];
    getPrograms();
//print('Image Number'+widget.oneGalleryPhotos);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: appBar(context, 'Fee Structures'),
      body: infoJson.isEmpty
          ? exception(context, FontAwesomeIcons.exclamationTriangle, '')
          : ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      child: Image.network(infoJson[0]['page_content']),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        child: Column(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Html(
                                      data: infoJson[1]['page_content'],
                                      defaultTextStyle:
                                          TextStyle(color: Colors.green),
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfView(
                                                            url: infoJson[2][
                                                                'page_content']),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                infoJson[2]['title'],
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.blue),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfView(
                                                            url: infoJson[3][
                                                                'page_content']),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                infoJson[3]['title'],
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.blue),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfView(
                                                            url: infoJson[4][
                                                                'page_content']),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                infoJson[4]['title'],
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.blue),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfView(
                                                            url: infoJson[5][
                                                                'page_content']),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                infoJson[5]['title'],
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.blue),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfView(
                                                            url: infoJson[6][
                                                                'page_content']),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                infoJson[6]['title'],
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.blue),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Html(
                                      data: infoJson[7]['page_content'],
                                      defaultTextStyle:
                                          TextStyle(color: Colors.green),
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfView(
                                                            url: infoJson[8][
                                                                'page_content']),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                infoJson[8]['title'],
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.blue),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfView(
                                                            url: infoJson[9][
                                                                'page_content']),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                infoJson[9]['title'],
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.blue),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfView(
                                                            url: infoJson[10][
                                                                'page_content']),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                infoJson[10]['title'],
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.blue),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfView(
                                                            url: infoJson[11][
                                                                'page_content']),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                infoJson[11]['title'],
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.blue),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfView(
                                                            url: infoJson[12][
                                                                'page_content']),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                infoJson[12]['title'],
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.blue),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfView(
                                                            url: infoJson[13][
                                                                'page_content']),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                infoJson[13]['title'],
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.blue),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfView(
                                                            url: infoJson[14][
                                                                'page_content']),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                infoJson[14]['title'],
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.blue),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfView(
                                                            url: infoJson[15][
                                                                'page_content']),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                infoJson[15]['title'],
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.blue),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    child: Html(
                                      data: infoJson[16]['page_content'],
                                      defaultTextStyle:
                                          TextStyle(color: Colors.purple),
                                    ),
                                  ),
                                  Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfView(
                                                            url: infoJson[17][
                                                                'page_content']),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                infoJson[17]['title'],
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.blue),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfView(
                                                            url: infoJson[18][
                                                                'page_content']),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                infoJson[18]['title'],
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.blue),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfView(
                                                            url: infoJson[19][
                                                                'page_content']),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                infoJson[19]['title'],
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.blue),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfView(
                                                            url: infoJson[20][
                                                                'page_content']),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                infoJson[20]['title'],
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.blue),
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        PdfView(
                                                            url: infoJson[21][
                                                                'page_content']),
                                                  ),
                                                );
                                              },
                                              child: Text(
                                                infoJson[21]['title'],
                                                style: TextStyle(
                                                    decoration: TextDecoration
                                                        .underline,
                                                    color: Colors.blue),
                                              )),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
    );
  }

  Future getPrograms() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull("https://skylineportal.com/moappad/api/web/getPageInfo"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'usertype': '1',
          'name': 'SUC Calendars',
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          infoJson = json.decode(response.body)['data'];
        });
        print(infoJson.toString());
        showLoading(false, context);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getPrograms);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getPrograms);
      }
    }
  }
}
