
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Home/Gallery/gallery.dart';
import 'package:skyline_university/Home/Gallery/gallery.dart' as prefix0;

import '../home.dart';


void main() => runApp(OneGallery());

class OneGallery extends StatefulWidget {
  final String oneGalleryTitle;

final List oneGalleryPhotos;

final String index;


  const OneGallery({Key key,this.oneGalleryTitle, this.oneGalleryPhotos, this.index}) : super(key: key);


  @override
  State<StatefulWidget> createState() {
    return _OneGalleryState();
  }
}






class _OneGalleryState extends State<OneGallery> {
  @override
  void initState() {
super.initState();
//print('Image Number'+widget.oneGalleryPhotos);
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
                  Expanded(
                    child: Text(
                      widget.oneGalleryTitle,
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
      body:
        GridView.builder(

            gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(
crossAxisSpacing: 15,
                crossAxisCount: 3
,
              mainAxisSpacing: 10

            ),
            padding:               const EdgeInsets.all(10.0),

            itemCount:widget.oneGalleryPhotos.length ,
            itemBuilder: (BuildContext context, int index) {
              return


            Container(

              decoration: BoxDecoration(
                  border: new Border.all(
                      color: Colors.black,
                      width: 2.0,
                      style: BorderStyle.solid
                  ),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black38,
                      blurRadius: 30,
                      offset: new Offset(5.0, 15.0),
                    )
                  ],       borderRadius: BorderRadius.all(
           Radius.circular(10.0),
       ),
       image:


       DecorationImage(

         fit: BoxFit.cover,
         colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.2), BlendMode.softLight),

           image:


           NetworkImage(widget.oneGalleryPhotos[index]),

       )
              ),
//              child: Image.network(
//                        widget.oneGalleryPhotos[index],fit: BoxFit.cover,filterQuality: FilterQuality.high,
//                      ),
            );




            }

            ),


      );


  }


}
