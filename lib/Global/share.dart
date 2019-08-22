import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

class FabShare extends StatefulWidget {
  final String url;

  const FabShare({Key key, this.url}) : super(key: key);

  @override
  _FabShareState createState() => _FabShareState();
}

class _FabShareState extends State<FabShare> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return 
    
    
    FloatingActionButton(
      backgroundColor: Color.fromARGB(255, 39, 93, 155),
      foregroundColor: Colors.white,
      heroTag: null,
      child: new AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, Widget child) {
          return GestureDetector(
            onTap: () {
              _shareImageFromUrl();
            },
            child: new Icon(Icons.share),
          );
        },
      ),
      onPressed: () {
        if (_controller.isDismissed) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      },
    );
  }

  void _showLoading(isLoading) {
    if (isLoading) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return WillPopScope(
              onWillPop: () {},
              child: new AlertDialog(
                title: Image.asset(
                  'images/logo.png',
                  height: 50,
                ),
                shape: SuperellipseShape(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                content: Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(right: 25.0),
                        child: new CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 12),
                        child: new Text('Please Wait....'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    } else {
      Navigator.pop(context);
    }
  }

  Future<void> _shareImageFromUrl() async {
    _showLoading(true);

    try {
      var request = await HttpClient().getUrl(Uri.parse(widget.url));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file(
          'Share Document', 'Document.pdf', bytes, 'application/pdf');
      Future.delayed(const Duration(seconds: 1), () {
        _showLoading(false);
      });
    } catch (e) {
      print('error: $e');
    }
  }
}
