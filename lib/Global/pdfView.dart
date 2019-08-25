import 'dart:io';
import 'dart:typed_data';

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

class PdfView extends StatefulWidget {
  final String url;

  const PdfView({Key key, this.url}) : super(key: key);

  @override
  _PdfViewState createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView>
    with TickerProviderStateMixin {
  AnimationController _controller;

  bool _isLoading = true;
  PDFDocument document;

  void initState() {
    super.initState();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    loadDocument();
  }

  loadDocument() async {
    document = await PDFDocument.fromURL(widget.url);
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarLogin(context, ''),
      floatingActionButton: FloatingActionButton(
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
      ),
      body: Stack(
        children: <Widget>[
          Center(
            child: _isLoading
                ? Center(
                    child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Text('Please wait'),
                      ),
                    ],
                  ))
                : PDFViewer(
                    document: document,
                    showIndicator: true,
                    indicatorBackground: Colors.blue,
                    showPicker: false,
                    tooltip: PDFViewerTooltip(),
                  ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              color: Colors.grey[50],
              height: 70,
            ),
          ),
        ],
      ),
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
