import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/global.dart';

import 'dropList.dart';

void main() => runApp(GeneralAppointment());

class GeneralAppointment extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GeneralAppointmentState();
  }
}

// Map<String, int> body;

class _GeneralAppointmentState extends State<GeneralAppointment> {
  int miscID = 0;
  var caseNameCnt = TextEditingController();
  var departmentNameCnt = TextEditingController();
  var timeNameCnt = TextEditingController();
  var dateNameCnt = TextEditingController();
  var caseIDCnt = TextEditingController();
  var dateCnt = TextEditingController();
  final _generalAppointmentForm = GlobalKey<FormState>();

  String empId = '';
  String departmentID = '';
  List generalApptDate = [];
  String remark = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      bottomNavigationBar:
          //  generalAPPtJson.isEmpty
          //     ? Container()
          //     :
          bottomappBar(
        context,
        () {
          if (_generalAppointmentForm.currentState.validate() &&
              departmentNameCnt.text != '' &&
              caseNameCnt.text != '' &&
              timeNameCnt.text != '' &&
              dateNameCnt.text != '') {
            _generalAppointmentForm.currentState.save();
            setState(() {
              sendGeneralAppointment();
            });
          }
        },
      ),
      appBar: appBarLogin(context, 'General Appointment'),
      body:
          //  generalAPPtJson.isEmpty
          //     ? Container()
          //     :
          GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  requestCaseWidget(),
                  requestDepartmentWidget(),
                  requestDateWidget(),
                  requestTimeWidget(),
                  remarkAndAddressWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget requestCaseWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Case Category',
          style:
              TextStyle(color: isDark(context) ? Colors.white : Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DropList(
                  type: 'GeneralAppointmentCategory',
                ),
              ),
            ).then((val) async {
              setState(() {
                // miscName = val['MiscName'];
                // miscID = val['MiscID'];
                caseNameCnt.text = val['CATEGORY_DESCRIPTION'];
                caseIDCnt.text = val['CATEGORY_ID'].toString();
                departmentNameCnt.clear();
                departmentID = '';
                timeNameCnt.clear();
                dateCnt.clear();
                dateNameCnt.clear();
              });
            });
          },
          child: AbsorbPointer(
            child: TextFormField(
              validator: (x) => x.isEmpty ? "Please select request type" : null,
              onChanged: (x) {
                setState(() {
                  // isEditing = true;
                });
              },
              controller: caseNameCnt,
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Widget requestDepartmentWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Department',
          style:
              TextStyle(color: isDark(context) ? Colors.white : Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DropList(
                  type: 'GeneralAppointmentDepartment',
                ),
              ),
            ).then((val) async {
              setState(() {
                // miscName = val['MiscName'];
                // miscID = val['MiscID'];
                empId = val['EmpNumber'];
                departmentID = val['Department'];
                departmentNameCnt.text = val['Department'];

                timeNameCnt.clear();
                dateCnt.clear();
                dateNameCnt.clear();
              });
            });
          },
          child: AbsorbPointer(
            child: TextFormField(
              validator: (x) => x.isEmpty ? "Please select request type" : null,
              onChanged: (x) {
                setState(() {
                  // isEditing = true;
                });
              },
              controller: departmentNameCnt,
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Widget requestTimeWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Appointment Time',
          style:
              TextStyle(color: isDark(context) ? Colors.white : Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DropList(
                  type: 'GeneralAppointmentTime',
                ),
              ),
            ).then((val) async {
              setState(() {
                // miscName = val['MiscName'];
                // miscID = val['MiscID'];
                timeNameCnt.text = val['timevalue'];
              });
            });
          },
          child: AbsorbPointer(
            child: TextFormField(
              validator: (x) => x.isEmpty ? "Please select request type" : null,
              onChanged: (x) {
                setState(() {
                  // isEditing = true;
                });
              },
              controller: timeNameCnt,
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Widget requestDateWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Appointment Date',
          style:
              TextStyle(color: isDark(context) ? Colors.white : Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DropList(
                  type: 'GeneralAppointmentDate',
                  departmentID: departmentID,
                  empId: empId,
                ),
              ),
            ).then((val) async {
              setState(() {
                dateCnt.text = val['date'];
                dateNameCnt.text = val['Dates'];
                timeNameCnt.clear();
              });
            });
          },
          child: AbsorbPointer(
            child: TextFormField(
              validator: (x) => x.isEmpty ? "Please select request type" : null,
              onChanged: (x) {
                setState(() {
                  // isEditing = true;
                });
              },
              controller: dateNameCnt,
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Widget remarkAndAddressWidget() {
    return Form(
      key: _generalAppointmentForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Remarks',
            style:
                TextStyle(color: isDark(context) ? Colors.white : Colors.black),
          ),
          TextFormField(
            validator: (x) => x.isEmpty ? "Please enter remark" : null,
            onChanged: (x) {
              setState(() {
                // isEditing = true;
              });
            },
            // initialValue: widget.sessionId == null
            //     ? ''
            //     : widget.sessionInfo['remarks'],
            onSaved: (x) {
              setState(() {
                remark = x;
              });
              // sessionRemarks = x;
            },
            keyboardType: TextInputType.text,
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  // Future getGeneralApptDate() async {
  //   Future.delayed(Duration.zero, () {
  //     showLoading(true, context);
  //   });

  //   try {
  //     final response = await http.post(
  //       Uri.encodeFull(
  //           'https://skylineportal.com/moappad/api/test/GeneralApptDate'),
  //       headers: {
  //         "API-KEY": API,
  //       },
  //       body: {
  //         'user_id': username,
  //         'emp_no': _empId,
  //         'department': _departmentID,
  //       },
  //     ).timeout(Duration(seconds: 35));

  //     if (response.statusCode == 200) {
  //       setState(
  //         () {
  //           generalApptDate = json.decode(response.body)['data'];
  //         },
  //       );

  //       showLoading(false, context);
  //     }
  //   } catch (x) {
  //     if (x.toString().contains("TimeoutException")) {
  //       showLoading(false, context);

  //       showError("Time out from server", FontAwesomeIcons.hourglassHalf,
  //           context, getGeneralApptDate);
  //     } else {
  //       showLoading(false, context);
  //       showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
  //           getGeneralApptDate);
  //     }
  //   }
  // }

  Future sendGeneralAppointment() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/generalAppointments'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'Stud_ID': username,
          'CASETYPE_ID': '4',
          'CATEGORY_ID': caseIDCnt.toString(),
          'EmpNumber': empId.toString(),
          'Department_ID': departmentID.toString(),
          'AppointMentDate': dateCnt.toString(),
          'AppointmentTime': timeNameCnt.toString(),
          'StudentRemarks': remark,
        },
      );
      if (response.statusCode == 200) {
        // setState(
        //   () {
        //     generalRequestJson = json.decode(response.body);
        //   },
        // );
        if (response.statusCode == 200) {
          showLoading(false, context);

          vottomSheetSuccess(context);
        } else {
          showLoading(false, context);

          bottomSheetFailure(context);
        }
        // if (generalRequestJson['success'] == '0') {
        //   showfailureSnackBar(context, generalRequestJson['message']);
        // }
        // if (generalRequestJson['success'] == '1') {
        //   showSuccessSnackBar(context, generalRequestJson['message']);
        // }
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, sendGeneralAppointment);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            sendGeneralAppointment);
      }
    }
  }
}
