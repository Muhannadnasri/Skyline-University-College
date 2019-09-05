import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:photo_view/photo_view.dart';

import 'package:skyline_university/Global/appBar.dart';

void main() => runApp(OneGallery());

class OneGallery extends StatefulWidget {
  final String oneGalleryTitle;

  final List oneGalleryPhotos;

  final String index;

  const OneGallery(
      {Key key, this.oneGalleryTitle, this.oneGalleryPhotos, this.index})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _OneGalleryState();
  }
}

class _OneGalleryState extends State<OneGallery> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: appBar(context, widget.oneGalleryTitle),
      body: GridView.builder(
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 15, crossAxisCount: 3, mainAxisSpacing: 10),
          padding: const EdgeInsets.all(10.0),
          itemCount: widget.oneGalleryPhotos.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhotoView(
                      maxScale: PhotoViewComputedScale.covered * 1,
                      minScale: PhotoViewComputedScale.contained * 1,
                      imageProvider: NetworkImage(
                        widget.oneGalleryPhotos[index],
                      ),
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: new Border.all(
                      color: Colors.black54,
                      width: 2.0,
                      style: BorderStyle.solid),
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black38,
                      blurRadius: 15,
                      offset: new Offset(5.0, 10.0),
                    )
                  ],
                  borderRadius: BorderRadius.all(
                    Radius.circular(5.0),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.2), BlendMode.softLight),
                    image: NetworkImage(widget.oneGalleryPhotos[index]),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
