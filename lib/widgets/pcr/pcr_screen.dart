import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Global/global.dart';

class PcrScreen extends StatefulWidget {
  @override
  _PcrScreenState createState() => _PcrScreenState();
}

class _PcrScreenState extends State<PcrScreen> {
  bool loading = true;
  bool sendError = false;

  List<int> selectedAnswers = [];
  List testJson = [];
  String resultJson = "";
  bool isDone = false;
  List answersx = [
    'Strongly Agree',
    'Agree',
    'Neutral',
    'Disagree',
    'Strongly Disagree'
  ];

  void initState() {
    super.initState();
    getTest();
    testJson = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          // Get.to(QuizScreen()
          // QuizScreen
          launchURL('itms-apps://itunes.apple.com/app/id1505380329');
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => PcrScreen(),
          //   ),
          // );
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => QuizScreen(),
          //   ),
          // );
        });
      }),
      bottomNavigationBar: isDone || loading
          ? null
          : BottomAppBar(
              child: GestureDetector(
              onTap: sendError
                  ? () {}
                  : () {
                      sendTest();
                    },
              child: Material(
                elevation: 2,
                shadowColor: Colors.black,
                color: sendError ? Colors.red : Color(0xFF104C90),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    sendError ? "Please Finish Feedback" : "Submit",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            )),
      // backgroundColor: Colors.grey[300],
      // appBar: AppBar(
      //   actions: <Widget>[],
      //   title: Text('Tess'),
      // ),
      appBar: NewGradientAppBar(
        centerTitle: true,
        title: Container(
          // height: 170,
          width: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.scaleDown,
              image: AssetImage(
                'images/skyline_white.png',
              ),
            ),
          ),
        ),
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
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF104C90),
                  Color(0xFF3773AC),
                ],
                stops: [
                  0.7,
                  0.9,
                ],
              ),
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
                        child: Icon(
                          Icons.check,
                          size: 90,
                          color: Colors.white,
                        ),
                        // child: Text(
                        //   resultJson + '✔',
                        //   style: TextStyle(
                        //       fontSize: 25,
                        //       color: Colors.white,
                        //       fontWeight: FontWeight.bold),
                        // ),
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
                // Card(
                //   child: new Column(
                //     children: <Widget>[
                //       new ListTile(
                //         contentPadding:
                //             EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                //         title: Padding(
                //           padding: const EdgeInsets.only(right: 30.0),
                //           child: Column(
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             mainAxisAlignment: MainAxisAlignment.end,
                //             children: [
                //               Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceAround,
                //                 children: [
                //                   Text(
                //                     'Faculty Name:',
                //                     style: TextStyle(fontSize: 12),
                //                   ),
                //                   Text(
                //                     'Null',
                //                     style: TextStyle(fontSize: 12),
                //                   ),
                //                 ],
                //               ),
                //               SizedBox(
                //                 height: 10,
                //               ),
                //               Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceAround,
                //                 children: [
                //                   Text(
                //                     'Course Name:',
                //                     style: TextStyle(fontSize: 12),
                //                   ),
                //                   Text(
                //                     'Null',
                //                     style: TextStyle(fontSize: 12),
                //                   ),
                //                 ],
                //               ),
                //               SizedBox(
                //                 height: 10,
                //               ),
                //               Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceAround,
                //                 children: [
                //                   Text(
                //                     'Batch Code:',
                //                     style: TextStyle(fontSize: 12),
                //                   ),
                //                   Text(
                //                     'Null',
                //                     style: TextStyle(fontSize: 12),
                //                   ),
                //                 ],
                //               ),
                //               SizedBox(
                //                 height: 10,
                //               ),
                //               Row(
                //                 mainAxisAlignment:
                //                     MainAxisAlignment.spaceAround,
                //                 children: [
                //                   Text(
                //                     'Semester ID:',
                //                     style: TextStyle(fontSize: 12),
                //                   ),
                //                   Text(
                //                     'Null',
                //                     style: TextStyle(fontSize: 12),
                //                   ),
                //                 ],
                //               ),
                //             ],
                //           ),
                //         ),
                //         subtitle: Padding(
                //           padding: const EdgeInsets.all(8.0),
                //           child: Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             crossAxisAlignment: CrossAxisAlignment.center,
                //             children: [
                //               Column(
                //                 children: [
                //                   Icon(
                //                     Icons.sentiment_very_satisfied,
                //                     color: Colors.green,
                //                   ),
                //                   Text(
                //                     'Strongly Agree',
                //                     style: TextStyle(fontSize: 12),
                //                   ),
                //                 ],
                //               ),
                //               Column(
                //                 children: [
                //                   Icon(
                //                     Icons.sentiment_satisfied,
                //                     color: Colors.lightGreen,
                //                   ),
                //                   Text(
                //                     'Agree',
                //                     style: TextStyle(fontSize: 12),
                //                   ),
                //                 ],
                //               ),
                //               Column(
                //                 children: [
                //                   Icon(
                //                     Icons.sentiment_neutral,
                //                     color: Colors.amber,
                //                   ),
                //                   Text(
                //                     'Neutral',
                //                     style: TextStyle(fontSize: 12),
                //                   ),
                //                 ],
                //               ),
                //               Column(
                //                 children: [
                //                   Icon(
                //                     Icons.sentiment_dissatisfied,
                //                     color: Colors.redAccent,
                //                   ),
                //                   Text(
                //                     'Disagree',
                //                     style: TextStyle(fontSize: 12),
                //                   ),
                //                 ],
                //               ),
                //               Column(
                //                 children: [
                //                   Icon(
                //                     Icons.sentiment_very_dissatisfied,
                //                     color: Colors.red,
                //                   ),
                //                   Text(
                //                     'Strongly Disagree',
                //                     style: TextStyle(fontSize: 12),
                //                   ),
                //                 ],
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Expanded(
                  child: ListView.builder(
                      itemCount: testJson.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new Card(
                            child: new Column(
                          children: <Widget>[
                            new ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 2),
                              title: Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                                child: Text(
                                  testJson[index]['Q_ID'].replaceAll(' ', '') +
                                      ' ' +
                                      testJson[index]['q_def'],
                                  style: new TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              // leading: Text(testJson[index]['Q_ID']),
                              subtitle: Padding(
                                padding:
                                    const EdgeInsets.only(right: 30.0, top: 20),
                                child: new Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: getAnswers(answersx, index),
                                ),
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
    // List<String, Double> finalAnswers = [];
    List finalAnswers = [];

    var i = 0;
    // for (var item in answers) {
    finalAnswers.add(
      RatingBar.builder(
        glow: false,
        tapOnlyMode: true,

        initialRating: 0,
        itemCount: 5,
        // ignore: missing_return
        itemBuilder: (context, index) {
          switch (index) {
            case 0:
              return Icon(
                Icons.sentiment_very_dissatisfied,
                color: Colors.red,
              );
            case 1:
              return Icon(
                Icons.sentiment_dissatisfied,
                color: Colors.redAccent,
              );
            case 2:
              return Icon(
                Icons.sentiment_neutral,
                color: Colors.amber,
              );
            case 3:
              return Icon(
                Icons.sentiment_satisfied,
                color: Colors.lightGreen,
              );
            case 4:
              return Icon(
                Icons.sentiment_very_satisfied,
                color: Colors.green,
              );
          }
        },
        onRatingUpdate: (rating) {
          print('question' + ' ' + question.toString());

          print('rating' + ' ' + rating.toString());

          // finalAnswers.add(question, rating);
          updateAnswer(question, rating.toInt());
        },
      ),

      //   MyRadioListTile<int>(
      //   title: Text(item),
      //   // selectedColor: selectedAnswers[question][0],
      //   groupValue: selectedAnswers[question],
      //   onChanged: (int answer) {
      //     updateAnswer(question, answer);
      //   },
      //   value: i,
      //   leading: answersIcons[i],
      // )
    );
    //   i++;
    // }

    return finalAnswers;
  }

  void updateAnswer(question, answer) {
    setState(() {
      selectedAnswers[question] = answer;
    });
  }

  Future getTest() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.parse('https://skylineportal.com/moappad/api/test/feedBackFaculty'),
        headers: {
          "API-KEY": API,
        },
      );

      if (response.statusCode == 200) {
        setState(
          () {
            isDone = false;
            loading = false;
            testJson = json.decode(response.body)['data'];
            selectedAnswers = [];
            testJson.forEach((x) {
              selectedAnswers.add(-1);
            });
          },
        );

        showLoading(false, context);
      } else {
        setState(() {
          // TODO: Done
          // isDone = true;
          // loading = false;
          // resultJson = json.decode(response.body);
        });

        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        // showErrorServer(context, getAptitude());

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getTest);
      } else {
        showLoading(false, context);
        // showErrorConnect(context, getAptitude());
        showError(
            "Sorry, we can't connect", Icons.perm_scan_wifi, context, getTest);
      }
    }
  }

  Future sendTest() async {
    if (selectedAnswers.contains(-1)) {
      setState(() {
        sendError = true;
      });

      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          sendError = false;
        });
      });

      return;
    }

    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.parse('https://skylineportal.com/moappad/api/test/apptitudeForm'),
        body: {
          'answers': selectedAnswers.toString(),
          // 'testId': widget.testID,
          // 'courseId': widget.courseID,
        },
      );
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        // showErrorServer(context, getAptitude());

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, sendTest);
      } else {
        showLoading(false, context);
        // showErrorConnect(context, getAptitude());
        showError(
            "Sorry, we can't connect", Icons.perm_scan_wifi, context, sendTest);
      }
    }
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
