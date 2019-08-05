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

void main() => runApp(UpdateInformation());

class UpdateInformation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _UpdateInformationState();
  }
}

final _information = GlobalKey<FormState>();
final _remark = GlobalKey<FormState>();

// Map<String, int> body;

class _UpdateInformationState extends State<UpdateInformation> {
  Map studentInfoJson={};


  int dependentValue;
  int hostelValue;
  int visaValue;
  int workingValue;

  @override
  void initState() {
super.initState();
    getStudentInfo();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
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
                  Text("Update Personal Information",style: TextStyle(color: Colors.white),),

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
      ),     
      
       body: studentInfoJson == null
          ? SizedBox()
          : ListView(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(new FocusNode());
                  },
                  child: Container(
                    color: Colors.grey[300],
                    child: Column(
                      children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(left:15.0,),
                     child: Column(
                       children: <Widget>[
                       Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           Text('Visa Student'),

                           Row(
                             children: <Widget>[
                               Text('Yes'),
                               Radio(
                                 value: 1,
                                 groupValue: visaValue,
                                 onChanged: (int e) {
                                   setState(() {
                                     visaValue = e;
                                   });
                                 },
                                 activeColor: Colors.purple,
                               ),
                               Text('No'),
                               Radio(
                                 value: 2,
                                 groupValue: visaValue,
                                 onChanged: (int e) {
                                   setState(() {
                                     visaValue = e;
                                     
                                   });
                                 },
                                 activeColor: Colors.purple,
                               ),
                             ],
                           ),

                         ],
                       ), //TODO : Visa
                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           Text('Dependent'),

                           Row(
                             children: <Widget>[
                               Text('Yes'),
                               Radio(
                                 value: 1,
                                 groupValue: dependentValue,
                                 onChanged: (int e) {
                                   setState(() {
                                     dependentValue = e;
                                   });
                                 },
                                 activeColor: Colors.purple,
                               ),
                               Text('No'),
                               Radio(
                                 value: 2,
                                 groupValue: dependentValue,
                                 onChanged: (int e) {
                                   setState(() {
                                     dependentValue = e;
                                   });
                                 },
                                 activeColor: Colors.purple,
                               ),
                             ],
                           ),
                         ],
                       ), //TODO : Dependent
                       Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: <Widget>[
                           Text('Staying in Hostel'),

                           Row(
                             children: <Widget>[
                               Text('Yes'),
                               Radio(
                                 value: 1,
                                 groupValue: hostelValue,
                                 onChanged: (int e) {
                                   setState(() {
                                     hostelValue = e;
                                   });
                                 },
                                 activeColor: Colors.purple,
                               ),
                               Text('No'),
                               Radio(
                                 value: 2,
                                 groupValue: hostelValue,
                                 onChanged: (int e) {
                                   setState(() {
                                     hostelValue = e;
                                   });
                                 },
                                 activeColor: Colors.purple,
                               ),
                             ],
                           ),
                         ],
                       ),

                     ],),
                   ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 450,
                          height: 30,
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
                          child: Center(child: Text('Student Details',style: TextStyle(color:Colors.white),)),


                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Form(
                          key: _information,
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom: 10),
                                child: Row(children: <Widget>[
                                  Text(
                                    'Email ID',
                                    style: TextStyle(color: Colors.grey[500]),
                                  )
                                ]),
                              ),
                              Container(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5),
                                  child: TextFormField(
                                    initialValue: studentInfoJson['data']
                                    ['Email'] ==
                                            null
                                        ? ''
                                        : studentInfoJson['data']
                                                    ['Email'] ==
                                                ''
                                            ? ''
                                            : studentInfoJson['data']
                                                ['Email'],

                                    textCapitalization:
                                        TextCapitalization.words,
                                    maxLines: 1,
                                    autofocus: false,
                                    onSaved: (x) {
                                      email = x;
                                    },
                                    decoration:

                                    InputDecoration(
                                      fillColor: Colors.white,

                                      helperStyle: TextStyle(fontSize: 13),
                                      hintText: 'Please Enter Your Email',hintStyle: TextStyle(fontSize: 15),
                                      isDense: true,
                                      prefixIcon: Icon(FontAwesomeIcons.mailBulk,size: 15,color: Colors.purple,),
                                    ),
//                            maxLength: 10,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom: 10),
                                child: Row(children: <Widget>[
                                  Text(
                                    'Mobile Number',
                                    style: TextStyle(color: Colors.grey[500]),
                                  )
                                ]),
                              ),
                              Container(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5),
                                  child: TextFormField(
                                    initialValue: studentInfoJson['data']
                                    ['MobileNo'] ==
                                            null
                                        ? ''
                                        : studentInfoJson['data']
                                                    ['MobileNo'] ==
                                                ''
                                            ? ''
                                            : studentInfoJson['data']
                                                ['MobileNo'],
                                    textCapitalization:
                                        TextCapitalization.words,
                                    maxLines: null,
                                    autofocus: false,
                                    onSaved: (x) {
                                      mobileNumber = x;
                                    },
                                    decoration:

                                    InputDecoration(
                                      fillColor: Colors.white,

                                      helperStyle: TextStyle(fontSize: 13),
                                      hintText: 'Please Enter Your Mobile Number',hintStyle: TextStyle(fontSize: 15),
                                      isDense: true,
                                      prefixIcon: Icon(FontAwesomeIcons.mobileAlt,size: 15,color: Colors.purple,),
                                    ),
//                            maxLength: 10,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom: 10),
                                child: Row(children: <Widget>[
                                  Text(
                                    'Emirates ID',
                                    style: TextStyle(color: Colors.grey[500]),
                                  )
                                ]),
                              ),
                              Container(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5),
                                  child: TextFormField(
                                    initialValue: studentInfoJson['data']
                                    ['EmiratesID'] ==
                                            null
                                        ? ''
                                        : studentInfoJson['data']
                                                    ['EmiratesID'] ==
                                                ''
                                            ? ''
                                            : studentInfoJson['data']
                                                ['EmiratesID'],
                                    textCapitalization:
                                        TextCapitalization.words,
                                    maxLines: null,
                                    autofocus: false,
                                    onSaved: (x) {
                                      eid = x;
                                    },
                                    decoration:

                                    InputDecoration(
                                      fillColor: Colors.white,

                                      helperStyle: TextStyle(fontSize: 13),
                                      hintText: 'Please Enter Your E-ID',hintStyle: TextStyle(fontSize: 15),
                                      isDense: true,
                                      prefixIcon: Icon(FontAwesomeIcons.idCard,size: 15,color: Colors.purple,),
                                    ),
//                            maxLength: 10,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom: 10),
                                child: Row(children: <Widget>[
                                  Text(
                                    'Passport Number',
                                    style: TextStyle(color: Colors.grey[500]),
                                  )
                                ]),
                              ),
                              Container(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5),
                                  child: TextFormField(
                                    initialValue: studentInfoJson['data']
                                    ['PassportNo']  ==
                                            null
                                        ? ''
                                        : studentInfoJson['data']
                                                    ['PassportNo'] ==
                                                ''
                                            ? ''
                                            : studentInfoJson['data']
                                                ['PassportNo'],
                                    textCapitalization:
                                        TextCapitalization.words,
                                    maxLines: null,
                                    autofocus: false,
                                    onSaved: (x) {
                                      passport = x;
                                    },
                                    decoration:

                                    InputDecoration(
                                      fillColor: Colors.white,

                                      helperStyle: TextStyle(fontSize: 13),
                                      hintText: 'Please Enter Your Passport Number',hintStyle: TextStyle(fontSize: 15),
                                      isDense: true,
                                      prefixIcon: Icon(FontAwesomeIcons.passport,size: 15,color: Colors.purple,),
                                    ),
//                            maxLength: 10,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom: 10),
                                child: Row(children: <Widget>[
                                  Text(
                                    'Visa Number',
                                    style: TextStyle(color: Colors.grey[500]),
                                  )
                                ]),
                              ),
                              Container(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5),
                                  child: TextFormField(
                                    initialValue: studentInfoJson['data']
                                    ['Visa'] ==
                                            null
                                        ? ''
                                        : studentInfoJson['data']
                                                    ['Visa'] ==
                                                ''
                                            ? ''
                                            : studentInfoJson['data']
                                                ['Visa'],
                                    textCapitalization:
                                        TextCapitalization.words,
                                    maxLines: null,
                                    autofocus: false,
                                    onSaved: (x) {
                                      visa = x;
                                    },
                                    decoration:

                                    InputDecoration(
                                      fillColor: Colors.white,

                                      helperStyle: TextStyle(fontSize: 13),
                                      hintText: 'Please Enter Your Visa Number',hintStyle: TextStyle(fontSize: 15),
                                      isDense: true,
                                      prefixIcon: Icon(FontAwesomeIcons.passport,size: 15,color: Colors.purple,),
                                    ),
//                            maxLength: 10,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: 450,
                                height: 30,
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
                                child: Center(child: Text('Parent Details',style: TextStyle(color:Colors.white),)),


                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom: 10),
                                child: Row(children: <Widget>[
                                  Text(
                                    'Parent Name',
                                    style: TextStyle(color: Colors.grey[500]),
                                  )
                                ]),
                              ),
                              Container(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5),
                                  child: TextFormField(
                                    initialValue: studentInfoJson['data']
                                    ['ParentName']  ==
                                            null
                                        ? ''
                                        : studentInfoJson['data']
                                                    ['ParentName'] ==
                                                ''
                                            ? ''
                                            : studentInfoJson['data']
                                                ['ParentName'],

                                    textCapitalization:
                                        TextCapitalization.words,
                                    maxLines: null,
                                    autofocus: false,
                                    onSaved: (x) {
                                      pName = x;
                                    },
                                    decoration:

                                    InputDecoration(
                                      fillColor: Colors.white,

                                      helperStyle: TextStyle(fontSize: 13),
                                      hintText: 'Please Enter Your Parent Name',hintStyle: TextStyle(fontSize: 15),
                                      isDense: true,
                                      prefixIcon: Icon(FontAwesomeIcons.user,size: 15,color: Colors.purple,),
                                    ),
//                            maxLength: 10,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom: 10),
                                child: Row(children: <Widget>[
                                  Text(
                                    'Parent Emirates ID',
                                    style: TextStyle(color: Colors.grey[500]),
                                  )
                                ]),
                              ),
                              Container(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5),
                                  child: TextFormField(
                                    initialValue: studentInfoJson['data']
                                    ['ParentEmiratesIDNo'] ==
                                            null
                                        ? ''
                                        : studentInfoJson['data']
                                                    ['ParentEmiratesIDNo'] ==
                                                ''
                                            ? ''
                                            : studentInfoJson['data']
                                                ['ParentEmiratesIDNo'],
                                    textCapitalization:
                                        TextCapitalization.words,
                                    maxLines: null,
                                    autofocus: false,
                                    onSaved: (x) {
                                      pEid = x;
                                    },
                                    decoration:

                                    InputDecoration(
                                      fillColor: Colors.white,

                                      helperStyle: TextStyle(fontSize: 13),
                                      hintText: 'Please Enter Your Parent E-ID',hintStyle: TextStyle(fontSize: 15),
                                      isDense: true,
                                      prefixIcon: Icon(FontAwesomeIcons.idCard,size: 15,color: Colors.purple,),
                                    ),
//                            maxLength: 10,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom: 10),
                                child: Row(children: <Widget>[
                                  Text(
                                    'Parent Mobile Number',
                                    style: TextStyle(color: Colors.grey[500]),
                                  )
                                ]),
                              ),
                              Container(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5),
                                  child: TextFormField(
                                    initialValue: studentInfoJson['data']
                                    ['Parent Mobile No'] ==
                                            null
                                        ? ''
                                        : studentInfoJson['data']
                                                    ['Parent Mobile No'] ==
                                                ''
                                            ? ''
                                            : studentInfoJson['data']
                                                ['Parent Mobile No'],

                                    textCapitalization:
                                        TextCapitalization.words,
                                    maxLines: null,
                                    autofocus: false,
                                    onSaved: (x) {
                                      pMobileNumber = x;
                                    },
                                    decoration:

                                    InputDecoration(
                                      fillColor: Colors.white,

                                      helperStyle: TextStyle(fontSize: 13),
                                      hintText: 'Please Enter Your Parent Mobile Number',hintStyle: TextStyle(fontSize: 15),
                                      isDense: true,
                                      prefixIcon: Icon(FontAwesomeIcons.mobileAlt,size: 15,color: Colors.purple,),
                                    ),
//                            maxLength: 10,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom: 10),
                                child: Row(children: <Widget>[
                                  Text(
                                    'Parent Email ID',
                                    style: TextStyle(color: Colors.grey[500]),
                                  )
                                ]),
                              ),
                              Container(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5),
                                  child: TextFormField(
                                    initialValue: //TODO: If Statement
                                    studentInfoJson['data']
                                    ['Parent Email'] == null
                                            ? ''
                                            : studentInfoJson['data']
                                                        ['Parent Email'] ==
                                                    ''
                                                ? ''
                                                : studentInfoJson[
                                                    'data']['Parent Email'],
                                    textCapitalization:
                                        TextCapitalization.words,
                                    maxLines: null,
                                    autofocus: false,
                                    onSaved: (x) {
                                      pEmail = x;
                                    },
                                    decoration:

                                    InputDecoration(
                                      fillColor: Colors.white,

                                      helperStyle: TextStyle(fontSize: 13),
                                      hintText: 'Please Enter Your Parent Email',hintStyle: TextStyle(fontSize: 15),
                                      isDense: true,
                                      prefixIcon: Icon(FontAwesomeIcons.mailBulk,size: 15,color: Colors.purple,),
                                    ),
//                            maxLength: 10,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom: 10),
                                child: Row(children: <Widget>[
                                  Text(
                                    'Residence Telephone Number',
                                    style: TextStyle(color: Colors.grey[500]),
                                  )
                                ]),
                              ),
                              Container(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5),
                                  child: TextFormField(

                                    initialValue:

                                    studentInfoJson['data']
                                    ['ResidenceNumber'] ==
                                            null
                                        ? ''
                                        : studentInfoJson['data']
                                                    ['ResidenceNumber'] ==
                                                ''
                                            ? ''
                                            : studentInfoJson['data']
                                                ['ResidenceNumber'],
                                    textCapitalization:
                                        TextCapitalization.words,
                                    maxLines: null,
                                    autofocus: false,
                                    onSaved: (x) {
                                      pMobileTelephone = x;
                                    },
                                    decoration:

                                    InputDecoration(
                                      fillColor: Colors.white,

                                      helperStyle: TextStyle(fontSize: 13),
                                      hintText: 'Please Enter Your Telephone Number',hintStyle: TextStyle(fontSize: 15),
                                      isDense: true,
                                      prefixIcon: Icon(FontAwesomeIcons.phone,size: 15,color: Colors.purple,),
                                    ),
//                            maxLength: 10,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom: 10),
                                child: Row(children: <Widget>[
                                  Text(
                                    'Parent Work Company',
                                    style: TextStyle(color: Colors.grey[500]),
                                  )
                                ]),
                              ),
                              Container(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5),
                                  child: TextFormField(
                                    initialValue: studentInfoJson['data']
                                    ['ParentWorkPlace'] ==
                                            null
                                        ? ''
                                        : studentInfoJson['data']
                                                    ['ParentWorkPlace'] ==
                                                ''
                                            ? ''
                                            : studentInfoJson['data']
                                                ['ParentWorkPlace'],

                                    textCapitalization:
                                        TextCapitalization.words,
                                    maxLines: null,
                                    autofocus: false,
                                    onSaved: (x) {
                                      pWork = x;
                                    },
                                    decoration:

                                    InputDecoration(
                                      fillColor: Colors.white,

                                      helperStyle: TextStyle(fontSize: 13),
                                      hintText: 'Please Enter Your Parent Company',hintStyle: TextStyle(fontSize: 15),
                                      isDense: true,
                                      prefixIcon: Icon(FontAwesomeIcons.building,size: 15,color: Colors.purple,),
                                    ),
//                            maxLength: 10,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom: 10),
                                child: Row(children: <Widget>[
                                  Text(
                                    'Parent Work Position ',
                                    style: TextStyle(color: Colors.grey[500]),
                                  )
                                ]),
                              ),
                              Container(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5),
                                  child: TextFormField(
                                    initialValue: studentInfoJson['data']
                                    ['Designation'] ==
                                            null
                                        ? ''
                                        : studentInfoJson['data']
                                                    ['Designation'] ==
                                                ''
                                            ? ''
                                            : studentInfoJson['data']
                                                ['Designation'],
                                    textCapitalization:
                                        TextCapitalization.words,
                                    maxLines: null,
                                    autofocus: false,
                                    onSaved: (x) {
                                      pDesignation = x;
                                    },
                                    decoration:

                                    InputDecoration(
                                      fillColor: Colors.white,

                                      helperStyle: TextStyle(fontSize: 13),
                                      hintText: 'Please Enter Your Parent Work Position',hintStyle: TextStyle(fontSize: 15),
                                      isDense: true,
                                      prefixIcon: Icon(FontAwesomeIcons.userTie,size: 15,color: Colors.purple,),
                                    ),
//                            maxLength: 10,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, bottom: 10),
                                child: Row(children: <Widget>[
                                  Text(
                                    'Po Box Number',
                                    style: TextStyle(color: Colors.grey[500]),
                                  )
                                ]),
                              ),
                              Container(
                                height: 40,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 5.0, right: 5),
                                  child: TextFormField(
                                    initialValue: studentInfoJson['data']
                                    ['Po BoxNumber'] ==
                                            null
                                        ? ''
                                        : studentInfoJson['data']
                                                    ['Po BoxNumber'] ==
                                                ''
                                            ? ''
                                            : studentInfoJson['data']
                                                ['Po BoxNumber'],

                                    textCapitalization:
                                        TextCapitalization.words,
                                    maxLines: null,
                                    autofocus: false,
                                    onSaved: (x) {
                                      boxNumber = x;
                                    },
                                    decoration:

                                    InputDecoration(
                                      fillColor: Colors.white,

                                      helperStyle: TextStyle(fontSize: 13),
                                      hintText: 'Please Enter Your Po.Box Number',hintStyle: TextStyle(fontSize: 15),
                                      isDense: true,
                                      prefixIcon: Icon(FontAwesomeIcons.inbox,size: 15,color: Colors.purple,),
                                    ),
//                            maxLength: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left:15.0),
                          child: Column(children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text('Working Student'),

                                Row(
                                  children: <Widget>[
                                    Text('Yes'),
                                    Radio(
                                      value: 1,
                                      groupValue: workingValue,
                                      onChanged: (int e) {
                                        setState(() {
                                          workingValue = e;
                                        });
                                      },
                                      activeColor: Colors.purple,
                                    ),
                                    Text('No'),
                                    Radio(
                                      value: 2,
                                      groupValue: workingValue,
                                      onChanged: (int e) {
                                        setState(() {
                                          workingValue = e;
                                        });
                                      },
                                      activeColor: Colors.purple,
                                    ),
                                  ],
                                ),

                              ],
                            ),
                          ],),
                        ),
                        //TODO: Working
