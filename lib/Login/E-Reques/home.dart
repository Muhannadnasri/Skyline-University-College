import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/appBarLoginImage.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/rowSection.dart';
import 'package:skyline_university/Global/zigzag.dart';

void main() => runApp(HomeERequest());

class Item {
  final name;
  final clipType;

  Item(this.name, this.clipType);
}

class HomeERequest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeERequestState();
  }
}

class _HomeERequestState extends State<HomeERequest> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
        body: studentJson['data']['user_type'] == "STUDENT"
            ? Container(
                child: ListView(
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      children: <Widget>[
                        rowSection(
                            context,
                            'images/admission.png',
                            'images-white/admission.png',
                            'Online Request',
                            "/onlineRequest"),
                        rowSection(
                            context,
                            'images/admission.png',
                            'images-white/admission.png',
                            'Change Class Time',
                            "/ChangeClassTime"),
                        rowSection(
                            context,
                            'images/admission.png',
                            'images-white/admission.png',
                            'ReinStatement',
                            "/reinStatement"),
                        rowSection(
                            context,
                            'images/admission.png',
                            'images-white/admission.png',
                            'Course Withdrawal',
                            "/courseWithdrawal"),
                        rowSection(
                            context,
                            'images/admission.png',
                            'images-white/admission.png',
                            'Update Information',
                            "/UpdateInformation"),
                        rowSection(
                            context,
                            'images/admission.png',
                            'images-white/admission.png',
                            'Passport Withdrawal',
                            "/passportWithdrawal"),
                        rowSection(
                            context,
                            'images/admission.png',
                            'images-white/admission.png',
                            'General Appointment',
                            "/generalAppointment"),
                        rowSection(
                            context,
                            'images/admission.png',
                            'images-white/admission.png',
                            'Leave Application Form',
                            "/leaveApplicationForm"),
                      ],
                    ),
                  ],
                ),
              )
            : studentJson['data']['user_type'] == "STF"
                ? Container(
                    child: ListView(
                      children: <Widget>[
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: <Widget>[
                            rowSection(
                                context,
                                'images/admission.png',
                                'images-white/admission.png',
                                'Passport Retaining',
                                "/PassportRetaining"),
                            rowSection(
                                context,
                                'images/admission.png',
                                'images-white/admission.png',
                                'Salary Certificate',
                                "/SalaryCertificate"),
                            rowSection(
                                context,
                                'images/admission.png',
                                'images-white/admission.png',
                                'Leave Application',
                                "/LeaveApplication"),
                            rowSection(
                                context,
                                'images/admission.png',
                                'images-white/admission.png',
                                'Passport Withdrawal',
                                "/passportWithdrawal"),
                            rowSection(
                                context,
                                'images/admission.png',
                                'images-white/admission.png',
                                'Leave Holiday',
                                "/LeaveHoliday"),
                            rowSection(
                                context,
                                'images/admission.png',
                                'images-white/admission.png',
                                'Book Requisition',
                                "/BookRequisition"),
                            rowSection(
                                context,
                                'images/admission.png',
                                'images-white/admission.png',
                                'Membership Form',
                                "/MembershipForm"),
                            rowSection(
                                context,
                                'images/admission.png',
                                'images-white/admission.png',
                                'Leave Application Form',
                                "/leaveApplicationForm"),
// rowSection(context, 'images/admission.png', 'images-white/admission.png', 'AirTicket Request', "/AirTicketRequest"),
                          ],
                        )
                      ],
                    ),
                  )
                : studentJson['data']['user_type'] == "FAC"
                    ? Container(
                        child: ListView(
                          children: <Widget>[
                            SizedBox(
                              height: 10,
                            ),
                            Column(
                              children: <Widget>[
                                rowSection(
                                    context,
                                    'images/admission.png',
                                    'images-white/admission.png',
                                    'Passport Retaining',
                                    "/PassportRetaining"),
                                rowSection(
                                    context,
                                    'images/admission.png',
                                    'images-white/admission.png',
                                    'Salary Certificate',
                                    "/SalaryCertificate"),
                                rowSection(
                                    context,
                                    'images/admission.png',
                                    'images-white/admission.png',
                                    'Leave Application',
                                    "/LeaveApplication"),
                                rowSection(
                                    context,
                                    'images/admission.png',
                                    'images-white/admission.png',
                                    'Passport Withdrawal',
                                    "/passportWithdrawal"),
                                rowSection(
                                    context,
                                    'images/admission.png',
                                    'images-white/admission.png',
                                    'Leave Holiday',
                                    "/LeaveHoliday"),
                                rowSection(
                                    context,
                                    'images/admission.png',
                                    'images-white/admission.png',
                                    'Book Requisition',
                                    "/BookRequisition"),
                                rowSection(
                                    context,
                                    'images/admission.png',
                                    'images-white/admission.png',
                                    'Membership Form',
                                    "/MembershipForm"),
                                rowSection(
                                    context,
                                    'images/admission.png',
                                    'images-white/admission.png',
                                    'Leave Application Form',
                                    "/leaveApplicationForm"),
// rowSection(context, 'images/admission.png', 'images-white/admission.png', 'AirTicket Request', "/AirTicketRequest"),
                                rowSection(
                                    context,
                                    'images/admission.png',
                                    'images-white/admission.png',
                                    'Conference',
                                    "/Conference"),
                              ],
                            )
                          ],
                        ),
                      )
                    : SizedBox(),
        key: _scaffoldKey,
        appBar: appBarLoginImage(context));
  }
}
