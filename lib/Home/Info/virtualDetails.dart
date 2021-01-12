import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

void main() => runApp(VirtualDetails());

class VirtualDetails extends StatefulWidget {
  final String departmentID;
  final String title;
  const VirtualDetails({Key key, this.departmentID, this.title})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VirtualDetailsState();
  }
}

class _VirtualDetailsState extends State<VirtualDetails> {
  bool isLoading = true;
  List employeeDetailsJson = [];

  @override
  void initState() {
    super.initState();
    getEmployeeDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      appBar: appBar(context, widget.title),
      body: Container(
        child: ListView.builder(
            itemCount: employeeDetailsJson.length,
            itemBuilder: (BuildContext context, int index) {
              return ClipPath(
                clipper: ShapeBorderClipper(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                    side: new BorderSide(
                        color: isDark(context) ? Colors.white : Colors.black,
                        width: 0.5),
                  ),
                  margin: const EdgeInsets.all(10),
                  elevation: 5,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(10),
                    title: Text(employeeDetailsJson[index]['EmpName']),
                    leading: Image.asset('images/logosmall.png'),
                    subtitle: Text(employeeDetailsJson[index]['Job_Title']),
                    trailing: GestureDetector(
                      onTap: () {
                        launch(
                            'msteams://teams.microsoft.com/l/chat/0/0?users=' +
                                employeeDetailsJson[index]['OfficeMail']);
                      },
                      child: Icon(
                        Icons.send,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Future getEmployeeDetails() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/test/GetEmployeeDetails"),
        headers: {
          "API-KEY": API,
        },
        body: {"DepartmentID": widget.departmentID},
      );

      if (response.statusCode == 200) {
        setState(() {
          employeeDetailsJson = json.decode(response.body)['data'];
          isLoading = false;
        });
        showLoading(false, context);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getEmployeeDetails);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getEmployeeDetails);
      }
    }
  }
}
