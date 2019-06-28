
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


void main() => runApp(OneEvents());

class OneEvents extends StatefulWidget {
  final String oneEventsTitle;
  final String oneEventsContent;
  final String oneEventsImage;
  final String oneEventsDate;

  const OneEvents({Key key, this.oneEventsTitle, this.oneEventsContent, this.oneEventsImage, this.oneEventsDate}) : super(key: key);





  @override
  State<StatefulWidget> createState() {
    return _OneEventsState();
  }
}






class _OneEventsState extends State<OneEvents> {
  @override
  void initState() {
super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    double c_width = MediaQuery.of(context).size.width*0.6;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Image.asset('images/logo.png',
                width: 170,
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(context, "/");
                      },
                      child: Icon(
                        FontAwesomeIcons.arrowLeft,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                Hero(
                    tag: widget.oneEventsImage,
                    child: Container(
                      child: Image.network(widget.oneEventsImage, filterQuality: FilterQuality.medium,
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
                      child: Text(widget.oneEventsTitle),
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
                      child: Text(widget.oneEventsDate),
                    ),
                    SizedBox(height: 10,),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(widget.oneEventsContent),
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
