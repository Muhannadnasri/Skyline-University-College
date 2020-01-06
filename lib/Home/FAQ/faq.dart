import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(FAQ());

class FAQ extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FAQState();
  }
}

class _FAQState extends State<FAQ> {
  List faqsJson = [];

  Map faqsJsonMessage = {};
  @override
  void initState() {
    super.initState();

    getFaqByType();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: appBar(context, 'FAQ?  '),
      body: faqsJson == null || faqsJson.isEmpty
          ? exception(context)
          : ListView.builder(
              itemCount: faqsJson.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: BeveledRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    elevation: 20,
                    child: Container(
                      child: Theme(
                        data: ThemeData(
                            accentColor:
                                isDark(context) ? Colors.white : Colors.black,
                            unselectedWidgetColor:
                                isDark(context) ? Colors.white : Colors.black),
                        child: ExpansionTile(
                          leading: Icon(
                            FontAwesomeIcons.question,
                            size: 20,
                          ),
                          title: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(faqsJson[index]['question'].toString(),
                                style: TextStyle(
                                    fontSize: 14,
                                    color: isDark(context)
                                        ? Colors.white
                                        : Colors.black)),
                          ),
                          children: <Widget>[
                            Divider(color: Colors.black),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                faqsJson[index]['answer'].toString(),
                                style: TextStyle(
                                    fontSize: 13,
                                    color: isDark(context)
                                        ? Colors.white
                                        : Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }

  Future getFaqByType() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull("https://skylineportal.com/moappad/api/test/FaqByType"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'faq_type': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          faqsJson = json.decode(response.body)['data'];
          faqsJsonMessage = json.decode(response.body);
        });

        showLoading(false, context);
        if (faqsJsonMessage['success'] == '0') {
          showfailureSnackBar(context, faqsJsonMessage['message']);
        }
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        // showErrorServer(context, getFaqByType());
      } else {
        showLoading(false, context);
        // showErrorConnect(context, getFaqByType());
      }
    }
  }
}
