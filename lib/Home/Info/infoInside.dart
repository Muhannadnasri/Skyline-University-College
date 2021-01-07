import 'package:flutter/material.dart';
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(Infoinside());

class Infoinside extends StatefulWidget {
  final String infoName;
  final String infoImage;

  final List infoContents;

  final String infoContent;

  const Infoinside(
      {Key key,
      this.infoName,
      this.infoImage,
      this.infoContent,
      this.infoContents})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InfoinsideState();
  }
}

class _InfoinsideState extends State<Infoinside> {
  @override
  void initState() {
    super.initState();

    // infoJson = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: appBar(context, widget.infoName.toString()),
      body: ListView(children: <Widget>[
        Container(
          child: Image.network(
            widget.infoImage,
            fit: BoxFit.contain,
          ),
        ),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.infoName.toString(),
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark(context) ? Colors.white : Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 5),
                child: Container(
                  width: 100,
                  decoration: UnderlineTabIndicator(
                      borderSide: BorderSide(
                          width: 3,
                          color: isDark(context) ? Colors.white : Colors.black,
                          style: BorderStyle.solid)),
                ),
              ),
              SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
        widget.infoContents == null
            ? Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  widget.infoContent.toString() == 'null'
                      ? ''
                      : widget.infoContent.toString(),
                  style: TextStyle(
                      color: isDark(context) ? Colors.white : Colors.black),
                ),
              )
            : ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: widget.infoContents.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      widget.infoContents.toString() == 'null'
                          ? ''
                          : widget.infoContents[index].toString(),
                      style: TextStyle(
                          color: isDark(context) ? Colors.white : Colors.black),
                    ),
                  );
                })
      ]),

      // htmlSecation(
      //     context,
      //     widget.jsonInfo[index]['image'],
      //     widget.jsonInfo[index]['name'],
      //     widget.jsonInfo[index]['content']);
    );
  }
}
