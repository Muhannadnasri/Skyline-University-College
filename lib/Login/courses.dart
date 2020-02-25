import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';

import '../Home/Gallery/oneGallery.dart';
import 'course.dart';

void main() => runApp(Courses());

class Courses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CoursesState();
  }
}

class _CoursesState extends State<Courses> with TickerProviderStateMixin {
  List coursesJson = [];

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
                              childAspectRatio: 1.2,
                              crossAxisSpacing: 20,
                              mainAxisSpacing: 20,
                              crossAxisCount: 2),
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 25.0,
                                  backgroundImage: NetworkImage(
                                      "https://lmsserver.skylineuniversity.ac.ae/my/images/course-img1.jpg"),
                                  backgroundColor: Colors.transparent,
                                ),
                                // Container(
                                //   height: 50,
                                //   width: 50,
                                //   decoration: BoxDecoration(
                                //       borderRadius:
                                //           BorderRadius.circular(15.0),
                                //       image: DecorationImage(
                                //           image: NetworkImage(
                                //               'https://lmsserver.skylineuniversity.ac.ae/my/images/course-img1.jpg'))),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(
                                      child: FittedBox(
                                    child: Text(
                                      coursesJson[index]['Name'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  )),
                                ),

                                Center(
                                  child: Container(
                                    child: RaisedButton(
                                      onPressed: () {
                                        setState(() {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => Course(
                                                url: url,
                                              ),
                                            ),
                                          );

                                          // Course
                                          url = coursesJson[index]['Link']
                                              .replaceAll('\/', '/');
                                          print(url);
                                          // getCourse();
                                        });
                                      },
                                      color: Color.fromARGB(255, 57, 179, 230),
                                      child: Text('Go to Course'),
                                      textColor: Colors.white,
                                    ),
                                  ),
                                )
                              ],
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
}
