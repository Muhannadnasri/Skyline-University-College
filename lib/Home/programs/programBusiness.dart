import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Home/Events/oneEvent.dart';
import 'package:superellipse_shape/superellipse_shape.dart';
import 'package:transparent_image/transparent_image.dart';

import '../home.dart';
import 'oneGallery.dart';

void main() => runApp(ProgramBusiness());

class ProgramBusiness extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProgramBusinessState();
  }
}

List programbusiness = [];

File dataFile;

Map<String, String> body;

class _ProgramBusinessState extends State<ProgramBusiness> {
  @override
  void initState() {
    super.initState();

    getProgramBusiness();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
                    "Galleries",
                    style: TextStyle(color: Colors.white),
                  ),
                  GestureDetector(
                    onTap: () {
                     logOut(context);},
                    child: Padding(
                      padding: const EdgeInsets.all(17),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            FontAwesomeIcons.home,
                            color: Colors.white,
                            size: 15,
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
        child:  ListView.builder(
          itemCount: programbusiness.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(

                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => OneGallery(
                  //           oneGalleryPhotos: galleries[index]['photos'],
                  //           oneGalleryTitle: galleries[index]['Event_Name'],

                  //         ),
                  //   ),
                  // );
                },
                child:
              programbusiness[index]['Title'] == 'BS IT-EC (Enterprise Computing)' ? SizedBox():


                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    elevation: 10,
                    child: DottedBorder(
                      color: Colors.blue,
                      gap: 3,
                      strokeWidth: 1,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: <Widget>[

                          FadeInImage.memoryNetwork(
                            fadeOutCurve: Curves.easeOut,
                            fit: BoxFit.cover,
                            placeholder: kTransparentImage,
                            image: programbusiness[index]['Image'] == null ? '':programbusiness[index]['Image'],
                            width: 400,
                            height: 130,
                          ),

                          Container(
                            color: Colors.black26,
                            width: 400,
                            height: 130,
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(

                            color: Colors.grey[300],
                              height: 30,
                              width: 400,
                              child: Column(children: <Widget>[
SizedBox(height: 3,),
                                Flexible(
                                  child: Align(
                                    
                                    child: Html(
                                      

data: programbusiness[index]['Title'] ,
                                      // programbusiness[index]['Title'] 
                                      
                                      ),
                                  ),
                                ),
SizedBox(height: 3,),
// Text(galleries[index]['Image_Number']


//   ,style: TextStyle(color: Colors.black),),
                              ],),

                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  


  Future getProgramBusiness() async {
    new Future.delayed(Duration.zero, () {
      showLoading(true,context);
    });

    body = {};
    try {
      http.Response response = await http.post(
          "http://muhannadnasri.com/App/programs/data.json",
          body: body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var Json = json.decode(response.body);
        Directory appDocDir = await getApplicationDocumentsDirectory();
        dataFile = new File(appDocDir.path + "/dataFile.json");

        if (dataFile.existsSync()) {
          if (Json['events'] != null) {
            dataFile.writeAsStringSync(response.body);
          }
        } else {
          dataFile.createSync();
          dataFile.writeAsStringSync(response.body);
        }

        if (Json['events'] != null) {
          appJson = Json;
        } else {
          appJson = json.decode(dataFile.readAsStringSync());
        }

        showLoading(false,context);

        setState(() {
          programbusiness = appJson["events"];
        });
      } else {}
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false,context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,context,getProgramBusiness);
      } else {
          showLoading(false,context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi,context,getProgramBusiness);
      }
    }
  }
}
