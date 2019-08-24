import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(FAQ());

class FAQ extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FAQState();
  }
}

List faqs = [];
Map faqsJson = {};
File dataFile;

Map<String, String> body;

class _FAQState extends State<FAQ> {
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
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          itemCount: faqs.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                elevation: 20,
                child: Container(
                  child: ExpansionTile(
                    leading: Icon(
                      FontAwesomeIcons.question,
                      size: 20,
                    ),
                    title: Text(faqs[index]['Header'].toString(),
                        style: TextStyle(fontSize: 14, color: Colors.black)),
                    children: <Widget>[
                      Divider(color: Colors.black),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Icon(
                              FontAwesomeIcons.checkCircle,
                              size: 20,
                              color: Colors.green,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                faqs[index]['Inner'].toString(),
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
//        ExpansionTile(
//          title: Text(''),
//
//
//        ),
      ),
    );
  }

  Future getFaqByType() async {
    new Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    body = {};
    try {
      http.Response response = await http
          .post("http://www.muhannadnasri.com/App/faq/data.json", body: body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var Json = json.decode(response.body);
        Directory appDocDir = await getApplicationDocumentsDirectory();
        dataFile = new File(appDocDir.path + "/dataFile.json");

        if (dataFile.existsSync()) {
          if (Json['faq'] != null) {
            dataFile.writeAsStringSync(response.body);
          }
        } else {
          dataFile.createSync();
          dataFile.writeAsStringSync(response.body);
        }

        if (Json['faq'] != null) {
          faqsJson = Json;
        } else {
          faqsJson = json.decode(dataFile.readAsStringSync());
        }

        showLoading(false, context);

        setState(() {
          faqs = faqsJson["faq"];
        });
      } else {}
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getFaqByType);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getFaqByType);
      }
    }
  }
}
