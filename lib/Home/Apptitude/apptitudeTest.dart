import 'package:flutter/material.dart';
import 'package:skyline_university/Global/global.dart';

class ApptitudeTest extends StatefulWidget {
  @override
  _ApptitudeTestState createState() => _ApptitudeTestState();
}

class _ApptitudeTestState extends State<ApptitudeTest> {
  bool loading = true;
  bool yes = false;

  Map sendAptitudesJson = {};
  List<int> selectedAnswers = [];

  bool isDone = false;

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: isDone || loading
          ? null
          : BottomAppBar(
              child: GestureDetector(
              onTap: () {
                print(selectedAnswers.toString());
                // sendAptitudes();
              },
              child: Material(
                elevation: 3,
                shadowColor: Colors.black,
                color: Colors.green,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "انهاء الامتحان",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            )),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        actions: <Widget>[],
        // title: Text(widget.testName),
      ),
      body: isDone && !loading
          ? Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Container(
                        alignment: Alignment.center,
                        height: 120,
                        width: 120,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                        ),
                        child: Text(
                          '%',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Text(
                      'لقد قمت بتقديم هذا الامتحان',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            )
          : Column(
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
                              title: Text(
                                aptitudeJson[index]['question'],
                              ),


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

  List<Widget> getAnswers(answers, question) {
    List<Widget> finalAnswers = [];
    var i = 0;
    for (var item in answers) {
      finalAnswers.add(RadioListTile(
        title: Text(item),
        value: i,
        groupValue: selectedAnswers[question],
        onChanged: (int answer) {
          updateAnswer(question, answer);
        },
      ));
      i++;
    }

    return finalAnswers;
  }

  void updateAnswer(question, answer) {
    setState(() {
      selectedAnswers[question] = answer;
    });
  }

  // Future sendAptitudes() async {
  //   Future.delayed(Duration.zero, () {
  //     showLoading(true, context);
  //   });

  //   try {
  //     final response = await http.post(
  //       Uri.encodeFull(
  //           'https://skylineportal.com/moappad/api/web/appealReinstatement'),
  //       headers: {
  //         "API-KEY": API,
  //       },
  //       body: {
  //         'user_id': username,
  //         'attend_class': semester,
  //         'incomplete_grades': incomplete ? "True" : "False",
  //         'medical_conditions': medical ? "True" : "False",
  //         'death_in_family': death ? "True" : "False",
  //         'personal_circumstances': personal ? "True" : "False",
  //         'other': other ? "True" : "False",
  //         'documentry': documentry,
  //         'usertype': studentJson['data']['user_type'],
  //         'ipaddress': '1',
  //         'deviceid': '1',
  //         'devicename': '1',
  //       },
  //     ).timeout(Duration(seconds: 35));

  //     if (response.statusCode == 200) {
  //       setState(
  //         () {
  //           // reinStatementJson = json.decode(response.body);
  //         },
  //       );
  //       showLoading(false, context);
  //     }

  //     if (sendAptitudesJson['success'] == '1') {
  //       showLoading(false, context);
  //     }
  //   } catch (x) {
  //     if (x.toString().contains("TimeoutException")) {
  //       showLoading(false, context);

  //       showError("Time out from server", FontAwesomeIcons.hourglassHalf,
  //           context, sendAptitudes);
  //     } else {
  //       showLoading(false, context);
  //       showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
  //           sendAptitudes);
  //     }
  //   }
  // }
}
