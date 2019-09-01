import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(ApptitudeTest());

class ApptitudeTest extends StatefulWidget {
  @override
  _ApptitudeTestState createState() => _ApptitudeTestState();
}

class _ApptitudeTestState extends State<ApptitudeTest> {
  Map sendAptitudesJson = {};
  int cQuesiton = 0;
  String btnName = "Next";
  int answer = -1;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarLogin(context, 'ApptitudeTest'),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: PageView(
                  children: <Widget>[
                    Text(aptitudeJson.take(5).toList()[cQuesiton]['question'])
                  ],
                ),
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Card(
                    color: Colors.grey[200],
                    elevation: 5,
                    child: ListTileTheme(
                      selectedColor: Colors.green,
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            answer = 1;
                          });
                        },
                        selected: answer == 1,
                        title: Center(
                          child: Text(
                            'Yes',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Card(
                    color: Colors.grey[200],
                    elevation: 5,
                    child: ListTileTheme(
                      selectedColor: Colors.red,
                      child: ListTile(
                        onTap: () {
                          setState(() {
                            answer = 0;
                          });
                        },
                        selected: answer == 0,
                        title: Center(
                            child: Text(
                          'No',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        if (cQuesiton <
                           aptitudeJson. take(5).toList().length - 1) {
                          if (answer != -1) {
                            sendAptitudes();
                          }
                          answer = -1;
                          cQuesiton++;
                          btnName = "Next"; //remove
                        } else {

                            btnName = "Finish";


                          showDoneInput(sendAptitudesJson['message'], context);
                        }
                      });
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Material(
                        elevation: 3,
                        shadowColor: Colors.black,
                        color: Color(0xFF275d9b),
                        type: MaterialType.button,
                        child: Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: Text(
                            btnName,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }

  Future sendAptitudes() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/apptitudeAnswer'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'student_id': username,
          'question_id': aptitudeJson[cQuesiton]['id'].toString(),
          'answer': answer.toString(),
          'usertype': 'Guest',
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        print('yes');
        setState(
          () {
            sendAptitudesJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, sendAptitudes);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            sendAptitudes);
      }
    }
  }
}
