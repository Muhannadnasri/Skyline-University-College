import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_calendar_carousel/classes/event.dart';
// import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:skyline_university/calendar/flutter_calendar_carousel.dart'
    show CalendarCarousel, WeekdayFormat;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/calendar/classes/event.dart';
import 'package:skyline_university/calendar/classes/event_list.dart';

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
      body: attendanceDetailsJson == null || attendanceDetailsJson.isEmpty
          ? exception(context)
          : ListView(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        elevation: 10,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Text(
                                      'Course Name : ' +
                                          '  ' +
                                          widget.className,
                                      style: TextStyle(
                                          color: isDark(context)
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(FontAwesomeIcons.solidCircle,
                                            size: 20,
                                            color: isDark(context)
                                                ? Colors.green
                                                : Colors.green),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Present',
                                          style: TextStyle(
                                              color: isDark(context)
                                                  ? Colors.white
                                                  : Colors.black),
                                        )
                                      ],
                                    ),
                                  ),
                                  Container(
                                    child: Row(
                                      children: <Widget>[
                                        Icon(FontAwesomeIcons.solidCircle,
                                            size: 20,
                                            color: isDark(context)
                                                ? Colors.red
                                                : Colors.red),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          'Absent',
                                          style: TextStyle(
                                              color: isDark(context)
                                                  ? Colors.white
                                                  : Colors.black),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        margin: EdgeInsets.only(left: 8, right: 8),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(32)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            child: CalendarCarousel<Event>(
                              onDayPressed:
                                  (DateTime date, List<Event> events) {
                                setState(() {
                                  _selectedEvents = events;
                                });
                              },
                              childAspectRatio: 1.5,
                              showOnlyCurrentMonthDate: true,
                              iconColor:
                                  isDark(context) ? Colors.white : Colors.black,
                              headerTextStyle: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 20),
                              // thisMonthDayBorderColor: Colors.grey,
                              // selectedDayButtonColor: Color(0xFF30A9B2),
                              // selectedDayBorderColor: Color(0xFF30A9B2),

                              todayButtonColor: isDark(context)
                                  ? Color(0xFFC4D8EA)
                                  : Colors.blueGrey,
                              todayTextStyle: TextStyle(
                                  color: isDark(context)
                                      ? Colors.black
                                      : Colors.white),
                              todayBorderColor: isDark(context)
                                  ? Color(0xFFC4D8EA)
                                  : Colors.white,

                              weekendTextStyle: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black),
                              daysTextStyle: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black),
                              nextDaysTextStyle: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black),
                              prevDaysTextStyle: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black),
                              weekdayTextStyle: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black),
                              weekDayFormat: WeekdayFormat.short,
                              firstDayOfWeek: 01,
                              showHeader: true,
                              isScrollable: true,

                              height: 350.0,
                              // height: MediaQuery.of(context).size.height / 2,

                              headerTitleTouchable: false,
                              daysHaveCircularBorder: true,
                              customGridViewPhysics:
                                  NeverScrollableScrollPhysics(),
                              markedDatesMap: days,
                              markedDateWidget: Container(
                                height: 3,
                                width: 3,
                                decoration: new BoxDecoration(
                                  // color: Colors.blue,
                                  shape: BoxShape.rectangle,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      _buildEventList(_selectedEvents)
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildEventList(events) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (BuildContext context, int index) => Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  width: 1.5,
                  color: isDark(context) ? Colors.white : Colors.black12),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 4.0),
          child: ListTile(
            title: Text(
              events[index].title,
              style: TextStyle(
                  fontSize: 14,
                  color: isDark(context) ? Colors.white : Colors.black),
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
                var now = new DateTime.now();
                var formatter = new DateFormat('yyyy-MM-dd');
                String formatted = formatter.format(events[index].date);
                showAttendance(
                  context,
                  'Date' + " : " + ' ' + formatted.toString(),
                  events[index].title,
                  events[index].title == "ABSENT" ? Colors.red : Colors.green,
                );
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
            "https://skylineportal.com/moappad/api/test/StudentAttendanceDetails"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'student_id': username,
          'class_section_id': widget.classSectionID,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          attendanceDetailsJson = json.decode(response.body)['data'];

          if (attendanceDetailsJson != null) {
            attendanceDetailsJson.forEach((event) {
              days.add(
                  DateFormat("dd/MM/yyyy").parse(event["Attendance Taken On"]),
                  Event(
                      date: DateFormat("dd/MM/yyyy")
                          .parse(event["Attendance Taken On"]),
                      title: event["Attendance"],
                      icon: Icon(Icons.ac_unit)));
            });
          }
        });

        showLoading(false, context);
      }
    } catch (x) {
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
