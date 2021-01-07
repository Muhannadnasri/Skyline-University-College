import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';

import 'oneCourse.dart';

void main() => runApp(Course());

class Course extends StatefulWidget {
  final String url;
  final String name;
  final String index;
  const Course({Key key, this.url, this.name, this.index}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CoursesState();
  }
}

class _CoursesState extends State<Course> with TickerProviderStateMixin {
  List courseJson = [];
  bool isLoading = true;
  @override
  void initState() {
    getCourse();
    // getCourse();

    super.initState();
    courseJson = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarLogin(context, widget.name),
      body: courseJson == null || courseJson.isEmpty
          ? exception(context, isLoading)
          : Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: <Widget>[
                    Container(
                      height: 100,
                      child: Center(
                          child: Text(
                        widget.name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: courseJson.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              elevation: 10,
                              child: ListTile(
                                contentPadding: EdgeInsets.all(10),
                                leading: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius:
                                        new BorderRadius.circular(7.0),
                                  ),
                                  width: 50,
                                  height: 50,
                                  child: Center(
                                      child: Text('0' + index.toString())),
                                  // margin: EdgeInsets.all(5),
                                  // decoration: BoxDecoration(
                                  //   image: DecorationImage(
                                  //     image: AssetImage('images/course-img.jpg'),
                                  //   ),
                                  // ),
                                ),

                                // leading: Container(
                                //   decoration: BoxDecoration(
                                //       image: DecorationImage(
                                //           image: AssetImage(
                                //               'images/course-img.jpg'))),
                                // ),
                                onTap: () {
                                  setState(() {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => OneCourse(
                                            name: courseJson[index]
                                                ['weeknName'],
                                            fileName: courseJson[index]
                                                ['fileName'],
                                            icon: courseJson[index]['icon'],
                                            downlaod: courseJson[index]
                                                ['downlaod']),
                                      ),
                                    );
                                  });
                                },
                                title: Align(
                                  child: Text(
                                    courseJson[index]['weeknName'].toString(),
                                  ),
                                  alignment: Alignment(-1, 0),
                                ),
                                trailing: Icon(Icons.arrow_forward),
                              ),
                            ),
                          );

                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: GestureDetector(
                          //     onTap: () {
                          //       setState(() {
                          //         // Navigator.push(
                          //         //   context,
                          //         //   MaterialPageRoute(
                          //         //     builder: (context) => Course(
                          //         //       url: url,
                          //         //     ),
                          //         //   ),
                          //         // );

                          //         // // Course
                          //         // url = courseJson[index]['Link']
                          //         //     .replaceAll('\/', '/');
                          //         // print(url);
                          //         // // getCourse();
                          //       });
                          //     },
                          //     child: Container(
                          //       decoration: BoxDecoration(
                          //         shape: BoxShape.rectangle,
                          //         border: Border.all(color: Colors.black),
                          //         borderRadius: BorderRadius.circular(15.0),
                          //       ),
                          //       child: Column(
                          //         crossAxisAlignment: CrossAxisAlignment.start,
                          //         children: <Widget>[
                          //           Text(courseJson[index]['weeknName']
                          //               .toString()),

                          //           ListView.builder(
                          //               shrinkWrap: true,
                          //               physics: ClampingScrollPhysics(),
                          //               itemCount: courseJson.length,
                          //               itemBuilder:
                          //                   (BuildContext context, int index) {
                          //                 return Card(
                          //                   child: Text(''),
                          //                 );
                          //               }),

                          //           Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: CircleAvatar(
                          //               radius: 25.0,
                          //               backgroundImage: NetworkImage(
                          //                   "https://lmsserver.skylineuniversity.ac.ae/my/images/course-img1.jpg"),
                          //               backgroundColor: Colors.transparent,
                          //             ),
                          //           ),
                          //           // Container(
                          //           //   height: 50,
                          //           //   width: 50,
                          //           //   decoration: BoxDecoration(
                          //           //       borderRadius:
                          //           //           BorderRadius.circular(15.0),
                          //           //       image: DecorationImage(
                          //           //           image: NetworkImage(
                          //           //               'https://lmsserver.skylineuniversity.ac.ae/my/images/course-img1.jpg'))),
                          //           // ),
                          //           Padding(
                          //             padding: const EdgeInsets.all(8.0),
                          //             child: Center(
                          //                 child: Text(
                          //               courseJson[index]['weeknName'],
                          //               style: TextStyle(
                          //                 fontWeight: FontWeight.bold,
                          //               ),
                          //               textAlign: TextAlign.left,
                          //             )),
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // );
                        }),
                  ],
                ),
              ),
            ),
    );
  }

  Future getCourse() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull("http://www.muhannadnasri.com/App/login/course.php"),
        body: {'username': username, 'password': password, 'url': widget.url},
      );
      // .timeout(Duration(seconds: 50)
      // );

      if (response.statusCode == 200) {
        setState(() {
          courseJson = json.decode(response.body);
          isLoading = false;
        });
        showLoading(false, context);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getCourse);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getCourse);
      }
    }
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
