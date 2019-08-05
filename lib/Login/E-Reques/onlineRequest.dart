import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/zigzag.dart';
import 'package:skyline_university/Home/home.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
//TODO: Here Please Check all
void main() => runApp(OnlineRequest());

class OnlineRequest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _OnlineRequestState();
  }
}

final _address = GlobalKey<FormState>();
final _remark = GlobalKey<FormState>();

// Map<String, int> body;

class _OnlineRequestState extends State<OnlineRequest> {
  List onlineRequestTypeJson = [];
Map onlineRequestTypeMessageJson={};
Map onlineRequestJson={};
Map requestAmountJson = {};


  int groupValue;
  String item;

  @override
  void initState() {

    super.initState();

    getRequestType();

    requestAmountJson.clear();

  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
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
                    "Online Request",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                      logOut(context);},
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
                ],
              ),
            ),
            //TODO: Put all Icon Container
          ],
        ),
      ),
      body: Container(
        color: Colors.grey[300],
        child:Container(
          color: Colors.grey[300],
          child: ListView(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(new FocusNode());
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 25,
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Request Type',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        DropdownButton<String>(
                          style: TextStyle(
                              fontSize: 13, color: Colors.black),
                          isExpanded: true,

                          value: item,
                          hint: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Select Option',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),

                          items:onlineRequestTypeJson
                              ?.map(
                                (item) => DropdownMenuItem<String>(
                              value: item['DetailsID'].toString(),
                              child: Padding(
                                padding:
                                const EdgeInsets.all(8.0),
                                child: Text(item['Item'].toString()),

                              ),
                            ),
                          )
                              ?.toList() ??
                              [],
                          onChanged: (value) {

                            item = value;
                            print(onlineRequestTypeJson.toString());
                            getAmount();
                          },
                        ),
                      ],
                    ),

                    Card(
                      color: Colors.grey[300],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                height: 30,
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Normal Amount',
                                    style: TextStyle(
                                        color: Colors.grey[600]),
                                  ),
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Container(
                                        child: Text(

                                                  requestAmountJson.isEmpty
                                                    ?
                                                    ''
                                                    :
                                            requestAmountJson['data']['NormalAmount']
                                                ==
                                                ("NA")
                                                ?
                                            "Not Avalible"
                                                :
                                            requestAmountJson['data']['NormalAmount'].toString()
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: UnderlineTabIndicator(
                          borderSide: BorderSide(width: 0.4)),
                    ),
                    Card(
                      color: Colors.grey[300],
                      child: Row(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Container(
                                height: 30,
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Urgent Amount',
                                    style: TextStyle(
                                        color: Colors.grey[600]),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                            requestAmountJson.isEmpty
                                                ?
                                            ''
                                            :
                                      requestAmountJson['data']
                                      ['UrgentAmount'] ==
                                          ("NA")
                                          ? "Not Avalible"
                                          : requestAmountJson['data']
                                      ['UrgentAmount'].toString()
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: UnderlineTabIndicator(
                          borderSide: BorderSide(width: 0.4)),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Form(
                            key: _address,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    textCapitalization:
                                    TextCapitalization.words,
                                    maxLines: null,
                                    onSaved: (x) {
                                      address = x;
                                    },
                                    decoration: InputDecoration(
                                      labelText: "Address",
                                      fillColor: Colors.white,
                                      helperText: '(Optional)',
                                      helperStyle:
                                      TextStyle(fontSize: 13),
                                      hintText: 'Enter Your Adress',
                                      hintStyle: TextStyle(fontSize: 15),
                                      isDense: true,
                                      prefixIcon: Icon(
                                        FontAwesomeIcons.addressBook,
                                        size: 15,
                                        color: Colors.purple,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Form(
                            key: _remark,
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextFormField(
                                    textCapitalization:
                                    TextCapitalization.words,
                                    maxLines: null,
                                    onSaved: (x) {
                                      remark = x;
                                    },

                                    decoration: InputDecoration(
                                      labelText: "Remark",
                                      fillColor: Colors.white,
                                      hintText: 'Enter Your Questions',
                                      hintStyle: TextStyle(fontSize: 15),
                                      isDense: true,
                                      prefixIcon: Icon(
                                        FontAwesomeIcons.question,
                                        size: 15,
                                        color: Colors.purple,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.moneyCheck,
                                size: 20,
                                color: Colors.purple,
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text("Pay Amount"),
                            ],
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: <Widget>[
                                  Text('Normal'),
                                  Radio(
                                    value: 1,
                                    groupValue: groupValue,
                                    onChanged: (int e) {
                                      setState(() {
                                        groupValue = e;
                                      });
                                    },
                                    activeColor: Colors.blue,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: <Widget>[
                                  Text('Urgent'),
                                  Radio(
                                    value: 2,
                                    groupValue: groupValue,
                                    onChanged: (int e) {
                                      setState(() {
                                        groupValue = e;
                                      });
                                    },
                                    activeColor: Colors.red,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                        height: 35,
                        width: 80,
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
                        child: GestureDetector(
                            onTap: () {
                              getOnlineRequest();
                            },
                            child: Center(
                                child: Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.white),
                                )))),


                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

 

  Future getRequestType() async {

    Future.delayed(Duration.zero, () {
      showLoading(true,context);
    });



    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getOnlineRequestTypes'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': '15375',
          'program':'BSIT',
          'token':'1',
          'usertype':studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      );

      if (response.statusCode == 200) {
        setState(
              () {
            onlineRequestTypeJson = json.decode(response.body)['data'];
            onlineRequestTypeMessageJson = json.decode(response.body);
          },
        );

        showLoading(false,context);
      }
      if (onlineRequestTypeMessageJson['success'] == '0') {
showLoading(false,context);
        Fluttertoast.showToast(
            msg: onlineRequestTypeMessageJson['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey[400],
            textColor: Colors.black87,
            fontSize: 13.0
        );      }
    }


    catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false,context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,context,getRequestType);
      } else {
          showLoading(false,context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi,context,getRequestType);
      }
    }
  }

//TODO: Amount
  Future getAmount() async {
    Future.delayed(Duration.zero, () {
      showLoading(true,context);
    });
//    requestAmountJson.clear();

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getOnlineRequestAmount'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'req_type_id': item,
          'token': '1',
          'usertype':studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
              () {
            requestAmountJson = json.decode(response.body);
          },
        );
        showLoading(false,context);
      }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false,context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,context,getAmount);
      } else {
          showLoading(false,context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi,context,getAmount);
      }
    }
  }

//TODO: Final Request
  Future getOnlineRequest() async {
    if (_address.currentState.validate()) {
      _address.currentState.save();
    }
    if (_remark.currentState.validate()) {
      _remark.currentState.save();
    }
    Future.delayed(Duration.zero, () {
      showLoading(true,context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/onlineRequest'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'request_type': requestAmountJson['data']['MiscName'],
          'request_process': groupValue == 1 ? "Normal" : "Urgent",
          'address': address,
          'remarks': remark,
          'amount': groupValue == 1 ? "NormalAmount" : "UrgentAmount",
          'token': '1',
          'usertype':studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
              () {
            onlineRequestJson = json.decode(response.body);
          },
        );
        showLoading(false,context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false,context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,context,getOnlineRequest);
      } else {
          showLoading(false,context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi,context,getOnlineRequest);
      }
    }
  }


}
