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

void main() => runApp(MembershipForm());

class MembershipForm extends StatefulWidget {



  @override
  State<StatefulWidget> createState() {
    return _MembershipFormState();
  }
}

final _name = GlobalKey<FormState>();
final  _residential = GlobalKey<FormState>();
final  _home = GlobalKey<FormState>();
final  _work = GlobalKey<FormState>();
final  _mobile = GlobalKey<FormState>();

String nameForm = '';

String residential = '';
String homeForm = '';
String workForm = '';
String mobileForm = '';


// Map<String, int> body;

class _MembershipFormState extends State<MembershipForm> {

List membershipRelationsJson=[];
Map membershipFormJson={};

  String _relations;
  String _gender;

  @override
  void initState() {
super.initState();
    getMembershipFormRelations();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
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
                  Text("MemberShip Form ",style: TextStyle(color: Colors.white),),

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
      ),      body: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              color: Colors.grey[300],
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text('Name '),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Form(
                    key: _name,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                        
                          child: TextFormField(

                            textCapitalization: TextCapitalization.words,
                            maxLines: null,
                            onSaved: (x) {
                              nameForm = x;
                            },
                            decoration: InputDecoration(
                                labelText: "Place From",
                                fillColor: Colors.white,
                                helperStyle: TextStyle(fontSize: 13),
                                hintText: 'Please Enter Your Adress want go',
                                hintStyle: TextStyle(fontSize: 15),
                                isDense: true,
                                prefixIcon: Icon(
                                  FontAwesomeIcons.addressCard,
                                  size: 15,
                                  color: Colors.purple,
                                ),
                              ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: <Widget>[
                      Text('Gender'),

                      DropdownButton<String>(
                        value: _gender,
                        isExpanded: true,
                        hint: Text('Relations'),
                        items: <String>['Male', 'Female']
                            ?.map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(item)))
                            ?.toList() ??
                            [],
                        onChanged: (value) {
                          setState(() {
                            _gender = value;

                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text('Relations'),
                      DropdownButton<String>(
                        value: _relations,
                        isExpanded: true,
                        hint: Text('Relations'),
                        items: membershipRelationsJson
                            ?.map((item) => DropdownMenuItem<String>(
                            value: item['name'].toString(),
                            child: Text(item['name'])))
                            ?.toList() ??
                            [],
                        onChanged: (value) {
                          setState(() {
                            _relations = value;

                          });
                        },
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[

                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Residential Address'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                        key: _residential,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                            
                              child: TextFormField(

                                textCapitalization: TextCapitalization.words,
                                maxLines: null,
                                onSaved: (x) {
                                  residential = x;
                                },
                               decoration: InputDecoration(
                                labelText: "Place From",
                                fillColor: Colors.white,
                                helperStyle: TextStyle(fontSize: 13),
                                hintText: 'Please Enter Your Adress want go',
                                hintStyle: TextStyle(fontSize: 15),
                                isDense: true,
                                prefixIcon: Icon(
                                  FontAwesomeIcons.addressCard,
                                  size: 15,
                                  color: Colors.purple,
                                ),
                              ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Home'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                        key: _home,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              
                              child: TextFormField(

                                textCapitalization: TextCapitalization.words,
                                maxLines: null,
                                onSaved: (x) {
                                  homeForm = x;
                                },
                                decoration: InputDecoration(
                                labelText: "Place From",
                                fillColor: Colors.white,
                                helperStyle: TextStyle(fontSize: 13),
                                hintText: 'Please Enter Your Adress want go',
                                hintStyle: TextStyle(fontSize: 15),
                                isDense: true,
                                prefixIcon: Icon(
                                  FontAwesomeIcons.addressCard,
                                  size: 15,
                                  color: Colors.purple,
                                ),
                              ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Work'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                        key: _work,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                          
                              child: TextFormField(

                                textCapitalization: TextCapitalization.words,
                                maxLines: null,
                                onSaved: (x) {
                                  workForm = x;
                                },
                           decoration: InputDecoration(
                                labelText: "Place From",
                                fillColor: Colors.white,
                                helperStyle: TextStyle(fontSize: 13),
                                hintText: 'Please Enter Your Adress want go',
                                hintStyle: TextStyle(fontSize: 15),
                                isDense: true,
                                prefixIcon: Icon(
                                  FontAwesomeIcons.addressCard,
                                  size: 15,
                                  color: Colors.purple,
                                ),
                              ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text('Mobile'),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Form(
                        key: _mobile,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                          
                              child: TextFormField(

                                textCapitalization: TextCapitalization.words,
                                maxLines: null,
                                onSaved: (x) {
                                  mobileForm = x;
                                },
                              decoration: InputDecoration(
                                labelText: "Place From",
                                fillColor: Colors.white,
                                helperStyle: TextStyle(fontSize: 13),
                                hintText: 'Please Enter Your Adress want go',
                                hintStyle: TextStyle(fontSize: 15),
                                isDense: true,
                                prefixIcon: Icon(
                                  FontAwesomeIcons.addressCard,
                                  size: 15,
                                  color: Colors.purple,
                                ),
                              ),
                              ),
                            ),
                            SizedBox(height: 30,)
                          ],
                        ),
                      ),




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
                            getMembershipForm();
                          },
                          child: Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              ))))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


 Future getMembershipFormRelations() async {
    Future.delayed(Duration.zero, () {
      showLoading(true,context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getMembershipFormRelations'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'usertype':studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
              () {
            membershipRelationsJson = json.decode(response.body)['data'];


          },
        );
        showLoading(false,context);
      }
    } catch (x) {
      if(x.toString().contains("TimeoutException")){
        showLoading(false,context);showError("Time out from server", FontAwesomeIcons.hourglassHalf,context,getMembershipFormRelations);
      }else{
        showLoading(false,context); showError("Sorry, we can't connect", Icons.perm_scan_wifi,context,getMembershipFormRelations);
      }

    }
  }

  Future getMembershipForm() async {
    if (_name.currentState.validate()) {
      _name.currentState.save();
    }
    if (_residential.currentState.validate()) {
      _residential.currentState.save();
    }
    if (_home.currentState.validate()) {
      _home.currentState.save();
    }
    if (_work.currentState.validate()) {
      _work.currentState.save();
    }
    if (_mobile.currentState.validate()) {
      _mobile.currentState.save();
    }
    Future.delayed(Duration.zero, () {});

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/membershipForm'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'name': nameForm,
          'gender': _gender,
          'relation':_relations,
          'address':residential,
          'contact_home':homeForm,
          'contact_work':workForm,
          'contact_mobile':mobileForm,
          'usertype':studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
              () {
                membershipFormJson = json.decode(response.body);
          },
        );
      }
      if ( membershipFormJson['success'] == '0'){
        showLoading(false,context);
        Fluttertoast.showToast(
            msg: membershipFormJson['message'],
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
        showLoading(false,context);showError("Time out from server", FontAwesomeIcons.hourglassHalf,context,getMembershipForm);
      }else{
        showLoading(false,context); showError("Sorry, we can't connect", Icons.perm_scan_wifi,context,getMembershipForm);
      }

    }
  }
}
