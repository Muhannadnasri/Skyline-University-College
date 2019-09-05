import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:url_launcher/url_launcher.dart';

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
      appBar: appBarLogin(context, 'Contact List'),
      body: ListView.builder(
          itemCount: contactListJson.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 140,
                child: Card(
                  elevation: 20,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
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
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),

                                Container(
                                  child: Text(
                                    contactListJson[index]['Job_Name']
                                        .toString(),
                                    style: TextStyle(color: Colors.black),
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
          'usertype': studentJson['data']['user_type'],
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


      showLoading(false, context);
    } catch (x) {
      
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
