import 'dart:async';
import 'dart:convert';

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
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  final Set<Marker> _markers = Set();
  final double _zoom = 10;
  CameraPosition _initialPosition =
      CameraPosition(target: LatLng(25.3174292, 55.3705209));
  MapType _defaultMapType = MapType.normal;
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Location'),
      // drawer: _drawer(),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GoogleMap(
              markers: _markers,
              mapType: _defaultMapType,
              myLocationEnabled: true,
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
                          child: Text(locationJson[index]['name']),
                        ),
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
            markerId: MarkerId('london'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(title: title, snippet: snippet)),
      );
    });
  }

  // Future<void> _goToTokyo() async {
  //   double lat = 35.6795;
  //   double long = 139.77171;
  //   final GoogleMapController controller = await _controller.future;
  //   controller
  //       .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
  //   setState(() {
  //     _markers.clear();
  //     _markers.add(
  //       Marker(
  //           markerId: MarkerId('tokyo'),
  //           position: LatLng(lat, long),
  //           infoWindow:
  //               InfoWindow(title: 'Tokyo', snippet: 'Welcome to Tokyo')),
  //     );
  //   });
  // }

  // Future<void> _goToDubai() async {
  //   double lat = 25.2048;
  //   double long = 55.2708;
  //   final GoogleMapController controller = await _controller.future;
  //   controller
  //       .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
  //   setState(() {
  //     _markers.clear();
  //     _markers.add(
  //       Marker(
  //           markerId: MarkerId('dubai'),
  //           position: LatLng(lat, long),
  //           infoWindow:
  //               InfoWindow(title: 'Dubai', snippet: 'Welcome to Dubai')),
  //     );
  //   });
  // }

  // Future<void> _goToParis() async {
  //   double lat = 48.8566;
  //   double long = 2.3522;
  //   final GoogleMapController controller = await _controller.future;
  //   controller
  //       .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
  //   setState(() {
  //     _markers.clear();
  //     _markers.add(
  //       Marker(
  //           markerId: MarkerId('paris'),
  //           position: LatLng(lat, long),
  //           infoWindow:
  //               InfoWindow(title: 'Paris', snippet: 'Welcome to Paris')),
  //     );
  //   });
  // }

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
}
