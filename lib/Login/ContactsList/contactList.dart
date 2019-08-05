import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/zigzag.dart';
import 'package:skyline_university/Home/home.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

void main() => runApp(ContactList());

class ContactList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ContactListState();
  }
}

// Map<String, int> body;

class _ContactListState extends State<ContactList> {
  List contactListJson = [];

  @override
  void initState() {
    getContactList();
    super.initState();
    contactListJson = [];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 70,
                  decoration: new BoxDecoration(
                    gradient: LinearGradient(
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
                ),
              ],
            ),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.arrow_back_ios,
                            size: 15,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Back',
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Text(
                    "Contact List",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      logOut(context);
                    },
                    child: GestureDetector(
                      onTap: () {
                        logOut(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.powerOff,
                              color: Colors.red,
                              size: 15,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Logout',
                              style: TextStyle(fontSize: 15, color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //TODO: Put all Icon Container
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: contactListJson.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 140,
                child: Card(
                  color: contactListJson[index]['DEPARTMENT_NAME'] == 'BSIT'
                      ? Color(0xFF612B79)
                      : Color(0xFF023962),
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    decoration:
                                        BoxDecoration(shape: BoxShape.circle),
                                    child: Container(
                                      width: 40.0,
                                      height: 40.0,
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.blue),
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        image: DecorationImage(
                                          fit: BoxFit.fitHeight,
                                          image: AssetImage(
                                            'images/logosmall.png',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  //TODO: Image Profile
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  child: Text(
                                    contactListJson[index]['Name'].toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),

                                Container(
                                  child: Text(
                                    contactListJson[index]['Job_Name']
                                        .toString(),
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),

                                GestureDetector(
                                    onTap: () {
                                      launch('mailto:' +
                                          contactListJson[index]['OfficeMail']
                                              .toString());
                                    },
                                    child: Text(
                                      contactListJson[index]['OfficeMail']
                                          .toString(),
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.blue),
                                    )),
                                SizedBox(
                                  height: 5,
                                ),

                                GestureDetector(
                                  onTap: () {
                                    launch('mailto:' +
                                        contactListJson[index]['Email']
                                            .toString());
                                  },
                                  child: Text(
                                    contactListJson[index]['Email'].toString(),
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        color: Colors.blue),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
//                'tel:00'
                                GestureDetector(
                                    onTap: () {
                                      launch(contactListJson[index]['Mobile']
                                                  .toString()
                                                  .startsWith('9', 0)
                                              ? 'tel:00' +
                                                  contactListJson[index]
                                                          ['Mobile']
                                                      .toString()
                                              : 'tel:' +
                                                  contactListJson[index]
                                                          ['Mobile']
                                                      .toString()
                                          //
                                          );
                                    },
                                    child: Text(
//

                                      contactListJson[index]['Mobile']
                                              .toString()
                                              .startsWith('9', 0)
                                          ? '00' +
                                              contactListJson[index]['Mobile']
                                                  .toString()
                                          : '' +
                                              contactListJson[index]['Mobile']
                                                  .toString(),

                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Colors.blue),
////
                                    )),
                                SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
  }

  Future getContactList() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/getStaffContactsList"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'usertype':studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1'
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          contactListJson = json.decode(response.body)['data'];
        });
      }
      print(contactListJson.toString());

      showLoading(false, context);
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getContactList);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getContactList);
      }
    }
  }
}
