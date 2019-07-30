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


Map<String, int> body;

class _ContactListState extends State<ContactList> {
  @override
  void initState() {
    getContactList();
    super.initState();
    contactListJson=[];
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar:PreferredSize(

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
                  Text("Contact List",style: TextStyle(color: Colors.white),),

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

      body: ListView.builder(
            itemCount: contactListJson.length,
            itemBuilder: (BuildContext context, int index) {

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 140,

          child: Card(

            color: contactListJson[index]['DEPARTMENT_NAME'] == 'BSIT' ?  Color(0xFF632a79) : Color(0xFF003a62)
              ,
            elevation: 15,
  shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)
          ),
          ),
  child:   Column(

    children: <Widget>[

          Row(children: <Widget>[


  Container(


    child: Padding(
      padding: const EdgeInsets.only(left:10.0),
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
                        image:
                        AssetImage(
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

SizedBox(width: 20,),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
SizedBox(height: 5,),
                Container(child: Text(contactListJson[index]['Name'].toString()),),
                  SizedBox(height: 5,),

                  Container(child:       Text(contactListJson[index]['Job_Name'].toString()),),
                  SizedBox(height: 5,),




              GestureDetector(
                  onTap: (){
              launch(


              'mailto:'+contactListJson[index]['OfficeMail']
                  .toString()

              );
              },

                  child: Text(contactListJson[index]['OfficeMail'].toString(),style: TextStyle(
              decoration: TextDecoration.underline,
              color: Colors.blue),)),
                  SizedBox(height: 5,),

                  GestureDetector(

                onTap: (){
                  launch(


                      'mailto:'+contactListJson[index]['Email'].toString()

                  );
                },
                child: Text(contactListJson[index]['Email'].toString(),style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue),),
              ),
                  SizedBox(height: 5,),
//                'tel:00'
                  GestureDetector(
                      onTap:  () {

                        launch(
                            contactListJson[index]['Mobile']
                                .toString().startsWith('9',0)

                                ?

                            'tel:00'+contactListJson[index]['Mobile'].toString()
                                :

                            'tel:'+contactListJson[index]['Mobile'].toString()
                          //
                        );
                      },
                      child: Text(


//

                          contactListJson[index]['Mobile']
                              .toString().startsWith('9',0)

                              ?

                          '00'+contactListJson[index]['Mobile'].toString()
                              :

                          ''+contactListJson[index]['Mobile'].toString()
,

                        style: TextStyle(

                          decoration: TextDecoration.underline,
                          color: Colors.blue),
////
                      )
                  ),
                  SizedBox(height: 5,),


                ],),
            ),

          ],),
  /*
          Text(contactListJson[index]['DEPARTMENT_NAME'].toString()),
          Text(contactListJson[index]['Name'].toString()),
          Text(contactListJson[index]['Job_Name'].toString()),
          Text(contactListJson[index]['OfficeExtn'].toString()),
          GestureDetector(
              onTap:  () {

                    launch('tel:00'+contactListJson[index]['Mobile']
                        .toString()
  //
                    );
                    },
              child: Text(contactListJson[index]['Mobile'].toString(),style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue),)),
          Text(contactListJson[index]['Employeetype'].toString()),
          GestureDetector(

              onTap: (){
                launch(


                    'mailto:'+contactListJson[index]['OfficeMail']
                        .toString()

                );
              },
              child: Text(contactListJson[index]['OfficeMail'].toString(),style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: Colors.blue),)),
          GestureDetector(

            onTap: (){
              launch(


                  'mailto:'+contactListJson[index]['Email'].toString()

              );
            },
            child: Text(contactListJson[index]['Email'].toString(),style: TextStyle(
                decoration: TextDecoration.underline,
                color: Colors.blue),),
          ),
          Text(contactListJson[index]['Department_Name'].toString()),
          Text(contactListJson[index]['RoomNo'].toString()),


   */

    ],
  ),
),
        ),
      );



            }
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
                    getContactList();
                  },
                  child: new Text('Try again'),
                ),
              ],
            ),
          );
        });
  }

  Future getContactList() async {
    Future.delayed(Duration.zero, () {
      _showLoading(true);


    });

    try {
      http.Response response = await http.post(
        Uri.encodeFull(
            "https://skylineportal.com/moappad/api/web/getStaffContactsList"),
        headers: {
          "API-KEY": "965a0109d2fde592b05b94588bcb43f5",
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
      print(contactListJson.toString());

      _showLoading(false);

    } catch (x) {
      print(x);
      if(x.toString().contains("TimeoutException")){
        _showError("Time out from server",FontAwesomeIcons.hourglassHalf);
      }else{
        _showError("Sorry, we can't connect",Icons.perm_scan_wifi);
      }

    }
  }

}
