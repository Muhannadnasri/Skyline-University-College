import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/appBar.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Home/Info/virtualDetails.dart';

void main() => runApp(VirtualSupportList());

class VirtualSupportList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VirtualSupportListState();
  }
}

class _VirtualSupportListState extends State<VirtualSupportList> {
  bool isLoading = true;

  List virtualListJson = [];

  @override
  void initState() {
    super.initState();
    getDepartment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: appBar(context, 'Virtual Support'),
      body: Container(
        child: ListView.builder(
            itemCount: virtualListJson.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  FittedBox(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => VirtualDetails(
                                  departmentID: virtualListJson[index]
                                          ['DEPARTMENT_ID']
                                      .toString(),
                                  title: virtualListJson[index]
                                          ['DEPARTMENT_NAME']
                                      .toString(),
                                ),
                              ),
                            );

                            // Navigator.pushNamed(context, location);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, top: 8, right: 8.0),
                            child: Container(
                              width: 380,
                              height: 50,
                              decoration: BoxDecoration(
                                color: isDark(context)
                                    ? Color(0xFF1F1F1F)
                                    : Colors.grey[100],
                                border: Border.all(
                                  width: 1.0,
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black,
                                ),
                                borderRadius: BorderRadius.all(Radius.circular(
                                        10.0) //         <--- border radius here
                                    ),
                              ),
                              child: Container(
                                width: 80,
                                height: 80,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Image.asset(
                                      isDark(context)
                                          ? 'images-white/admission.png'
                                          : 'images/admission.png',
                                      height: 30,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Text(
                                        virtualListJson[index]
                                            ['DEPARTMENT_NAME'],
                                        style: TextStyle(
                                            color: isDark(context)
                                                ? Colors.white
                                                : Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              );
            }),
      ),
    );
  }

  Future getDepartment() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/test/GetDepartment"),
        headers: {
          "API-KEY": API,
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          virtualListJson = json.decode(response.body)['data'];
          isLoading = false;
        });
        showLoading(false, context);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getDepartment);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getDepartment);
      }
    }
  }
}
