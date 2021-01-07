import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(OneCourse());

class OneCourse extends StatefulWidget {
  final String fileName;
  final String name;
  final String icon;
  final String downlaod;
  const OneCourse({Key key, this.fileName, this.icon, this.downlaod, this.name})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _OneCoursesState();
  }
}

class _OneCoursesState extends State<OneCourse> with TickerProviderStateMixin {
  // bool isLoading = true;
  @override
  void initState() {
    // getOneCourse();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarLogin(
        context,
        widget.name.toString(),
      ),
      body:
          //  widget.fileName == null
          //     ? exception(context, isLoading)
          //     :
          Container(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(shrinkWrap: true, physics: ClampingScrollPhysics(),
              //     itemCount: oneCourseJson.length,
              //     itemBuilder: (BuildContext context, int index) {
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    elevation: 10,
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                          widget.icon.toString(),
                        ))),
                      ),
                      onTap: () {
                        setState(() {
                          launchURL(
                            widget.downlaod.toString(),
                          );
                        });

                        // setState(() {
                        //   Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => OneCourse(
                        //         name: OneCoursesJson[index]['Name'],
                        //         index: index.toString(),
                        //         url: OneCoursesJson[index]['Link']
                        //             .replaceAll('\/', '/'),
                        //       ),
                        //     ),
                        //   );
                        // });
                      },
                      title: Text(
                        widget.fileName.toString(),
                      ),
                      trailing: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_downward,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ),
                  ),
                ),

                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: GestureDetector(
                //     onTap: () {
                //       setState(() {
                //         // Navigator.push(
                //         //   context,
                //         //   MaterialPageRoute(
                //         //     builder: (context) => OneCourse(
                //         //       url: url,
                //         //     ),
                //         //   ),
                //         // );

                //         // // OneCourse
                //         // url = oneCourseJson[index]['Link']
                //         //     .replaceAll('\/', '/');
                //         // print(url);
                //         // // getOneCourse();
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
                //           Text(oneCourseJson[index]['weeknName']
                //               .toString()),

                //           ListView.builder(
                //               shrinkWrap: true,
                //               physics: ClampingScrollPhysics(),
                //               itemCount: oneCourseJson.length,
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
                //                   "https://lmsserver.skylineuniversity.ac.ae/my/images/OneCourse-img1.jpg"),
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
                //           //               'https://lmsserver.skylineuniversity.ac.ae/my/images/OneCourse-img1.jpg'))),
                //           // ),
                //           Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Center(
                //                 child: Text(
                //               oneCourseJson[index]['weeknName'],
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
                // }),
              ]),
        ),
      ),
    );
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
