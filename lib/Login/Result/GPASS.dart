import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';

import 'package:skyline_university/Global/global.dart';

void main() => runApp(GPASS());

class GPASS extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GPASSState();
  }
}

Map<String, int> body;
final _userId = GlobalKey<FormState>();
String userids = '';

class _GPASSState extends State<GPASS> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
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
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Text(
                      "Advisor Details",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        logOut(context);
                      },
                      child: GestureDetector(
                        onTap: () {
                          logOut(context);
                        },
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
                                style:
                                    TextStyle(fontSize: 15, color: Colors.red),
                              ),
                            ],
                          ),
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
        body: selectStudent == 4
            ? ListView.builder(
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
            : selectStudent == 1
                ? Column(
                    children: <Widget>[
                      Text('STUDENT NAME'),
                      Text(gpaJson.toString().isEmpty
                          ? 'No Data'
                          : gpaJson['STUDENT NAME'] == null
                              ? 'No Data'
                              : gpaJson['STUDENT NAME']),
                      Text('STUDENT ADVISOR'),
                      Text(gpaJson.toString().isEmpty
                          ? 'No Data'
                          : gpaJson['ADVISOR'] == null
                              ? 'No Data'
                              : gpaJson['ADVISOR']),
                      Text('STUDENT GPA'),
                      Text(gpaJson.toString().isEmpty
                          ? 'No Data'
                          : gpaJson['CGPA'].toString() == null
                              ? 'No Data'
                              : gpaJson['CGPA'].toString()),
                    ],
                  )
                : selectStudent == 3
                    ? ListView.builder(
                        itemCount: finalJson.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 30,
                            child: Card(
                              child: Row(
                                children: <Widget>[
                                  Text('Mid'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(finalJson.toString().isEmpty
                                      ? 'No Data'
                                      : finalJson[index]['MidTerm']
                                                  .toString() ==
                                              null
                                          ? 'No Data'
                                          : finalJson[index]['MidTerm']
                                              .toString()),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Final'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(finalJson.toString().isEmpty
                                      ? 'No Data'
                                      : finalJson[index]['FinalTerm']
                                                  .toString() ==
                                              null
                                          ? 'No Data'
                                          : finalJson[index]['FinalTerm']
                                              .toString()),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Date'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(finalJson.toString().isEmpty
                                      ? 'No Data'
                                      : finalJson[index]['DateCreated']
                                                  .toString() ==
                                              null
                                          ? 'No Data'
                                          : finalJson[index]['DateCreated']
                                              .toString()),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Batch'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(finalJson.toString().isEmpty
                                      ? 'No Data'
                                      : finalJson[index]['Batch_Id']
                                                  .toString() ==
                                              null
                                          ? 'No Data'
                                          : finalJson[index]['Batch_Id']
                                              .toString()),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )
                    : 
                    selectStudent== 5 ? 
                    
                    Container(

          child: ListView.builder(
              itemCount: studentPJson.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    child: Column(
                  children: <Widget>[
                    Text('User Image'),
                    Text(
                      studentPJson.toString().isEmpty
                          ? ''
                          : studentPJson[index]['password'].toString()== null? '' :studentPJson[index]['password'].toString()
                    ),
                  ],
                ));
              },
            ),
              
              
                         
          
        )
                    
                    
                    
                    : selectStudent == 2 ? 


ListView.builder(
                        itemCount: marksJson.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 30,
                            child: Card(
                              child: Row(
                                children: <Widget>[
                                  Text('Mid'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(marksJson.toString().isEmpty
                                      ? 'No Data'
                                      : marksJson[index]['MidTerm']
                                                  .toString() ==
                                              null
                                          ? 'No Data'
                                          : marksJson[index]['MidTerm']
                                              .toString()),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Final'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(marksJson.toString().isEmpty
                                      ? 'No Data'
                                      : marksJson[index]['FinalTerm']
                                                  .toString() ==
                                              null
                                          ? 'No Data'
                                          : marksJson[index]['FinalTerm']
                                              .toString()),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Date'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(marksJson.toString().isEmpty
                                      ? 'No Data'
                                      : marksJson[index]['DateCreated']
                                                  .toString() ==
                                              null
                                          ? 'No Data'
                                          : marksJson[index]['DateCreated']
                                              .toString()),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text('Batch'),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(marksJson.toString().isEmpty
                                      ? 'No Data'
                                      : marksJson[index]['Batch_Id']
                                                  .toString() ==
                                              null
                                          ? 'No Data'
                                          : marksJson[index]['Batch_Id']
                                              .toString()),
                                  SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )


                    :
                    
                    SizedBox
                    
                    
                    
                    
                    );
  }
}
