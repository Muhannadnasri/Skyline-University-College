import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

// https://www.youtube.com/embed/uDAjHLXrTU0?controls=0
// import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:skyline_university/Global/appBar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() => runApp(GraduateProgram());

class GraduateProgram extends StatefulWidget {
  final String programName;
  final String programLink;

  final String programIntroduction;

  final String programImage;

  const GraduateProgram(
      {Key key,
      this.programName,
      this.programIntroduction,
      this.programImage,
      this.programLink})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _GraduateProgramState();
  }
}

class _GraduateProgramState extends State<GraduateProgram> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: appBar(context, 'Program'),
        body: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  child: widget.programImage.toString() ==
                          'https://skylineuniversity.ac.ae'
                      ? YoutubePlayer(
                          context: context,
                          videoId: "uDAjHLXrTU0",
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

                      //  FlutterYoutube.playYoutubeVideoByUrl(
                      //     apiKey: "<API_KEY>",
                      //     videoUrl:
                      //         'https://www.youtube.com/watch?v=uDAjHLXrTU0',
                      //     autoPlay: true, //default falase
                      //     fullScreen: false //default false
                      //     )
                      // ? YoutubePlayer(
                      //     autoPlay: true,
                      //     hideShareButton: true,
                      //     quality: YoutubeQuality.HD,
                      //     context: context,
                      //     source: _source,
                      //     showThumbnail: true,
                      //     callbackController: (controller) {

                      //       _videoController = controller;
                      //     },
                      //     onError: (error) {
                      //       print(error);
                      //     },
                      //     onVideoEnded: () => _showThankYouDialog(),
                      //   )
                      : Image.network(widget.programImage),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      launch(widget.programLink.toString());
                    },
                    child: Text(
                      widget.programName.replaceAll('&amp;', ''),
                      style:
                          TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text(
                    'INTRODUCTION',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
                Html(
                  data: widget.programIntroduction
                      .replaceAll('&nbsp;', '')
                      .replaceAll('INTRODUCTION', ''),
                  defaultTextStyle: TextStyle(fontSize: 15),
                  padding: const EdgeInsets.all(10.0),
                  useRichText: false,
                ),
              ],
            ),
          ],
        ));
  }
}
