// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';

// class PhotoSlider extends StatefulWidget {
//   List sliders = [];

//   PhotoSlider(this.sliders);

//   @override
//   _PhotoSliderState createState() => _PhotoSliderState();
// }

// class _PhotoSliderState extends State<PhotoSlider> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 140,
//       child: PageView.builder(
//         itemCount: widget.sliders.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Container(
//               child: CarouselSlider(
//                 options: ,
//                 aspectRatio: 3,

//                 items: <Widget>[
//                   // CachedNetworkImage(
//                   //   fadeOutDuration: new Duration(seconds: 1),
//                   //   fadeInDuration: new Duration(seconds: 1),
//                   //   fit: BoxFit.cover,
//                   //   imageUrl: widget.sliders[index]['image'],
//                   // ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
