import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;


class ApptitudeTest extends StatefulWidget {
  @override
  _ApptitudeTestState createState() => _ApptitudeTestState();
}

class _ApptitudeTestState extends State<ApptitudeTest> {
  bool loading = true;
  bool yes = false;

  Map sendAptitudesJson = {};


  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        actions: <Widget>[],
      ),
      body: Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      itemCount: aptitudeJson.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new Card(
                            child: new Column(
                          children: <Widget>[
                            new ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 2),
                              title: textUpdate(context),


                              subtitle: Padding(
                                padding: const EdgeInsets.only(right: 30.0),
                                child: Row(
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Checkbox(
                                          activeColor: Colors.blue,
                                          value: yes,
                                          onChanged: (value) {
                                            value = true;
                                            setState(() {
                                              yes = value;
                                            });
                                          },
                                        ),
                                        Text('Yes'),
                                      ],
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Checkbox(
                                          activeColor: Colors.blue,
                                          value: yes,
                                          onChanged: (value) {
                                            setState(() {
                                              yes = value;
                                            });
                                          },
                                        ),
                                        Text('No'),
                                      ],
                                    ),
                                  ],
                                ),
                                // child: new Column(
                                //     mainAxisAlignment: MainAxisAlignment.start,
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     children:
                                //         getAnswers(testJson[index][1], index)

                                //         ),
                              ),
                            )
                          ],
                        ));
                      }),
                ),
              ],
            ),
    );
  }


Widget textUpdate(BuildContext context) {
    var i = 0;

return Container(

child: Text(aptitudeJson[i]['q']),

);
    
    i++;

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
          'question_id': '',
          'answer': '',
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            // reinStatementJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }

      if (sendAptitudesJson['success'] == '1') {
        showLoading(false, context);
      }
    } catch (x) {
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
