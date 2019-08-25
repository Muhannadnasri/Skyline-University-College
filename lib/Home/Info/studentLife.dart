import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/rowSection.dart';

void main() => runApp(StudentLife());

class StudentLife extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StudentLifeState();
  }
}

class _StudentLifeState extends State<StudentLife> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: appBar(context, 'Skyline Info'),
      body: Container(
        child: ListView(children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              rowSection(context, 'images/admission.png', 'International Students',
                  '/internationalStudents'),
              rowSection(context, 'images/admission.png',
                  'Know More About Skyline', '/knowMoreAboutSkyline'),
              rowSection(context, 'images/admission.png', 'Student Services Department',
                  '/studentServicesDepartment'),
              rowSection(context, 'images/admission.png', 'Academic Advising & Mentoring ',
                  '/academicAdvisingAndMentoring'),
              rowSection(context, 'images/admission.png', 'Clubs',
                  '/clubs'),
              rowSection(context, 'images/admission.png', 'Student Event Committees', '/studentEventCommittees'),
              rowSection(
                  context, 'images/admission.png', 'Sports Department', '/sportsDepartment'),
            ],
          ),
        ]),
      ),
    );
  }

  // Future getPrograms() async {
  //   Future.delayed(Duration.zero, () {
  //     showLoading(true, context);
  //   });
  //   try {
  //     http.Response response = await http.post(
  //       Uri.encodeFull("https://skylineportal.com/moappad/api/web/getPageInfo"),
  //       headers: {
  //         "API-KEY": API,
  //       },
  //       body: {
  //         'usertype': '1',
  //         'name': 'SUC Info',
  //         'ipaddress': '1',
  //         'deviceid': '1',
  //         'devicename': '1',
  //       },
  //     ).timeout(Duration(seconds: 35));

  //     if (response.statusCode == 200) {
  //       setState(() {
  //         infoJson = json.decode(response.body)['data'];
  //       });
  //       print(infoJson.toString());
  //       showLoading(false, context);
  //     }
  //   } catch (x) {
  //     print(x);
  //     if (x.toString().contains("TimeoutException")) {
  //       showLoading(false, context);

  //       showError("Time out from server", FontAwesomeIcons.hourglassHalf,
  //           context, getPrograms);
  //     } else {
  //       showLoading(false, context);
  //       showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
  //           getPrograms);
  //     }
  //   }
  // }
}
