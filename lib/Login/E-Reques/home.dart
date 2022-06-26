import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skyline_university/Global/appBarLoginImage.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/rowSection.dart';

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
                        //TODO:Backup
                        rowSection(
                            context,
                            'images/orequest.png',
                            'images-white/orequest.png',
                            'Online Request',
                            "/onlineRequest"),
//
                        // rowSection(
                        //     context,
                        //     'images/orequest.png',
                        //     'images-white/orequest.png',
                        //     'Online Request',
                        //     "/homeOnlineRequest"),

                        // rowSection(
                        //     context,
                        //     'images/orequest.png',
                        //     'images-white/orequest.png',
                        //     'Passport Withdrawal',
                        //     "/passportWithdrawal"),
                        rowSection(
                            context,
                            'images/orequest.png',
                            'images-white/orequest.png',
                            'Letter Request',
                            "/letterRequest"),
                        rowSection(
                            context,
                            'images/orequest.png',
                            'images-white/orequest.png',
                            'Student Pass Request',
                            "/studentPassRequest"),
                        // rowSection(
                        //     context,
                        //     'images/orequest.png',
                        //     'images-white/orequest.png',
                        //     'Semester Registration',
                        //     "/semesterRegistration"),
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
                                'images/orequest.png',
                                'images-white/orequest.png',
                                'Passport Retaining',
                                "/passportRetaining"),
                            rowSection(
                                context,
                                'images/orequest.png',
                                'images-white/orequest.png',
                                'Salary Certificate',
                                "/salaryCertificate"),
                            rowSection(
                                context,
                                'images/orequest.png',
                                'images-white/orequest.png',
                                'Leave Application',
                                "/leaveApplication"),
                            rowSection(
                                context,
                                'images/orequest.png',
                                'images-white/orequest.png',
                                'Passport Withdrawal',
                                "/passportWithdrawal"),
                            rowSection(
                                context,
                                'images/orequest.png',
                                'images-white/orequest.png',
                                'Leave Holiday',
                                "/leaveHoliday"),
                            rowSection(
                                context,
                                'images/orequest.png',
                                'images-white/orequest.png',
                                'Book Requisition',
                                "/bookRequisition"),
                            // rowSection(
                            //     context,
                            //     'images/orequest.png',
                            //     'images-white/orequest.png',
                            //     'Membership Form',
                            //     "/membershipForm"),

// rowSection(context, 'images/orequest.png', 'images-white/orequest.png', 'AirTicket Request', "/AirTicketRequest"),
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
                                    'images/orequest.png',
                                    'images-white/orequest.png',
                                    'Passport Retaining',
                                    "/passportRetaining"),
                                rowSection(
                                    context,
                                    'images/orequest.png',
                                    'images-white/orequest.png',
                                    'Salary Certificate',
                                    "/salaryCertificate"),
                                rowSection(
                                    context,
                                    'images/orequest.png',
                                    'images-white/orequest.png',
                                    'Leave Application',
                                    "/leaveApplication"),
                                rowSection(
                                    context,
                                    'images/orequest.png',
                                    'images-white/orequest.png',
                                    'Passport Withdrawal',
                                    "/passportWithdrawal"),
                                rowSection(
                                    context,
                                    'images/orequest.png',
                                    'images-white/orequest.png',
                                    'Leave Holiday',
                                    "/leaveHoliday"),
                                rowSection(
                                    context,
                                    'images/orequest.png',
                                    'images-white/orequest.png',
                                    'Book Requisition',
                                    "/bookRequisition"),
                                // rowSection(
                                //     context,
                                //     'images/orequest.png',
                                //     'images-white/orequest.png',
                                //     'Membership Form',
                                //     "/membershipForm"),

// rowSection(context, 'images/orequest.png', 'images-white/orequest.png', 'AirTicket Request', "/AirTicketRequest"),
                                rowSection(
                                    context,
                                    'images/orequest.png',
                                    'images-white/orequest.png',
                                    'Conference',
                                    "/conference"),
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
