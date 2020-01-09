import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skyline_university/Global/appBar.dart';

import 'global.dart';

class ListsContent extends StatefulWidget {
  final String contentTitle;
  final String contentContent;
  final String contentImage;
  final String contentDate;

  const ListsContent(
      {Key key,
      this.contentTitle,
      this.contentContent,
      this.contentImage,
      this.contentDate})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ListsContentState();
  }
}

class _ListsContentState extends State<ListsContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: appBar(context, 'New'),
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Hero(
                  tag: widget.contentImage,
                  child: Container(
                    child: Image.network(
                      widget.contentImage,
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
                          widget.contentTitle,
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
                          widget.contentDate,
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
                          widget.contentContent,
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
