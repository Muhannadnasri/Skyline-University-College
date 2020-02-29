import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: coursesJson.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20))),
                          child: ListTile(
                            leading: Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('images/course-img.jpg'))),
                            ),
                            onTap: () {
                              setState(() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Course(
                                      name: coursesJson[index]['Name'],
                                      index: index.toString(),
                                      url: coursesJson[index]['Link']
                                          .replaceAll('\/', '/'),
                                    ),
                                  ),
                                );
                              });
                            },
                            title: Text(
                              coursesJson[index]['Name'],
                            ),
                            trailing: Icon(Icons.arrow_forward),
                          ),
                        ),
                      );
                    }),
              ),
            ),
    );
  }

  void _showLoadingCourseCourse(isLoading, context) {
    if (isLoading) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () {},
              child: new AlertDialog(
                title: Stack(
                  children: <Widget>[
                    Image.asset(
                      isDark(context)
                          ? 'images-white/logo.png'
                          : 'images/logo.png',
                      height: 50,
                      color: isDark(context) ? Colors.white : Colors.black,
                    ),
                    Image.asset(
                      isDark(context)
                          ? 'images-white/logo.png'
                          : 'images/logo.png',
                      height: 50,
                    ),
                  ],
                ),
                shape: SuperellipseShape(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("Back"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
                content: Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      new Text(
                          'Please Wait....  \nBe info the loading will take around 1 min depend on your study materials.... \nYou can go back anytime by click back button '),
                    ],
                  ),
                ),
              ),
            );
          });
    } else {
      Navigator.pop(context);
    }
  }

  Future getCourses() async {
    Future.delayed(Duration.zero, () {
      _showLoadingCourseCourse(true, context);
    });

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
        _showLoadingCourseCourse(false, context);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        _showLoadingCourseCourse(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getCourses);
      } else {
        _showLoadingCourseCourse(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getCourses);
      }
    }
  }
}
