import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;
import 'package:superellipse_shape/superellipse_shape.dart';

void main() => runApp(SalaryCertificate());

class SalaryCertificate extends StatefulWidget {
  final String myAdvisorName;

  const SalaryCertificate({Key key, this.myAdvisorName}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SalaryCertificateState();
  }
}

final _company = GlobalKey<FormState>();
final  _addressCertificate = GlobalKey<FormState>();
final  _cityCertificate = GlobalKey<FormState>();
final  _other = GlobalKey<FormState>();



Map<String, int> body;

class _SalaryCertificateState extends State<SalaryCertificate> {


  String _country;
  String _purpose;

  @override
  void initState() {
super.initState();
    getSalaryPurposeTypeAndCountry();
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
                  Text("Salary Certificate",style: TextStyle(color: Colors.white),),

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
      body: ListView(
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
                  Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.centerLeft,
                          child: Text('Purpose of the application',style:TextStyle(color: Colors.grey[600]),)),
                      ),
                      DropdownButton<String>(
                        
                        isExpanded: true,
                        hint: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Select',style:TextStyle(color: Colors.black),),
                        ),
                        value: _purpose,
                        items: purposeJson
                            ?.map(
                              
                              (item) => DropdownMenuItem<String>(
                              value: item['purposeid'].toString(),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom:8.0,left:8),
                                child: Text(item['PurposeName']),
                              )),
                        )
                            ?.toList() ??
                            [],
                        onChanged: (value) {
                          setState(() {
                            _purpose = value;

                            print(_purpose);
                          });
                        },
                      ),
                    ],
                  ),
SizedBox(height: 15,),
                  Container(
                    
                    alignment: Alignment.centerLeft,
                    child: Padding(
                        padding: const EdgeInsets.all(10.0),
                          child: Text(
                            'Attention To Submit',
                          ),
                        ),
                      ),
                  Column(
                    children: <Widget>[


                      Form(
                        key: _company,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextFormField(

                                textCapitalization: TextCapitalization.words,
                                maxLines: null,
                                onSaved: (x) {
                                  comapny = x;
                                },
                                decoration:

                                InputDecoration(
                                  labelText: "Company and address",
                                  fillColor: Colors.white,

                                  helperStyle: TextStyle(fontSize: 13),
                                  hintText: 'Please enter your company and address',hintStyle: TextStyle(fontSize: 15),
                                  isDense: true,
                                  prefixIcon: Icon(FontAwesomeIcons.briefcase,size: 15,color: Colors.purple,),
                                ),
                              ),

                          ],
                        ),
                      ),
                      Form(
                        key: _addressCertificate,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextFormField(

                                textCapitalization: TextCapitalization.words,
                                maxLines: null,
                                onSaved: (x) {
                                  addressCertificate = x;
                                },
                                decoration:

                                InputDecoration(
                                  labelText: "Adresss",
                                  fillColor: Colors.white,

                                  helperStyle: TextStyle(fontSize: 13),
                                  hintText: 'Please Enter Your Adresss',hintStyle: TextStyle(fontSize: 15),
                                  isDense: true,
                                  prefixIcon: Icon(FontAwesomeIcons.building,size: 15,color: Colors.purple,),
                                ),
                              ),

                          ],
                        ),
                      ),
                      Form(
                        key: _cityCertificate,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            TextFormField(

                                textCapitalization: TextCapitalization.words,
                                maxLines: null,
                                onSaved: (x) {
                                  cityCertificate = x;
                                },
                                decoration:

                                InputDecoration(
                                  labelText: "City",
                                  fillColor: Colors.white,

                                  helperStyle: TextStyle(fontSize: 13),
                                  hintText: 'Please Enter Your city',hintStyle: TextStyle(fontSize: 15),
                                  isDense: true,
                                  prefixIcon: Icon(FontAwesomeIcons.city,size: 15,color: Colors.purple,),
                                ),
                              ),

                          ],
                        ),
                      ),


                    
                      SizedBox(height: 15,),
                      Column(
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Country',style: TextStyle(color: Colors.grey[600]),),
                            ),
                          ),
                          DropdownButton<String>(
                            value: _country,
                            isExpanded: true,
                            hint: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Select',style: TextStyle(color: Colors.black),),
                            ),
                            items: countryJson
                                ?.map((item) => DropdownMenuItem<String>(
                                value: item['id'].toString(),
                                child: Text(item['country'])))
                                ?.toList() ??
                                [],
                            onChanged: (value) {
                              setState(() {
                                _country = value;

                                print(_country);
                              });
                            },
                          ),
                          SizedBox(height: 30,),
                        ],
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
                            getSalaryCertificate();
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
                    getSalaryPurposeTypeAndCountry();
                  },
                  child: new Text('Try again'),
                ),
              ],
            ),
          );
        });
  }

  Future getSalaryPurposeTypeAndCountry() async {
    Future.delayed(Duration.zero, () {
      _showLoading(true);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getSalaryPurposeTypeAndCountry'),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
        },
        body: {
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
              () {
            purposeJson = json.decode(response.body)['data']['purpose_types'];
            countryJson = json.decode(response.body)['data']['country'];


          },
        );
        _showLoading(false);
      }
    } catch (x) {
      if(x.toString().contains("TimeoutException")){
        _showError("Time out from server",FontAwesomeIcons.hourglassHalf);
      }else{
        _showError("Sorry, we can't connect",Icons.perm_scan_wifi);
      }

    }
  }

  Future getSalaryCertificate() async {
    if (_cityCertificate.currentState.validate()) {
      _cityCertificate.currentState.save();
    }
    if (_addressCertificate.currentState.validate()) {
      _addressCertificate.currentState.save();
    }
    if (_company.currentState.validate()) {
      _company.currentState.save();
    }
    Future.delayed(Duration.zero, () {});

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/advisorAppointment'),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
        },
        body: {
          'user_id': username,
          'app_purpose': _purpose,
          'country': _country,
          'others':other,
          'company_address':comapny,
          'address':addressCertificate,
          'city':cityCertificate,
          'usertype': studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
              () {
                salaryCertificateJson = json.decode(response.body);
          },
        );

      }
      if ( salaryCertificateJson['success'] == '0'){
        _showLoading(false);
        Fluttertoast.showToast(
            msg: salaryCertificateJson['message'],
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
