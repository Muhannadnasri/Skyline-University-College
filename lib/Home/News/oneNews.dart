
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../home.dart';
import 'news.dart';


void main() => runApp(OneNews());

class OneNews extends StatefulWidget {
  final String oneNewsTitle;
  final String oneNewsContent;
  final String oneNewsImage;
  final String oneNewsDate;



  const OneNews({Key key, this.oneNewsTitle, this.oneNewsContent, this.oneNewsImage, this.oneNewsDate}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _OneNewsState();
  }
}






class _OneNewsState extends State<OneNews> {
  @override
  void initState() {
super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    double c_width = MediaQuery.of(context).size.width*0.6;
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
                  Expanded(
                    child: Text(
                      'News',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) => Home()),
                              (Route<dynamic> route) => true);

                     },
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
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Hero(
                    tag: widget.oneNewsImage,
                    child: Container(
                      child: Image.network(widget.oneNewsImage, filterQuality: FilterQuality.medium,
                          width: MediaQuery.of(context).size.width,
                          fit: BoxFit.contain,
                        ),
                    ),
                ),
                Container(child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: <Widget>[
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(widget.oneNewsTitle),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:15.0,top: 5),
                      child: Container(
                        width: 100,
                        decoration: UnderlineTabIndicator(borderSide:BorderSide(width: 3,color: Colors.blue,style: BorderStyle.solid)),
                      ),
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(widget.oneNewsDate),
                    ),
                    SizedBox(height: 10,),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(widget.oneNewsContent),
                    )
                  ],
                ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }


}
