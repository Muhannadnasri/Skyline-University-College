import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() => runApp(UndergraduateProgram());

class UndergraduateProgram extends StatefulWidget {
  final String programName;
  final String programId;

  final String programdescription;

  const UndergraduateProgram({
    Key key,
    this.programName,
    this.programId,
    this.programdescription,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _UndergraduateProgramState();
  }
}

class _UndergraduateProgramState extends State<UndergraduateProgram> {
  List programITJson = [];

  @override
  void initState() {
    getprogramIT();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: appBar(context, 'Program'),
        body: ListView.builder(
          itemCount: programITJson.length,
          itemBuilder: (BuildContext context, int index) {
            // String videoId;
            // videoId = YoutubePlayer.convertUrlToId(
            //     "https://www.youtube.com/watch?v=BBAyRBTfsOU");
            return Column(
              children: <Widget>[
                Container(
                    child: programITJson[index]['name'] == "Youtube"
                        ? YoutubePlayer(
                            context: context,
                            videoId: programITJson[index]['content'].toString(),
                            flags: YoutubePlayerFlags(
                              autoPlay: true,
                              showVideoProgressIndicator: true,
                              hideControls: true,
                              hideFullScreenButton: true,
                            ),
                            videoProgressIndicatorColor: Colors.amber,
                            progressColors: ProgressColors(
                              playedColor: Colors.amber,
                              handleColor: Colors.amberAccent,
                            ),
                          )
                        : SizedBox()),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      launch(programITJson[index][''].toString());
                    },
                    child: Text(
                      programITJson[index]['name'] == "GENERAL EDUCATION" ||
                              programITJson[index]['name'] ==
                                  'ENTERPRISE COMPUTING' ||
                              programITJson[index]['name'] == 'OBJECTIVES' ||
                              programITJson[index]['name'] == 'INTRODUCTION'
                          ? programITJson[index]['name']
                          : '',
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Html(
                  data: programITJson[index]['name'] == "GENERAL EDUCATION" ||
                          programITJson[index]['name'] ==
                              'ENTERPRISE COMPUTING' ||
                          programITJson[index]['name'] == 'OBJECTIVES' ||
                          programITJson[index]['name'] == 'INTRODUCTION'
                      ? programITJson[index]['content']
                      : '',
                  defaultTextStyle: TextStyle(fontSize: 15),
                  padding: const EdgeInsets.all(10.0),
                  useRichText: false,
                ),
              ],
            );
          },
        ));
  }

  void _showThankYouDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Video Ended"),
          content: Text("Thank you for trying the plugin!"),
        );
      },
    );
  }

  Future getprogramIT() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/getProgramTabs"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'usertype': '1',
          'program_id': widget.programId.toString(),
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          programITJson = json.decode(response.body)['data'];
        });
        print(programITJson.toString());
        showLoading(false, context);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getprogramIT);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getprogramIT);
      }
    }
  }
}
