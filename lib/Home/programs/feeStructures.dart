import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;

import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/pdfView.dart';

void main() => runApp(FeeStructures());

class FeeStructures extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FeeStructuresState();
  }
}

class _FeeStructuresState extends State<FeeStructures> {
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
      appBar: appBar(context, 'Skyline Info'),
      body: ListView.builder(
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
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      infoJson[index]['title'] == "NON-VISA APPLICANT (NORMAL)"
                          ? Row(
                              children: <Widget>[
                                Text('NON-VISA APPLICANT (NORMAL)'),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PdfView(
                                              url: infoJson[index]
                                                  ['page_content']),
                                        ),
                                      );
                                    },
                                    child: Icon(FontAwesomeIcons.vectorSquare))
                              ],
                            )
                          : infoJson[index]['title'] ==
                                  "VISA APPLICANT (NORMAL)"
                              ? Row(
                                  children: <Widget>[
                                    Text('VISA APPLICANT (NORMAL)'),
                                    GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => PdfView(
                                                  url: infoJson[index]
                                                      ['page_content']),
                                            ),
                                          );
                                        },
                                        child:
                                            Icon(FontAwesomeIcons.vectorSquare))
                                  ],
                                )
                              : infoJson[index]['title'] ==
                                      "NON-VISA APPLICANT (WEEKEND)"
                                  ? Row(
                                      children: <Widget>[
                                        Text('NON-VISA APPLICANT (WEEKEND)'),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => PdfView(
                                                      url: infoJson[index]
                                                          ['page_content']),
                                                ),
                                              );
                                            },
                                            child: Icon(
                                                FontAwesomeIcons.vectorSquare))
                                      ],
                                    )
                                  : infoJson[index]['title'] ==
                                          "INTERNATIONAL VISA APPLICANT"
                                      ? Row(
                                          children: <Widget>[
                                            Text(
                                                'INTERNATIONAL VISA APPLICANT'),
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          PdfView(
                                                              url: infoJson[
                                                                      index][
                                                                  'page_content']),
                                                    ),
                                                  );
                                                },
                                                child: Icon(FontAwesomeIcons
                                                    .vectorSquare))
                                          ],
                                        )
                                      : infoJson[index]['title'] ==
                                              "MISCELLANEOUS FEES"
                                          ? Row(
                                              children: <Widget>[
                                                Text('MISCELLANEOUS FEES'),
                                                GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              PdfView(
                                                                  url: infoJson[
                                                                          index]
                                                                      [
                                                                      'page_content']),
                                                        ),
                                                      );
                                                    },
                                                    child: Icon(FontAwesomeIcons
                                                        .vectorSquare))
                                              ],
                                            )
                                          : SizedBox()
                    ],
                  ),
                )),
                Container(
                    child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: <Widget>[
                      infoJson[index]['title']== 'MBA' ?
                    Html(data: infoJson[index]['page_content'],):SizedBox(),
                      infoJson[index]['id'] == 52
                          ? Row(
                              children: <Widget>[
                                Text('NORMAL'),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => PdfView(
                                              url: infoJson[index]
                                                  ['page_content']),
                                        ),
                                      );
                                    },
                                    child: Icon(FontAwesomeIcons.vectorSquare))
                              ],
                            )
                          : SizedBox()
                    ],
                  ),
                )),
              ],
            );
          }),
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
          'name': 'Fee Structures',
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
