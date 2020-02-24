import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(Courses());

class Courses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CoursesState();
  }
}

class _CoursesState extends State<Courses> with TickerProviderStateMixin {
  List coursesJson = [];
  List courseJson=[];
  String url = '';
  @override
  void initState() {
    getCourses();
    // getCourse();

    super.initState();
    coursesJson = [];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: appBarLogin(context, 'Courses'),
      body: coursesJson == null || coursesJson.isEmpty
          ? exception(context)
          : Container(
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text(
                        'My Courses',
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GridView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: coursesJson.length,
                      gridDelegate:
                          new SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                url = coursesJson[index]['Link'];
                                getCourse();
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Center(
                                    child: Text(
                                  coursesJson[index]['Name'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.left,
                                )),
                              ),
                            ),
                          ),
                        );
                      }),
                ],
              ),
            ),
    );
  }

  Future getCourses() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    final stopwatch = Stopwatch()..start();
    try {
      http.Response response = await http.post(
        Uri.encodeFull("http://www.muhannadnasri.com/App/login/index.php"),
        body: {'username': username, 'password': password},
      );
      // .timeout(Duration(seconds: 50)F
      // );

      if (response.statusCode == 200) {
        setState(() {
          coursesJson = json.decode(response.body);
          // cdpCourseMessageJson = json.decode(response.body);
        });
        showLoading(false, context);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getCourses);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getCourses);
      }
    }
    print('doSomething() executed in ${stopwatch.elapsed}');
  }


  Future getCourse() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    final stopwatch = Stopwatch()..start();
    try {
      http.Response response = await http.post(
        Uri.encodeFull("http://www.muhannadnasri.com/App/login/course.php"),
        body: {'username': username, 'password': password, 'url': url},
      );
      // .timeout(Duration(seconds: 50)
      // );

      if (response.statusCode == 200) {
        setState(() {
          courseJson = json.decode(response.body);
        });
        showLoading(false, context);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getCourses);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getCourses);
      }
    }
    print('doSomething() executed in ${stopwatch.elapsed}');
  }
  // Future<void> shareCDP(link) async {
  //   _showLoading(true);
  //   try {
  //     var request = await HttpClient().getUrl(Uri.parse(link));
  //     var response = await request.close();
  //     Uint8List bytes = await consolidateHttpClientResponseBytes(response);
  //     await Share.file(
  //         'Share Document', 'Document.pdf', bytes, 'application/pdf');
  //     Future.delayed(const Duration(seconds: 1), () {
  //       _showLoading(false);
  //     });
  //   } catch (e) {}
  // }
}
