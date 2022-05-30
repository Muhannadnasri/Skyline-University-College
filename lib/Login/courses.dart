import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/widgets/card_courses.dart';
import 'package:skyline_university/widgets/header.dart';

void main() => runApp(Courses());

class Courses extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CoursesState();
  }
}

class _CoursesState extends State<Courses> with TickerProviderStateMixin {
  List coursesJson = [];
  List itemsToShow = [];

  bool isLoading = true;
  var selectedCourse = TextEditingController();

  String url = '';
  FocusNode myFocusNode;

  @override
  @override
  void initState() {
    selectedCourse.text = '';
    getCourses();

    super.initState();
    coursesJson = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size(double.infinity, 100),
      //   child: SafeArea(
      //     child: Row(
      //       mainAxisAlignment: MainAxisAlignment.end,
      //       children: <Widget>[
      //         Container(
      //           margin:
      //               new EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
      //           height: 44,
      //           width: 44,
      //           child: TextButton(
      //             padding: EdgeInsets.all(0),
      //             color: Colors.white.withOpacity(0.3),
      //             child: Icon(Icons.menu, color: Colors.white),
      //             shape: new RoundedRectangleBorder(
      //               borderRadius: new BorderRadius.circular(10.0),
      //             ),
      //             onPressed: () {
      //               debugPrint("Menu pressed");
      //             },
      //           ),
      //         ),
      //       ],
      //     ),
      //   ),
      // ),
      appBar: appBarLogin(context, 'Courses'),
      body:

          // coursesJson == null || coursesJson.isEmpty
          //     ? exception(context, isLoading)
          //     :

          Stack(
        children: <Widget>[
          Header(),
          Padding(
            padding: EdgeInsets.all(20),
            child: ListView(
              scrollDirection: Axis.vertical,
              children: <Widget>[
                SizedBox(height: 40),
                // Text(
                //   "Welcome back\nStudent!",
                //   style: TextStyle(
                //       fontSize: 34,
                //       fontWeight: FontWeight.w900,
                //       color: Colors.white),
                // ),
                // SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: TextField(
                    onChanged: (x) {
                      selectedCourse.text = x;
                      searchItems();
                    },
                    focusNode: myFocusNode,
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black,
                    ),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      hintText: "Search courses",
                      hintStyle: TextStyle(
                        color: isDark(context) ? Colors.black : Colors.black,
                        fontSize: 15.0,
                      ),
                    ),
                    maxLines: 1,
                  ),
                ),

                SizedBox(height: 20),

                // 3. Start Learning Button Section

                SizedBox(height: 20.0),

                Text("Courses",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )),

                SizedBox(height: 20.0),

                // List of courses

                ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: itemsToShow.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildItems(index);
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  buildItems(index) {
    return CardCourses(
      image: Image.asset('images/course-logo.png', width: 40, height: 40),
      color: Color(0xFF527daf),
      title: itemsToShow[index]['Cdd_Description'],
      hours: itemsToShow[index]['FACULTYNAME'],
      subTitle: itemsToShow[index]['BatchCode'],
    );
  }

  void searchItems() {
    setState(() {
      itemsToShow = coursesJson.where((i) {
        if (selectedCourse.text.toUpperCase() != "" &&
            !i['Cdd_Description']
                .toString()
                .contains(selectedCourse.text.toUpperCase())) return false;

        return true;

        // if(archive==0){}
      }).toList();
    });
  }

  Future getCourses() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.parse("https://skylineportal.com/moappad/api/test/StudentCourses"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'StudID': username,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          coursesJson = json.decode(response.body)['data'];
          itemsToShow = coursesJson;
          selectedCourse.text = '';
          isLoading = false;
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
  }
}
