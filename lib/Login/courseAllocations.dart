import 'package:flutter/material.dart';
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(CourseAllocations());

class CourseAllocations extends StatefulWidget {
  final List data;

  const CourseAllocations({Key key, this.data}) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _CourseAllocationsState();
  }
}

// Map<String, int> body;

class _CourseAllocationsState extends State<CourseAllocations> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarLogin(context, 'Class Morning'),
        body:
            // widget.data == null || widget.data.isEmpty
            //     ? exception(context, isLoading)
            //     :
            Container(
          child: ListView.builder(
            itemCount: widget.data.length,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                elevation: 10,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 30,
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
                      child: Row(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            widget.data[index]['WeekDays'],
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ]),
                    ),
                    _rowWidget(widget.data[index]['Session1'], 'Session 1 : '),
                    _rowWidget(widget.data[index]['Session2'], 'Session 2 : '),
                    _rowWidget(widget.data[index]['Session3'], 'Session 3 : '),
                    _rowWidget(widget.data[index]['Session4'], 'Session 4 : '),
                    _rowWidget(widget.data[index]['Session5'], 'Session 5 : '),
                    _rowWidget(widget.data[index]['Session6'], 'Session 6 : '),
                    _rowWidget(widget.data[index]['Session7'], 'Session 7 : '),
                    _rowWidget(widget.data[index]['Session8'], 'Session 8 : '),
                    _rowWidget(widget.data[index]['Session9'], 'Session 9 : '),
                  ],
                ),
              );
            },
          ),
        ));
  }

  Widget _rowWidget(data, text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                '$text',
                style: TextStyle(
                    color: isDark(context) ? Colors.white : Colors.black),
              ),
              Expanded(
                child: Text(
                  data.toString() == "null" ? "" : data.toString(),
                  style: TextStyle(
                      color: isDark(context) ? Colors.white : Colors.black),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }
}
