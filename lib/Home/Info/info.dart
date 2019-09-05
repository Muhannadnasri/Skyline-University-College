import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/rowSection.dart';

void main() => runApp(Info());

class Info extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _InfoState();
  }
}

class _InfoState extends State<Info> {
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
              rowSection(context, 'images/admission.png', 'SUC at the glance',
                  '/glance'),
              rowSection(context, 'images/admission.png',
                  'Vision, Mission, Goals & Objectives', '/goals'),
              rowSection(context, 'images/admission.png', 'Board of Governors',
                  '/board'),
              rowSection(context, 'images/admission.png', 'Founder President',
                  '/founder'),
              rowSection(context, 'images/admission.png', 'Executive Council',
                  '/council'),
              rowSection(context, 'images/admission.png', 'Dean', '/dean'),
              rowSection(
                  context, 'images/admission.png', 'Committees', '/committees'),

//  rowSection(
//                   context, 'images/admission.png', 'Committees', '/Calendars'),






                  
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
