import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(Chat());

class Chat extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ChatState();
  }
}

class _ChatState extends State<Chat> {
  @override
  void initState() {
super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      appBar: PreferredSize(  preferredSize: Size.fromHeight(60.0),

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
                        Navigator.popAndPushNamed(context, "/Home");
                      },
                      child: Icon(
                        FontAwesomeIcons.arrowLeft,color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView(

        children: <Widget>[
          SizedBox(height: 20,),
          Stack(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[Text("Name : ",style: TextStyle(color: Colors.blue),)]),
              Padding(
                padding: const EdgeInsets.only(left:50.0),
                child: Row(

                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[Text("Text")]),
              ),
            ],
          ),
          SizedBox(height: 20,),

          Container(

            width: MediaQuery.of(context).size.width / 1.2,
            height: 45,
            padding:
            EdgeInsets.only(top: 4, left: 16, right: 16, bottom: 4),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black12, blurRadius: 5)
                ]),
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(
                  Icons.message,
                  color: Colors.grey,
                ),
                hintText: 'Your Message',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
