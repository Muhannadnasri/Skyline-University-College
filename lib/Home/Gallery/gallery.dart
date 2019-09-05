import 'dart:convert';
import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:transparent_image/transparent_image.dart';

import 'oneGallery.dart';

void main() => runApp(Gallery());

class Gallery extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _GalleryState();
  }
}

List galleries = [];

File dataFile;

Map galleryJson = {};
Map<String, String> body;

class _GalleryState extends State<Gallery> {
  @override
  void initState() {
    super.initState();
    galleries.clear();
    getGallery();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: appBar(context, 'Gallery'),
      body: Container(
        color: Colors.grey[300],
        child: ListView.builder(
            itemCount: galleries.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OneGallery(
                        oneGalleryPhotos: galleries[index]['photos'],
                        oneGalleryTitle: galleries[index]['Event_Name'],
                      ),
                    ),
                  );
                },
                child: galleries[index]['photos'].isEmpty |
                        galleries[index]['Image_Number'].isEmpty |
                        galleries[index]['Event_Name'].isEmpty
                    ? SizedBox()
                    : Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
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
                                  image: galleries[index]['Back_Image'],
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
                                    color: Colors.black.withOpacity(0.7),
                                    height: 45,
                                    width: 400,
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Flexible(
                                          child: Text(
                                            galleries[index]['Event_Name'],
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 3,
                                        ),
                                        Text(
                                          galleries[index]['Image_Number'],
                                          style: TextStyle(color: Colors.white54),
                                        ),
                                      ],
                                    ),
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

  Future getGallery() async {
    new Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    body = {};
    try {
      http.Response response = await http.post(
          "http://www.muhannadnasri.com/App/gallery/data.json",
          body: body);

      if (response.statusCode == 200) {
        var Json = json.decode(response.body);
        Directory appDocDir = await getApplicationDocumentsDirectory();
        dataFile = new File(appDocDir.path + "/dataFile.json");

        if (dataFile.existsSync()) {
          if (Json['gallery'] != null) {
            dataFile.writeAsStringSync(response.body);
          }
        } else {
          dataFile.createSync();
          dataFile.writeAsStringSync(response.body);
        }

        if (Json['gallery'] != null) {
          galleryJson = Json;
        } else {
          galleryJson = json.decode(dataFile.readAsStringSync());
        }

        showLoading(false, context);

        setState(() {
          galleries = galleryJson["gallery"];
        });
      } else {}
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getGallery);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getGallery);
      }
    }
  }
}
