import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skyline_university/Global/appBar.dart';

void main() => runApp(OneEvents());

class OneEvents extends StatefulWidget {
  final String oneEventsTitle;
  final String oneEventsContent;
  final String oneEventsImage;
  final String oneEventsDate;

  const OneEvents(
      {Key key,
      this.oneEventsTitle,
      this.oneEventsContent,
      this.oneEventsImage,
      this.oneEventsDate})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OneEventsState();
  }
}

class _OneEventsState extends State<OneEvents> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: appBar(context, 'Event'),
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Hero(
                  tag: widget.oneEventsImage,
                  child: Container(
                    child: Image.network(
                      widget.oneEventsImage,
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
                        child: Text(widget.oneEventsTitle),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 5),
                        child: Container(
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
                        padding: const EdgeInsets.all(15.0),
                        child: Text(widget.oneEventsDate),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text(widget.oneEventsContent),
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
