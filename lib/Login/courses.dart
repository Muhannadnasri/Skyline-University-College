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
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: ClampingScrollPhysics(),
                    itemCount: coursesJson.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        child: ListTile(
                          leading: ClipRRect(
                            borderRadius: new BorderRadius.circular(7.0),
                            child: Container(
                              margin: EdgeInsets.all(5),
                              width: 50,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('images/course-img.jpg'))),
                            ),
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
                      );
                    }),
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
