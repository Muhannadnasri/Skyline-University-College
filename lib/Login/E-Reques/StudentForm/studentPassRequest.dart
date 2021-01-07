import 'dart:convert';

import 'package:circular_check_box/circular_check_box.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(StudentPassRequest());

class StudentPassRequest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentPassRequestState();
  }
}

// Map<String, int> body;

class _StudentPassRequestState extends State<StudentPassRequest> {
  String date = DateFormat("yyyy-MM-dd").format(DateTime.now());

  int miscID = 0;
  TextEditingController miscNameCnt = new TextEditingController();

  List marksPassJson = [];
  List<bool> selectedMarksPassJson = new List<bool>();

  List sendletterRequestJson = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getResitMarksCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      bottomNavigationBar: bottomappBar(
        context,
        () {
          if (selectedMarksPassJson.contains(true)) {
            insertPassRequest();
          } else {
            return;
          }
          // showfailureSnackBar(context,
          //     'Your request submitted failed. Please contact IT department');
        },
      ),
      // bottomNavigationBar: BottomAppBar(
      //   elevation: 0,
      //   color: Colors.transparent,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       FloatingActionButton.extended(
      //         //
      //         backgroundColor:
      //             isDark(context) ? Color(0xFF121212) : Color(0xFF275d9b),

      //         label: const Text('Submit'),
      //         icon: const Icon(Icons.add),
      //         elevation: 4.0,
      //         // child: const Icon(Icons.add),
      //         onPressed: () {},
      //       ),
      //       // Material(
      //       //   borderRadius: BorderRadius.circular(25.0),
      //       //   color: isDark(context) ? Color(0xFF121212) : Color(0xFF275d9b),
      //       //   child: Padding(
      //       //     padding: const EdgeInsets.all(15.0),
      //       //     child: Text(
      //       //       "Submit",
      //       //       style: TextStyle(color: Colors.white, fontSize: 20),
      //       //     ),
      //       //   ),
      //       // ),
      //     ],
      //   ),
      // ),
      // bottomNavigationBar: bottomappBar(
      //   context,
      //   () {},
      // ),
      appBar: appBarLogin(context, 'Letter Request'),

      // appBar: appBarLogin(context, 'Letter Request'),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        // color: Color(0xffbF8F9FB),
        child: ListView(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  coursesReset(),

                  // letterRequest
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget coursesReset() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Courses',
          style:
              TextStyle(color: isDark(context) ? Colors.white : Colors.black),
        ),
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: Container(
            height: MediaQuery.of(context).size.height / 3,
            child: ListView.builder(
                // shrinkWrap: true,
                // shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: marksPassJson.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    // children: [
                    leading: CircularCheckBox(
                        activeColor: Color(0xFF3773AC),
                        value: selectedMarksPassJson[index],
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        onChanged: (bool x) {
                          setState(() {
                            // x = resitList[index];
                            selectedMarksPassJson[index] = x;
                            print(selectedMarksPassJson);
                            // resitSelected = !resitSelected;
                          });
                        }),
                    isThreeLine: true,

                    title: Text(
                      marksPassJson[index]['Courses'],
                      style: TextStyle(
                          color: isDark(context) ? Colors.white : Colors.black),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          marksPassJson[index]['Batch ID'],
                          style: TextStyle(
                              color: isDark(context)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                        Text(
                          marksPassJson[index]['Course Code'],
                          style: TextStyle(
                              color: isDark(context)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ],
                    ),
                    trailing: Text(
                      marksPassJson[index]['Over All Grade'],
                      style: TextStyle(
                          color: isDark(context) ? Colors.white : Colors.black),
                    ),
                    // ],
                  );
                }),
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Future getResitMarksCourses() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      selectedMarksPassJson = [];
      marksPassJson = [];
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/CoursesPassRequest'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
        },
      );

      if (response.statusCode == 200) {
        setState(
          () {
            marksPassJson = json.decode(response.body)['data'];
            for (int i = 0; i < marksPassJson.length; i++) {
              selectedMarksPassJson.add(false);
            }
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getResitMarksCourses);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getResitMarksCourses);
      }
    }
  }

  Future insertPassRequest() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    int i = -1;

    selectedMarksPassJson.forEach((selectedMarksPassJson) async {
      i++;
      if (selectedMarksPassJson) {
        try {
          final response = await http.post(
            Uri.encodeFull(
                'https://skylineportal.com/moappad/api/test/InsertRepaeatingCoursess'),
            headers: {
              "API-KEY": API,
            },
            body: {
              'Stud_ID': username,
              'Batch_ID': marksPassJson[i]['Batch_ID'],
              'Grade': marksPassJson[i]['Over All Grade'],
              'CreatedDate': date.toString(),
            },
          ).timeout(Duration(seconds: 35));

          // showfailureSnackBar(context,
          //     'Your request submitted failed. Please contact IT department');
          if (response.statusCode == 200) {
            showLoading(false, context);

            vottomSheetSuccess(context);
          } else {
            showLoading(false, context);

            bottomSheetFailure(context);
          }
        } catch (x) {
          if (x.toString().contains("TimeoutException")) {
            showLoading(false, context);
            showError("Time out from server", FontAwesomeIcons.hourglassHalf,
                context, insertPassRequest);
          } else {
            showLoading(false, context);
            showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
                insertPassRequest);
          }
        }
      }
    });

    //send confirmation
  }
}
