import 'dart:convert';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, WeekdayFormat;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(AttendanceCalendar());

class AttendanceCalendar extends StatefulWidget {
  final String classSectionID;
  final String className;
  final int index;

  const AttendanceCalendar({
    Key key,
    this.classSectionID,
    this.className,
    this.index,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _AttendanceCalendarState();
  }
}

// Map<String, int> body;

class _AttendanceCalendarState extends State<AttendanceCalendar> {
  List attendanceDetailsJson = [];
  EventList<Event> days = new EventList(events: {});
  List _selectedEvents = [];

  Map attendanceDetailsJsonMessage = {};
  @override
  void initState() {
    super.initState();
    getStudentAttendanceDetails();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    return Scaffold(
        appBar: appBarLogin(context, 'Attendance Calendar'),
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  elevation: 10,
                  child: DottedBorder(
                    color: Colors.blue,
                    gap: 3,
                    strokeWidth: 1,
                    child: Column(
                      children: <Widget>[
                        Container(
                          height: 30,
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
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
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  studentJson['data']['name'],
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      "Roll NO:",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    Text(
                                      username,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              Text('Course Name : '),
                              Text(widget.className)
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: DottedBorder(
                  color: Colors.black,
                  gap: 2,
                  child: Container(
                    color: Colors.white,
                    child: CalendarCarousel<Event>(
                      onDayPressed: (DateTime date, List<Event> events) {
                        setState(() {
                          _selectedEvents = events;
                        });
                      },
                      showOnlyCurrentMonthDate: true,
                      thisMonthDayBorderColor: Colors.transparent,
                      selectedDayButtonColor: Color(0xFF30A9B2),
                      selectedDayBorderColor: Color(0xFF30A9B2),
                      todayButtonColor: Colors.redAccent,
                      todayTextStyle: TextStyle(color: Colors.white),
                      todayBorderColor: Colors.white,
                      selectedDayTextStyle: TextStyle(color: Colors.black),
                      weekendTextStyle: TextStyle(color: Colors.black),
                      daysTextStyle: TextStyle(color: Colors.black),
                      nextDaysTextStyle: TextStyle(color: Colors.black),
                      prevDaysTextStyle: TextStyle(color: Colors.black),
                      weekdayTextStyle: TextStyle(color: Colors.black),
                      weekDayFormat: WeekdayFormat.short,
                      firstDayOfWeek: 01,
                      showHeader: true,
                      isScrollable: true,
                      weekFormat: false,
                      height: 380.0,
                      headerTitleTouchable: false,
                      daysHaveCircularBorder: true,
                      customGridViewPhysics: NeverScrollableScrollPhysics(),
                      markedDatesMap: days,
                      markedDateWidget: Container(
                        height: 3,
                        width: 3,
                        decoration: new BoxDecoration(
                          color: Colors.blue,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(8.0)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              _buildEventList(_selectedEvents)
            ],
          ),
        ));
  }

  Widget _buildEventList(events) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.5, color: Colors.black12),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
          child: ListTile(
            title: Text(
              events[index].title,
              style: TextStyle(fontSize: 14),
            ),
            trailing: Icon(
              events[index].title == "ABSENT"
                  ? FontAwesomeIcons.timesCircle
                  : FontAwesomeIcons.checkCircle,
              color:
                  events[index].title == "ABSENT" ? Colors.red : Colors.green,
              size: 18,
            ),
            onTap: () {
              setState(() {
                showAttendance(
                    context, 'Date' + ' ' + events[index].date.toString());
              });
            },
          ),
        ),
        itemCount: events.length,
      ),
    );
  }

  Future getStudentAttendanceDetails() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });
    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/getStudentAttendanceDetails"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'student_id': username,
          'class_section_id': widget.classSectionID,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          attendanceDetailsJson = json.decode(response.body)['data'];
          attendanceDetailsJsonMessage = json.decode(response.body);

          attendanceDetailsJson.forEach((event) {
            days.add(
                DateFormat("dd/MM/yyyy").parse(event["Attendance Taken On"]),
                Event(
                    date: DateFormat("dd/MM/yyyy")
                        .parse(event["Attendance Taken On"]),
                    title: event["Attendance"],
                    icon: Icon(Icons.ac_unit)));
          });
        });

        print(widget.classSectionID);
        print(attendanceDetailsJson);

        showLoading(false, context);
      }
      if (attendanceDetailsJsonMessage['success'] == '0') {
        showLoading(false, context);
        Fluttertoast.showToast(
            msg: attendanceDetailsJsonMessage['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey[400],
            textColor: Colors.black87,
            fontSize: 13.0);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getStudentAttendanceDetails);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getStudentAttendanceDetails);
      }
    }
  }
}
