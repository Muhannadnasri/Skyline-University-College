import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(OneNews());

class OneNews extends StatefulWidget {
  final String oneNewsTitle;
  final String oneNewsContent;
  final String oneNewsImage;
  final String oneNewsDate;

  const OneNews(
      {Key key,
      this.oneNewsTitle,
      this.oneNewsContent,
      this.oneNewsImage,
      this.oneNewsDate})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OneNewsState();
  }
}

class _OneNewsState extends State<OneNews> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: appBar(context, 'New'),
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Hero(
                  tag: widget.oneNewsImage,
                  child: Container(
                    child: Image.network(
                      widget.oneNewsImage,
                      filterQuality: FilterQuality.medium,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          widget.oneNewsTitle,
                          style: TextStyle(
                              color: isDark(context)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 5),
                        child: Container(
                          width: 100,
                          decoration: UnderlineTabIndicator(
                              borderSide: BorderSide(
                                  width: 3,
                                  color: isDark(context)?Colors.white:Colors.black,
                                  style: BorderStyle.solid)),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          widget.oneNewsDate,
                          style: TextStyle(
                              color: isDark(context)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(
                          widget.oneNewsContent,
                          style: TextStyle(
                              color: isDark(context)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
