import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PhotoSlider extends StatelessWidget {
  List sliders = [];

  PhotoSlider(this.sliders);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: PageView.builder(
        itemCount: sliders.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: CarouselSlider(
              items: <Widget>[
                Image.network(
                  sliders[index]['image'],
                  fit: BoxFit.contain,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
