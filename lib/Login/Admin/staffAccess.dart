

import 'dart:convert';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/zigzag.dart';
import 'package:skyline_university/Home/home.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:skyline_university/Global/global.dart';



void main() => runApp(GPAS());

class GPAS extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GPASState();
  }
}


Map<String, int> body;
final _userId = GlobalKey<FormState>();
String userids='';
class _GPASState extends State<GPAS> {
  @override
  void initState() {
    super.initState();


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
                    Text("Advisor Details",style: TextStyle(color: Colors.white),),

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


        body: 
        selectStaff == 1 ?
        
        
        
        Container(

          child: ListView.builder(
              itemCount: staffPJson.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    child: Column(
                  children: <Widget>[
                    Text('User Image'),
                    Text(
                      staffPJson.toString().isEmpty
                          ? ''
                          : staffPJson[index]['password'].toString()== null? '' :staffPJson[index]['password'].toString()
                    ),
                  ],
                ));
              },
            ),
              
              
                         
          
        )
        : selectStudent == 4 ? 


          ListView.builder(
              itemCount: imageJson.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    child: Column(
                  children: <Widget>[
                    Text('User Image'),
                    Image.network(
                      imageJson.toString().isEmpty
                          ? ''
                          : 'https://skylineportal.com//sitgmioxg//Ee2Dj01aPxBzphWzq//' +
                              imageJson[index]['RandomID'].toString() +
                              '.JPEG',
                      height: 300,
                      width: 300,
                    ),
                  ],
                ));
              },
            )

: SizedBox()


        );
  
  



  }


   
 
}
