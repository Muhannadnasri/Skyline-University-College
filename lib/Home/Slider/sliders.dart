import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


final List<String> imgList = [
  'https://skylineuniversity.ac.ae/images/Program/icd.jpg',
  'https://skylineuniversity.ac.ae/images/Program/international-trip.jpg'
];

void main() => runApp(new CarouselDemo());

final Widget placeholder = new Container(color: Colors.grey);

final List child = map<Widget>(
  imgList,
  (index, i) {
    return Container(

      margin: EdgeInsets.all(5.0),
      child: Container(
         decoration: BoxDecoration(borderRadius: BorderRadiusDirectional.all(Radius.circular(10)),image: DecorationImage(image: NetworkImage(i,),fit: BoxFit.fill),),

      ),
    );
  },
).toList();

List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}

class CarouselWithIndicator extends StatefulWidget {
  @override
  _CarouselWithIndicatorState createState() => _CarouselWithIndicatorState();
}

class _CarouselWithIndicatorState extends State<CarouselWithIndicator> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        pauseAutoPlayOnTouch: Duration(seconds: 5),
        items: child,
        autoPlay: true,
        autoPlayAnimationDuration: Duration(seconds: 5),
        aspectRatio: 2.0,
        height: 140,

        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: map<Widget>(
          imgList,
          (index, url) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4)),
            );
          },
        ),
      ),//TODO: Indicator
    ]);
  }
}

class CarouselDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//    final CarouselSlider autoPlayDemo = CarouselSlider(
//      viewportFraction: 0.9,
//      aspectRatio: 2.0,
//      autoPlay: true,
//      enlargeCenterPage: true,
//      items: imgList.map(
//
//        (url) {
//
//          return Container(
//            margin: EdgeInsets.all(5.0),
//            child: Image.network(
//              url,
//              fit: BoxFit.fitWidth,
//              width: 1000.0,
//            ),
//          );
//        },
//      ).toList(),
//    );

  }
}
