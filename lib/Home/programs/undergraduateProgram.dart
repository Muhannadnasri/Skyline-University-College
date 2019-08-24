import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/global.dart';
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
            return Column(
              children: <Widget>[
                programITJson[index]['name'] == 'BS IT Video'
                    ? Container(
                        child: YoutubePlayer(
                          videoId: programITJson[index]['content'],
                          context: context,
                        ),
                        // YoutubePlayer(
                        //   context: context,
                        //   source: programITJson[index]['content'],
                        //   autoPlay: true,
                        //   quality: YoutubeQuality.HD,

                        //   onVideoEnded: () => _showThankYouDialog(),
                        //   onError: (error) {
                        //     print(error);
                        //   },
                        // ),
                      )
                    : programITJson[index]['content_type'] == 'url'
                        ? Container(
                          
                            child: Image.network(
                              programITJson[index]['content'],
                              fit: BoxFit.contain,
                            ),
                          )
                        : SizedBox(),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      programITJson[index]['content_type'] == 'url'
                          ? SizedBox()
                          : Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                programITJson[index]['name'],
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 5),
                        child: programITJson[index]['content_type'] == 'url'
                            ? SizedBox()
                            : Container(
                                width: 100,
                                decoration: UnderlineTabIndicator(
                                    borderSide: BorderSide(
                                        width: 3,
                                        color: Colors.blue,
                                        style: BorderStyle.solid)),
                              ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: programITJson[index]['content_type'] == 'url'
                            ? SizedBox()
                            : Html(data: programITJson[index]['content']),
                      )
                    ],
                  ),
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