SizedBox(height: 20,),
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
                                  getStudentPersonalInfo();

                                },
                                child: Center(
                                    child: Text(
                                      'Submit',
                                      style: TextStyle(color: Colors.white),
                                    )))),
                        SizedBox(height: 20,),


                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }

 

//TODO: RequestType

//TODO: Final Request

  Future getStudentInfo() async {
    Future.delayed(Duration.zero, () {
      showLoading(true,context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getStudentPersonalInfo'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'usertype':studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            studentInfoJson = json.decode(response.body);
          },
        );
        if (studentInfoJson['data']['VisaStudent'] == "NO") {
          visaValue = 2;
        } else {
          visaValue = 1;
        }
        if (studentInfoJson['data']['Dependent'] == "NO") {
          dependentValue = 2;
        } else {
          dependentValue = 1;
        }
        if (studentInfoJson['data']['Hostel Required'] == "NO") {
          hostelValue = 2;
        } else {
          hostelValue = 1;
        }
        if (studentInfoJson['data']['WORKING'] == "NO") {
          workingValue = 2;
        } else {
          workingValue = 1;
        }

        showLoading(false,context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false,context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,context,getStudentInfo);
      } else {
          showLoading(false,context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi,context,getStudentInfo);
      }
    }
  }

  Future getStudentPersonalInfo() async {
    if (_information.currentState.validate()) {
      _information.currentState.save();
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
            'https://skylineportal.com/moappad/api/web/studentPersonalInfo'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'visa_student': visaValue== 1 ? 'Yes': visaValue== 2 ? 'No':visaValue,
          'dependent': dependentValue== 1 ? 'Yes': dependentValue== 2 ? 'No':dependentValue,
          'staying_hostel': hostelValue== 1 ? 'Yes': hostelValue== 2 ? 'No':hostelValue,
          'email': email,
          'mobile_no': mobileNumber,
          'visa_no': visa,
          'passport_no': passport,
          'emirates_id': eid,
          'parent_name': pName,
          'parent_emirates_id': pEid,
          'parent_mobile_no': pMobileNumber,
          'parent_email': pEmail,
          'residence_tel': pMobileTelephone,
          'parent_workplace': pWork,
          'parent_designation': pDesignation,
          'po_box_no': boxNumber,
          'working_student': workingValue== 1 ? 'Yes': workingValue== 2 ? 'No':workingValue,
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
            studentPersonalInfoJson = json.decode(response.body);
          },
        );

        showLoading(false,context);
      }
      if ( studentPersonalInfoJson['success'] == '0'){
        showLoading(false,context);
        Fluttertoast.showToast(
            msg: studentPersonalInfoJson['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey[400],
            textColor: Colors.black87,
            fontSize: 13.0
        );
      }

    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false,context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,context,getStudentInfo);
      } else {
          showLoading(false,context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi,context,getStudentInfo);
      }
    }
  }
}
