import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Home/News/oneNews.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

import '../home.dart';


void main() => runApp(News());

class News extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _NewsState();
  }
}

List news = [];

File dataFile;

Map<String, String> body;



class _NewsState extends State<News> {
  @override
  void initState() {
super.initState();
    getNews();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    double c_width = MediaQuery.of(context).size.width*0.6;
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
                  Text("News",style: TextStyle(color: Colors.white),),

                  GestureDetector(
                    onTap: () {
                     logOut(context);},

                    child: Padding(
                      padding: const EdgeInsets.all(17),
                      child: Row(
                        children: <Widget>[

                          Icon(FontAwesomeIcons.home,color: Colors.white,size: 15,),
                          SizedBox(width: 5,),
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
        color: Colors.grey[300],
    child: ListView.builder(
      itemCount: news.length,
        itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OneNews(
                  oneNewsTitle: news[index]['title'],
                  oneNewsContent: news[index]['content'],
                    oneNewsImage: news[index]['image_big'],
                  oneNewsDate: news[index]['date'],

                ),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.only(top:5),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              elevation: 10,
              child:
              DottedBorder(
                color: Colors.blue,
                gap: 3,
                strokeWidth: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[

                    Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Hero(
                            tag: news[index]['image_big'],
                            child: Image.network(news[index]['image_big'],height: 80,width:100,filterQuality: FilterQuality.low,)),
                      ),
                    ),//TODO: Image news
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                             Container(

                               height: 20,
                               decoration: new BoxDecoration(
                                 borderRadius:
                                 BorderRadius.all(Radius.circular(10)),
                                 gradient: LinearGradient(
                                   begin: Alignment.topLeft,
                                   end: Alignment.bottomRight,
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
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Row(

                                    children: <Widget>[
                                  Icon(Icons.update,size: 10,color: Colors.white,),

                                  Text(news[index]['date'],style: TextStyle(fontSize: 10,color: Colors.white),)]
                                ),
                              ),
                            ),
//                    /TODO: Date
                          SizedBox(height: 10,),
                          Container(
width: c_width,
                            child: Text(news[index]['title'],textAlign: TextAlign.left,),
                          ),//TODO: Title
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );



        }

),
    ),
    );
  }
 

 




  Future getNews() async {
    new Future.delayed(Duration.zero, () {
      showLoading(true,context);
    });

    body = {
    };
    try {
      http.Response response =
      await http.post("http://www.muhannadnasri.com/App/news_events/data.json", body: body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        var Json = json.decode(response.body);
        Directory appDocDir = await getApplicationDocumentsDirectory();
        dataFile = new File(appDocDir.path + "/dataFile.json");

        if (dataFile.existsSync()) {
          if (Json['news'] != null) {
            dataFile.writeAsStringSync(response.body);
          }
        } else {
          dataFile.createSync();
          dataFile.writeAsStringSync(response.body);
        }

        if (Json['news'] != null) {
          appJson = Json;
        } else {
          appJson = json.decode(dataFile.readAsStringSync());
        }

        showLoading(false,context);

        setState(() {
          news = appJson["news"];
        });
        print(news[2]['date']);
      } else {}
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false,context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,context,getNews);
      } else {
          showLoading(false,context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi,context,getNews);
      }
    }
  }
}
