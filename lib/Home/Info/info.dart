import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/global.dart';

import 'infoInside.dart';

void main() => runApp(Info());

class Info extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InfoState();
  }
}

Map info = {};

class _InfoState extends State<Info> {
  @override
  void initState() {
    super.initState();
    getInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBar(context, 'Skyline Info'),
      body: Container(
        child: ListView.builder(
            itemCount: info.keys.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: <Widget>[
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Infoinside(
                                  infoName:
                                      info[info.keys.toList()[index].toString()]
                                          ['name'],
                                  infoImage:
                                      info[info.keys.toList()[index].toString()]
                                          ['image'],
                                  infoContents:
                                      info[info.keys.toList()[index].toString()]
                                          ['contents'],
                                  infoContent:
                                      info[info.keys.toList()[index].toString()]
                                          ['content'],
                                ),
                              ),
                            );

                            // Navigator.pushNamed(context, location);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, top: 8, right: 8.0),
                            child: Container(
                              width: 380,
                              height: 50,
                              decoration: BoxDecoration(
                                color: isDark(context)
                                    ? Color(0xFF1F1F1F)
                                    : Colors.grey[100],
                                border: Border.all(
                                  width: 1.0,
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        10.0) //         <--- border radius here
                                    ),
                              ),
                              child: Container(
                                width: 80,
                                height: 80,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Image.asset(
                                      isDark(context)
                                          ? 'images/admission.png'
                                          : 'images-white/admission.png',
                                      height: 30,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      info.keys.toList()[index].toString()
                                      // info[info.keys.toList()[index].toString()]['name']
                                      ,
                                      style: TextStyle(
                                          color: isDark(context)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            }

//           children: <Widget>[
//           Column(
//             children: <Widget>[
//               SizedBox(
//                 height: 15,
//               ),

//               rowSection(context, 'images/admission.png', 'images-white/admission.png', 'SUC at the glance',
//                   '/glance'),
//               rowSection(context, 'images/admission.png', 'images-white/admission.png',
//                   'Vision, Mission, Goals & Objectives', '/goals'),
//               rowSection(context, 'images/admission.png', 'images-white/admission.png', 'Board of Governors',
//                   '/board'),
//               rowSection(context, 'images/admission.png', 'images-white/admission.png', 'Founder Chairman',
//                   '/founder'),
//               rowSection(context, 'images/admission.png', 'images-white/admission.png', 'Executive Council',
//                   '/council'),
//               rowSection(context, 'images/admission.png', 'images-white/admission.png', 'Vice Chancellor', '/dean'),
//               rowSection(

//                   context, 'images/admission.png', 'images-white/admission.png', 'External Advisory Council', '/council'),

//   rowSection(
//                   context, 'images/admission.png', 'images-white/admission.png', 'Corporate Social Responsibility', '/corporate'),  rowSection(
//                   context, 'images/admission.png', 'images-white/admission.png', 'Academic Affairs Council', '/academic'),
// //  rowSection(
// //                   context, 'images/admission.png', 'images-white/admission.png', 'Committees', '/Calendars'),
//             ],
            //   ),
            // ]
            ),
      ),
    );
  }

  Future getInfo() async {
    Future.delayed(Duration.zero, () {
      info = {};
      showLoading(true, context);
    });
    try {
      http.Response response = await http
          .post(
            Uri.parse("http://www.muhannadnasri.com/App/about/data.json"),
          )
          .timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          info = json.decode(response.body);
        });
        showLoading(false, context);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getInfo);
      } else {
        showLoading(false, context);
        showError(
            "Sorry, we can't connect", Icons.perm_scan_wifi, context, getInfo);
      }
    }
  }
}
