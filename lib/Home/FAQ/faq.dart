import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Home/Events/oneEvent.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

import '../home.dart';


void main() => runApp(FAQ());

class FAQ extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _FAQState();
  }
}

List news = [];

File dataFile;

Map<String, String> body;



class _FAQState extends State<FAQ> {
  @override
  void initState() {
    super.initState();
    getFaqByType();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                  Text("FAQ?",style: TextStyle(color: Colors.white),),

                  GestureDetector(
                    onTap: () {
                     logOut(context);},

                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        children: <Widget>[

                          Icon(FontAwesomeIcons.home,color: Colors.white,size: 15,),
                          SizedBox(width: 5,),
                          Text('Home',style: TextStyle(fontSize: 15,color: Colors.white),),
                        ],
                      ),
                    ),
                  ),

                ],),
            ),
            //TODO: Put all Icon Container
          ],
        ),
      ),
      body: Container(
        color: Colors.white,
        child:

        ListView.builder(

          itemCount: faqByTypeJson.length,
          itemBuilder: (BuildContext context, int index) {
            return

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
elevation: 20,

                  child: Container(

                    child: ExpansionTile(
leading: Icon(FontAwesomeIcons.question,size: 20,),
                      title: Text(
                        faqByTypeJson[index]['question']
                            .toString(),style: TextStyle(fontSize: 14, color: Colors.black)

                      ),

                      children: <Widget>[
                        Divider(color: Colors.black),

Row(children: <Widget>[
  Padding(
    padding: const EdgeInsets.all(15.0),
    child: Icon(FontAwesomeIcons.checkCircle,size: 20,),
  ),
SizedBox(width: 10,),
  Expanded(
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Text(
        faqByTypeJson[index]['answer']
            .toString(),style: TextStyle(fontSize: 13),
      ),
    ),
  ),
],),

                      ],

                    ),
                  ),
                ),
              );


          },
        ),
//        ExpansionTile(
//          title: Text(''),
//
//
//        ),
      ),
    );
  }
 

  void _showError(String msg,IconData icon) {
    showLoading(false,context);
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
                    getFaqByType();
                  },
                  child: new Text('Try again'),
                ),
              ],
            ),
          );
        });
  }



  Future getFaqByType() async {

    Future.delayed(Duration.zero, () {
      showLoading(true,context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getFaqByType'),
        headers: {
          "API-KEY": API,
        },
        body: {

          'faq_type':'1',
          'usertype':'1',
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',

        },
      );
      if (response.statusCode == 200) {
        setState(
              () {
                faqByTypeJson = json.decode(response.body)['data'];
                faqByTypeMessageJson = json.decode(response.body);


          },
        );
        showLoading(false,context);
      }
      if ( faqByTypeMessageJson['success'] == '0'){
        showLoading(false,context);
        Fluttertoast.showToast(
            msg: faqByTypeMessageJson['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey[400],
            textColor: Colors.black87,
            fontSize: 13.0
        );
      }
    } catch (x) {if(x.toString().contains("TimeoutException")){
      _showError("Time out from server",FontAwesomeIcons.hourglassHalf);
    }else{
      _showError("Sorry, we can't connect",Icons.perm_scan_wifi);

    }

    }
  }

}
