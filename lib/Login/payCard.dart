import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(PayCard());

class PayCard extends StatefulWidget {
  final String reamount;
  final String amount;
  final String studentId;
  final String requestId;

  const PayCard(
      {Key key, this.reamount, this.amount, this.studentId, this.requestId})
      : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _PayCardState();
  }
}

// Map<String, int> body;

class _PayCardState extends State<PayCard> {
  FlutterWebviewPlugin flutterWebviewPlugin = FlutterWebviewPlugin();

  double lineProgress = 0.0;
  bool isLoading = true;

  void initState() {
    super.initState();

    flutterWebviewPlugin.onProgressChanged.listen((progress) {
      print(progress);
      setState(() {
        lineProgress = progress;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      withZoom: true,
      clearCookies: true,
      clearCache: true,

      useWideViewPort: true,
      displayZoomControls: true,
      withOverviewMode: true,

      enableAppScheme: true,
      supportMultipleWindows: false,

      appBar: GradientAppBar(
        bottom: PreferredSize(
          child: _progressBar(lineProgress, context),
          preferredSize: Size.fromHeight(3.0),
        ),
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

      // AppBar(
      //   backgroundColor: Colors.green,
      //   title: Text(widget.title),
      //   bottom: PreferredSize(
      //     child: _progressBar(lineProgress, context),
      //     preferredSize: Size.fromHeight(3.0),
      //   ),
      // ),
      url:
          "https://lmsserver.skylineuniversity.ac.ae/blocks/portal/mobile_pay_form.php?reamount${widget.reamount}&amount=${widget.amount}&student_id=${widget.studentId}&request_id=${widget.requestId}&feetype=tutionfees&username=$username&password=$password",
    );

    // WebView(initialUrl: ,)
    // Container(
    //   child: WebviewScaffold(
    //       withZoom: true,
    //       withJavascript: true,
    //       clearCache: true,
    //       clearCookies: true,
    //       scrollBar: true,
    //       url: payCardJson.toString()),
    // ),
  }

  @override
  void dispose() {
    flutterWebviewPlugin.dispose();
    super.dispose();
  }
}

_progressBar(double progress, BuildContext context) {
  return LinearProgressIndicator(
    backgroundColor: Colors.white70.withOpacity(0),
    value: progress == 1.0 ? 0 : progress,
    valueColor: new AlwaysStoppedAnimation<Color>(Colors.red),
  );
}
