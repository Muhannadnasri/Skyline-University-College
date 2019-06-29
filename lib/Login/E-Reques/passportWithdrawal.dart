import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cupertino_date_picker/flutter_cupertino_date_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/zigzag.dart';
import 'package:skyline_university/Home/home.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

void main() => runApp(PassportWithdrawal());

class PassportWithdrawal extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PassportWithdrawalState();
  }
}

final _localName = GlobalKey<FormState>();
final _localNumber = GlobalKey<FormState>();
final _internationalName = GlobalKey<FormState>();
final _internationalNumber = GlobalKey<FormState>();
final _reasonPassport = GlobalKey<FormState>();


Map<String, int> body;

class _PassportWithdrawalState extends State<PassportWithdrawal> {
  int groupValue;
  String ID;
  String _dateTimeReturnPassport = '';
  int _year = 2018;
  int _month = 11;
  int _date = 11;


  @override
  void initState() {
super.initState();
    DateTime now = DateTime.now();
    _year = now.year;
    _month = now.month;
    _date = now.day;
    getPassportWithdrawal();
  }
  void _showDateReturnPassport() {
    DateTime now = DateTime.now();

    DatePicker.showDatePicker(
      context,
      minYear: now.year,
      initialYear: now.year,
      initialMonth: now.month,
      initialDate: _date,
      confirm: Text(
        'Confirm',
        style: TextStyle(color: Colors.red),
      ),
      cancel: Text(
        'Cancel',
        style: TextStyle(color: Colors.cyan),
      ),
      locale: 'EN',
      dateFormat: 'dd-mm-yyyy',
      onConfirm: (year, month, date) {
        _changeDateReturnPassport(year, month, date);
      },
    );
  }
  void _changeDateReturnPassport(int year, int month, int date) {
    setState(() {
      _year = year;
      _month = month;
      _date = date;
      _dateTimeReturnPassport = '$year-$month-$date';
    });
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: true,//todo: On all Form
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(70.0),
        child:


        Stack(

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
                    onTap: (){
                      Navigator.pop(context);

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(

                        children: <Widget>[

                          Icon(Icons.arrow_back_ios,size: 15,color: Colors.white,),
                          SizedBox(width: 5,),
                          Text('Back',style: TextStyle(fontSize: 15,color: Colors.white),),
                        ],
                      ),
                    ),
                  ),
                  Text("Passport Withdrawal",style: TextStyle(color: Colors.white),),

                  GestureDetector(
                    onTap: () {
                     logOut(context);},

                     child: GestureDetector(
                      onTap: (){
                        logOut(context);

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: <Widget>[

                            Icon(FontAwesomeIcons.powerOff,color: Colors.red,size: 15,),
                            SizedBox(width: 5,),
                            Text('Logout',style: TextStyle(fontSize: 15,color: Colors.red),),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],),
            ),
            //TODO: Put all Icon Container
          ],
        ),
      ),      body: Container(

        child: ListView(
          children: <Widget>[
            GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
              },
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(children: <Widget>[

                        SizedBox(
                          height: 5,
                        ),
                        Form(
                          key: _localName,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(

                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    localName = x;
                                  },
                                    decoration:

                                    InputDecoration(
                                      labelText: "Contact Local Person",
                                      fillColor: Colors.white,

                                      helperStyle: TextStyle(fontSize: 13),
                                      hintText: 'Please Enter Local Name',hintStyle: TextStyle(fontSize: 15),
                                      isDense: true,
                                      prefixIcon: Icon(FontAwesomeIcons.user,size: 15,color: Colors.purple,),
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],),
                      Column(children: <Widget>[

                        SizedBox(
                          height: 5,
                        ),
                        Form(
                          key: _localNumber,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(

                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    localNumber = x;
                                  },
                                    decoration:

                                    InputDecoration(
                                      labelText: "Contact Local Number",
                                      fillColor: Colors.white,

                                      helperStyle: TextStyle(fontSize: 13),
                                      hintText: 'Please Enter Local Number',hintStyle: TextStyle(fontSize: 15),
                                      isDense: true,
                                      prefixIcon: Icon(FontAwesomeIcons.mobileAlt,size: 15,color: Colors.purple,),
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],),
                      Column(children: <Widget>[


                        SizedBox(
                          height: 5,
                        ),
                        Form(
                          key: _internationalName,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(

                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    internationalName = x;
                                  },
                                    decoration:

                                    InputDecoration(
                                      labelText: "Contact International Person",
                                      fillColor: Colors.white,

                                      helperStyle: TextStyle(fontSize: 13),
                                      hintText: 'Please Enter Your International Name',hintStyle: TextStyle(fontSize: 15),
                                      isDense: true,
                                      prefixIcon: Icon(FontAwesomeIcons.user,size: 15,color: Colors.purple,),
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],),
                      Column(children: <Widget>[

                        SizedBox(
                          height: 5,
                        ),
                        Form(
                          key: _internationalNumber,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(

                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    internationalNumber = x;
                                  },
                                    decoration:

                                    InputDecoration(
                                      labelText: "Contact International Number",
                                      fillColor: Colors.white,

                                      helperStyle: TextStyle(fontSize: 13),
                                      hintText: 'Please Enter International Number',hintStyle: TextStyle(fontSize: 15),
                                      isDense: true,
                                      prefixIcon: Icon(FontAwesomeIcons.mobileAlt,size: 15,color: Colors.purple,),
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],),


                      SizedBox(
                        height: 15,
                      ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  height: 40,
                                  width: MediaQuery.of(context).size.width,
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
                                  ),                                child: Align(
                                      alignment: Alignment.centerLeft,
                                        child: GestureDetector(
                                          onTap: (){

                                            _showDateReturnPassport();

                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            children: <Widget>[
                                              SizedBox(width: 15,),

                                              Padding(
                                                    padding: const EdgeInsets.only(right:10.0),
                                                    child: Icon(FontAwesomeIcons.calendarAlt,color: Colors.white,),
                                                  ),
SizedBox(width: 10,),
                                              Padding(
                                                padding: const EdgeInsets.only (left:10.0),
                                                child: Text( 
                                                  
                                                  
                                                  
                                                  _dateTimeReturnPassport == null ? 'Date To Return': 'Date To Return' ,style: TextStyle(color:Colors.white),),
                                              ),
                                            ],
                                          ),
                                        ),

                              ),
                              ),
                            ),


                        SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: _reasonPassport,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(

                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    reasonPassport = x;
                                  },
                                    decoration:

                                    InputDecoration(
                                      labelText: "Remark",
                                      fillColor: Colors.white,

                                      helperStyle: TextStyle(fontSize: 13),
                                      hintText: 'Please Enter Your Reason',hintStyle: TextStyle(fontSize: 15),
                                      isDense: true,
                                      prefixIcon: Icon(FontAwesomeIcons.bookmark,size: 15,color: Colors.purple,),
                                    )
                                ),
                              ),
                            ],
                          ),
                        ),
SizedBox(height: 20,),

                    ],
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
                            getPassportWithdrawal();
                          },
                          child: Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              ))))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showLoading(isLoading) {
    if (isLoading) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () {},
              child: new AlertDialog(
                title: Image.asset('images/logo.png',
                  height: 50,
                ),
                shape: SuperellipseShape(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                content: Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: new CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: new Text('Please Wait....'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    } else {
      Navigator.pop(context);
    }
  }

  void _showError(String msg,IconData icon) {
    _showLoading(false);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {},
            child: new AlertDialog(
              title: Image.asset('images/logo.png',
                height: 50,
              ),
              shape: SuperellipseShape(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: new Icon(icon),
                    ),
                    new Text(msg)
                  ],
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    getPassportWithdrawal();
                  },
                  child: new Text('Try again'),
                ),
              ],
            ),
          );
        });
  }

  Future getPassportWithdrawal() async {
    if (_localName.currentState.validate()) {
      _localName.currentState.save();
    }
    if (_localNumber.currentState.validate()) {
      _localNumber.currentState.save();
    }
    if (_internationalName.currentState.validate()) {
      _internationalName.currentState.save();
    }
    if (_internationalNumber.currentState.validate()) {
      _internationalNumber.currentState.save();
    }
    if (_reasonPassport.currentState.validate()) {
      _reasonPassport.currentState.save();
    }
    Future.delayed(Duration.zero, () {
      _showLoading(true);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/passportRetaining'),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
        },
        body: {
          'user_id': username,
          'local_person': localName,
          'local_contact': localNumber,
          'intl_person': internationalName,
          'intl_contact': internationalNumber,
          'return_date': _dateTimeReturnPassport,
          'reason': reasonPassport,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            passportWithdrawalJson = json.decode(response.body);
          },
        );
        _showLoading(false);
      }
      if ( passportWithdrawalJson['success'] == '0'){
        _showLoading(false);
        Fluttertoast.showToast(
            msg: passportWithdrawalJson['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey[400],
            textColor: Colors.black87,
            fontSize: 13.0
        );
      }
    } catch (x) {
      if(x.toString().contains("TimeoutException")){
        _showError("Time out from server",FontAwesomeIcons.hourglassHalf);
      }else{
        _showError("Sorry, we can't connect",Icons.perm_scan_wifi);
      }

    }
  }
}
