import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(Advisors());

class Advisors extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdvisorsState();
  }
}

// Map<String, int> body;

class _AdvisorsState extends State<Advisors> {
  // List myAdvisorsJson = [];
  var seachCnt = TextEditingController();
  String selectedName = "";

  List itemsJson = [];
  List itemsToShow = [];
  @override
  void initState() {
    super.initState();
    getAdvisors();
    selectedName = "";
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: appBarLogin(context, 'Advisors Students'),
      body:
          // itemsToShow == null || itemsToShow.isEmpty
          //     ? exception(context, FontAwesomeIcons.exclamationTriangle,
          //         'No course available')
          //     :
          CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            expandedHeight: 50.0,
            snap: true,
            floating: true,
            pinned: false,
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
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        elevation: 10,
        child: Column(
          children: <Widget>[
            Container(
              height: 40,
              decoration: new BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                gradient: isDark(context)
                    ? LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color(0xFF1F1F1F),
                          Color(0xFF1F1F1F),
                        ],
                        stops: [
                          0.7,
                          0.9,
                        ],
                      )
                    : LinearGradient(
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
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        itemsToShow[index]['Name'],
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            _rowWidget('Roll No', itemsToShow[index]['RollNo']),
            _rowWidget('AdvisorName', itemsToShow[index]['AdvisorName']),
            _rowWidget('GPA', itemsToShow[index]['Gpa'].toString()),
            _rowWidget('Level', itemsToShow[index]['S_Level']),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Text('Mobile No : ',
                      style: TextStyle(
                          color:
                              isDark(context) ? Colors.white : Colors.black)),
                  GestureDetector(
                      onTap: () {
                        launch('tel:00' +
                            itemsToShow[index]['MobileNo'].toString());
                      },
                      child: Text(
//

                        itemsToShow[index]['MobileNo']
                                .toString()
                                .startsWith('9', 0)
                            ? '00' + itemsToShow[index]['MobileNo'].toString()
                            : '' + itemsToShow[index]['MobileNo'].toString(),

                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: <Widget>[
                  Text('Mail No : ',
                      style: TextStyle(
                          color:
                              isDark(context) ? Colors.white : Colors.black)),
                  GestureDetector(
                      onTap: () {
                        launch('mailto:' +
                            itemsToShow[index]['MailId'].toString());
                      },
                      child: Text(
                        itemsToShow[index]['MailId'],
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue),
                      )),
                ],
              ),
            ),
            SizedBox(
              height: 5,
            ),
            _rowWidget(
                'With TOC',
                itemsToShow[index]['With TOC'] == null
                    ? 'No'
                    : itemsToShow[index]['With TOC']),
            _rowWidget(
                'With Sap : ',
                itemsToShow[index]['WithSap'] == ''
                    ? 'No'
                    : itemsToShow[index]['WithSap']),
            _rowWidget(
                'Shift Time',
                itemsToShow[index]['shift'] == 'E'
                    ? 'Evening'
                    : itemsToShow[index]['shift'] == 'M'
                        ? 'Morning'
                        : itemsToShow[index]['shift'] == 'W' ? 'Weekend' : ''),
            _rowWidget('Repeating Course',
                itemsToShow[index]['Repeating Course'] == '' ? 'No' : 'Yes'),
            _rowWidget(
              'CondAdm',
              itemsToShow[index]['CondAdm'] == null
                  ? ''
                  : itemsToShow[index]['CondAdm'],
            ),
          ],
        ),
      ),
    );
  }

  void searchItems() {
    setState(() {
      itemsToShow = itemsJson.where((i) {
        if (selectedName != "" &&
            !i['RollNo'].toString().contains(selectedName) &&
            !i['Name'].toString().contains(selectedName) &&
            !i['Gpa'].toString().contains(selectedName) &&
            !i['With TOC'].toString().contains(selectedName)) {
          return false;
        } else {
          return true;
        }
        // if(archive==0){}
      }).toList();
    });
  }

  Widget _rowWidget(String text, data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Text('$text : ',
                  style: TextStyle(
                      color: isDark(context) ? Colors.white : Colors.black)),
              Expanded(
                child: Text(data.toString(),
                    style: TextStyle(
                        color: isDark(context) ? Colors.white : Colors.black)),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
        ],
      ),
    );
  }

  Future getAdvisors() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull('https://skylineportal.com/moappad/api/test/MyAdvisees'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'advisory_id': studentJson['data']['user_id'],
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            itemsJson = json.decode(response.body)['data'];
            itemsToShow = itemsJson;
            selectedName = '';
            seachCnt.text = '';

            // myAdvisorsJson = json.decode(response.body)['data'];
          },
        );

        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getAdvisors);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getAdvisors);
      }
    }
  }
}
