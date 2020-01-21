import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;

import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

import 'global.dart';

class PdfView extends StatefulWidget {
  final String url;
  const PdfView({Key key, this.url}) : super(key: key);

  @override
  _PdfViewState createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> with TickerProviderStateMixin {
  AnimationController _controller;
  String path;
  bool _isLoading = true;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/teste.pdf');
  }

  Future<File> writeCounter(Uint8List stream) async {
    final file = await _localFile;

    // Write the file
    return file.writeAsBytes(stream);
  }

  Future<Uint8List> fetchPost() async {
    final response = await http.get(widget.url);
    final responseJson = response.bodyBytes;

    return responseJson;
  }

  loadPdf() async {
    writeCounter(await fetchPost());
    path = (await _localFile).path;

    if (!mounted) return;

    setState(() {
      if (path != null) {
        _isLoading = false;
      }
    });
  }

  void initState() {
    super.initState();
    loadPdf();
    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarLogin(context, 'PDF Viewer'),
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
      body: Center(
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
            : PdfViewer(
                onPdfViewerCreated: () {},
                filePath: path,
              ),
      ),
    );
  }

  Future<void> _shareImageFromUrl() async {
    showLoading(true, context);
    try {
      var request = await HttpClient().getUrl(Uri.parse(widget.url));
      var response = await request.close();
      Uint8List bytes = await consolidateHttpClientResponseBytes(response);
      await Share.file(
          'Share Document', 'Document.pdf', bytes, 'application/pdf');
      Future.delayed(const Duration(seconds: 1), () {
      showLoading(false, context);
      });
    } catch (e) {}
  }
}
