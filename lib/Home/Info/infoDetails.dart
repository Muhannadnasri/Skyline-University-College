import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/htmlSecation.dart';

void main() => runApp(InfoDetails());

class InfoDetails extends StatefulWidget {
  final String name;

  const InfoDetails({Key key, this.name}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _InfoDetailsState();
  }
}

class _InfoDetailsState extends State<InfoDetails> {
  List infoJson = [];
  bool isLoading = true;
  Map infoJsonMessage = {};
  @override
  void initState() {
    super.initState();
    getPrograms();

    // infoJson = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: appBar(context, widget.name),
      body: infoJson == null || infoJson.isEmpty
          ? exception(context, isLoading)
          : ListView.builder(
              itemCount: infoJson.length,
              itemBuilder: (BuildContext context, int index) {
                return htmlSecation(
                    context,
                    infoJson[index]['type'] == 'url',
                    infoJson[index]['page_content'],
                    infoJson[index]['title'],
                    infoJson[index]['page_content']);
              }),
    );
  }

  Future getPrograms() async {
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
          'name': widget.name,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          infoJson = json.decode(response.body)['data'];
          infoJsonMessage = json.decode(response.body);
          isLoading = false;
        });

        showLoading(false, context);

        // if (infoJsonMessage['success'] == '1') {
        //   showSuccessSnackBar(context, infoJsonMessage['message']);
        // }
      }
    } catch (x) {
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
