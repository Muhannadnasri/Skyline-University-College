import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:skyline_university/Global/appBar.dart';

void main() => runApp(Virtual());

class Virtual extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VirtualState();
  }
}

class _VirtualState extends State<Virtual> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: appBar(context, 'Virtual Tour'),
      body: Container(
        child: WebviewScaffold(
            scrollBar: false,
            supportMultipleWindows: false,
            url: 'https://my.matterport.com/show/?m=dQdKnrhL2YS'),
      ),
    );
  }
}
