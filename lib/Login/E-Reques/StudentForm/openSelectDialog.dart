import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/global.dart';
// import 'package:weight_tracker/model/WeightSave.dart';

class OpenSelectDialog extends StatefulWidget {
  final List requestType;

  const OpenSelectDialog({Key key, this.requestType}) : super(key: key);
  @override
  OpenSelectDialogState createState() => new OpenSelectDialogState();
}

class OpenSelectDialogState extends State<OpenSelectDialog> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: appBarLogin(context, "Select One Request"),
        body: ListView.builder(
            itemCount: widget.requestType.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                margin: EdgeInsets.only(bottom: 5, left: 5, top: 0, right: 5),
                child: ListTile(
                  contentPadding: EdgeInsets.all(6),
                  title: Text(widget.requestType[index]['MiscName']),
                  onTap: () {
                    setState(() {
                      Navigator.pop(context, widget.requestType[index]);
                    });
                  },
                ),
              );
            }));
  }
}
