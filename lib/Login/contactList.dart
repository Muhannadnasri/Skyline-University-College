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

class _ContactListState extends State<ContactList> {
  var seachCnt = TextEditingController();
  String selectedName = "";

  List itemsJson = [];
  List itemsToShow = [];
  @override
  void initState() {
    getContactList();
    selectedName = "";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarLogin(context, 'Contact List'),
      body: itemsJson == null || itemsJson.isEmpty
          ? Container()
          : CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  automaticallyImplyLeading: false,
                  expandedHeight: 50.0,
                  snap: true,
                  floating: true,
                  pinned: false,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                        ),
                        child: TextField(
                          controller: seachCnt,
                          decoration: InputDecoration(hintText: 'Search'),
                          onChanged: (x) {
                            selectedName = x;
                            searchItems();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return buildItems(index);
                    },
                    childCount: itemsToShow.length,
                  ),
                ),
              ],
            ),
    );
  }

  buildItems(index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                              decoration: BoxDecoration(shape: BoxShape.circle),
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
                              itemsToShow[index]['Name'].toString(),
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            child: Text(
                                itemsToShow[index]['Job_Name'].toString(),
                                style: TextStyle(
                                    color: isDark(context)
                                        ? Colors.white
                                        : Colors.black)),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                            onTap: () {
                              launch(
                                  'msteams://teams.microsoft.com/l/chat/0/0?users=' +
                                      itemsToShow[index]['OfficeMail']
                                          .toString());
                            },
                            child: Container(
                              child: Icon(Icons.send),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                              onTap: () {
                                launch('mailto:' +
                                    itemsToShow[index]['OfficeMail']
                                        .toString());
                              },
                              child: Text(
                                itemsToShow[index]['OfficeMail'].toString(),
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
                                  itemsToShow[index]['Email'].toString());
                            },
                            child: Text(
                              itemsToShow[index]['Email'].toString(),
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          GestureDetector(
                              onTap: () {
                                launch(itemsToShow[index]['Mobile']
                                            .toString()
                                            .startsWith('9', 0)
                                        ? 'tel:00' +
                                            itemsToShow[index]['Mobile']
                                                .toString()
                                        : 'tel:' +
                                            itemsToShow[index]['Mobile']
                                                .toString()
                                    //
                                    );
                              },
                              child: Text(
//

                                itemsToShow[index]['Mobile']
                                        .toString()
                                        .startsWith('9', 0)
                                    ? '00' +
                                        itemsToShow[index]['Mobile'].toString()
                                    : '' +
                                        itemsToShow[index]['Mobile'].toString(),

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
      ),
    );
  }

  void searchItems() {
    setState(() {
      itemsToShow = itemsJson.where((i) {
        if (selectedName != "" &&
            !i['Name'].toString().contains(selectedName) &&
            !i['Job_Name'].toString().contains(selectedName)) {
          return false;
        } else {
          return true;
        }
        // if(archive==0){}
      }).toList();
    });
  }

  Future getContactList() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      http.Response response = await http.post(
        Uri.parse(
            "https://skylineportal.com/moappad/api/test/StaffContactsList"),
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
          itemsJson = json.decode(response.body)['data'];
          itemsToShow = itemsJson;
          selectedName = '';
          seachCnt.text = '';
          // contactListJson = json.decode(response.body)['data'];
        });
        showLoading(false, context);
      }
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
