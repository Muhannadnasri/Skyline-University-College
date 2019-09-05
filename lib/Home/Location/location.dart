import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBar.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:url_launcher/url_launcher.dart';

class Location extends StatefulWidget {
  @override
  _LocationState createState() => _LocationState();
}

List locationJson = [];

class _LocationState extends State<Location> {
  MapType _defaultMapType = MapType.normal;
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  final Set<Marker> _markers = Set();
  final double _zoom = 10;
  CameraPosition _initialPosition =
      CameraPosition(target: LatLng(25.3174292, 55.3705209));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Location'),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GoogleMap(
              markers: _markers,
              mapType: _defaultMapType,
              myLocationButtonEnabled: false,
              onMapCreated: _onMapCreated,
              initialCameraPosition: _initialPosition,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: locationJson.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          _goTo(index, locationJson[index]['name'],
                              locationJson[index]['address1']);
                        },
                        child: Container(
                          height: 30,
                          decoration: new BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(5)),
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
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: Center(
                                      child: Text(
                                        locationJson[index]['name'],
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        //  Container(

                        //   child: Text(locationJson[index]['name']),
                        // ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text(locationJson[index]['address1']),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          launch('mailto:' +
                              locationJson[index]['email'].toString());
                        },
                        child: Container(
                          child: Text(
                            locationJson[index]['email'],
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      GestureDetector(
                        onTap: () {
                          launch('tel:' +
                              locationJson[index]['phone1'].toString());
                          print(locationJson[index]['phone1'].toString());
                        },
                        child: Container(
                          child: Text(
                            locationJson[index]['phone1'],
                            style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: Colors.blue),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _goTo(index, title, snippet) async {
    double lat = locationJson[index]['latitude'];
    double long = locationJson[index]['longitude'];
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            onTap: () {
              // if (Platform.isIOS) {
              _openMap(lat, long);
              // } else
              // return null;
            },
            markerId: MarkerId('location'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(title: title, snippet: snippet)),
      );
    });
  }

  Future getLocation() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getLocations'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'usertype': '1',
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      );
      if (response.statusCode == 200) {
        setState(
          () {
            locationJson = json.decode(response.body)['data'];
          },
        );
        print(locationJson.toString());
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getLocation);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getLocation);
      }
    }
  }

  _openMap(double lat, double long) async {
    // Android
    var url = 'comgooglemaps://?q=$lat,$long';
    var urlAndroid = 'geo:$lat,$long';

    if (Platform.isAndroid) {
      if (await canLaunch(urlAndroid)) {
        await launch(urlAndroid);
      } else {
        throw 'Could not launch $urlAndroid';
      }
    }
    if (Platform.isIOS) {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
  }
}
