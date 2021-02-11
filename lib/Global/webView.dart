import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:skyline_university/Global/appBar.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'global.dart';

class WebViews extends StatefulWidget {
  final String url;
  const WebViews({Key key, this.url}) : super(key: key);

  @override
  _WebViewsState createState() => _WebViewsState();
}

class _WebViewsState extends State<WebViews> with TickerProviderStateMixin {
  AnimationController _controller;
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();
  final Completer<WebViewController> _controllers =
      Completer<WebViewController>();

  num _stackToView = 1;

  final _key = UniqueKey();

  void _handleLoad(String value) {
    setState(() {
      _stackToView = 0;
    });
  }

  void initState() {
    super.initState();

    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: GradientAppBar(
          centerTitle: true,
          title: Container(
            height: 170,
            width: 170,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.scaleDown,
                image: AssetImage(
                  'images/skyline_white.png',
                ),
              ),
            ),
          ),
          gradient: isDark(context)
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF1F1F1F),
                    Color(0xFF1F1F1F),
                  ],
                  stops: [
                    0.7,
                    0.9,
                  ],
                )
              : LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF104C90),
                    Color(0xFF3773AC),
                  ],
                  stops: [
                    0.7,
                    0.9,
                  ],
                ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Color.fromARGB(255, 39, 93, 155),
        //   foregroundColor: Colors.white,
        //   child: new AnimatedBuilder(
        //     animation: _controller,
        //     builder: (BuildContext context, Widget child) {
        //       return GestureDetector(
        //         onTap: () => _shareImageFromUrl(),
        //         // setState(() {
        //         //   _shareImageFromUrl();
        //         // });

        //         child: new Icon(Icons.share),
        //       );
        //     },
        //   ),
        //   onPressed: () {
        //     setState(() {
        //       if (_controller.isDismissed) {
        //         _controller.forward();
        //       } else {
        //         _controller.reverse();
        //       }
        //     });
        //   },
        // ),
        body: IndexedStack(
          index: _stackToView,
          children: [
            Column(
              children: <Widget>[
                Expanded(
                  child: WebView(
                    key: _key,
                    initialUrl: widget.url,
                    onPageFinished: _handleLoad,
                  ),
                ),
              ],
            ),
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    child: Text('Please wait'),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  // Future<void> _shareImageFromUrl() async {
  //   showLoading(true, context);
  //   // var sharePdf = await file.readAsBytes();
  //   try {
  //     HttpClient client = new HttpClient();
  //     var request = await client.getUrl(Uri.parse(widget.url));
  //     var response = await request.close();
  //     Uint8List bytes = await consolidateHttpClientResponseBytes(response);
  //     await Share.file(
  //       'Share Document',
  //       'Document.pdf',
  //       bytes,
  //       '*/*',
  //     );
  //     showLoading(false, context);

  //     // Future.delayed(const Duration(seconds: 1), () {
  //     //   print('done');
  //     //   showLoading(false, context);
  //     // });
  //   } catch (e) {
  //     print(e);
  //     showLoading(false, context);
  //   }
  // }
}
