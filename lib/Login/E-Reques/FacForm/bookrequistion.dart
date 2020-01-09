import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/dropDownWidget.dart';
import 'package:skyline_university/Global/form.dart';
import 'package:skyline_university/Global/global.dart';

void main() => runApp(BookRequisition());

class BookRequisition extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BookRequisitionState();
  }
}

final _bookRequisition = GlobalKey<FormState>();

class _BookRequisitionState extends State<BookRequisition> {
  Map bookRequisitionJson = {};
  List libraryMaterialJson = [];

  String title = '';
  String author = '';
  String edition = '';
  String publisher = '';
  String year = '';
  String isbn = '';
  String quantity = '';
  String price = '';

  String type;

  @override
  void initState() {
    super.initState();
    getLibraryMaterial();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      bottomNavigationBar: bottomappBar(
        context,
        () {
          if (_bookRequisition.currentState.validate()) {
            _bookRequisition.currentState.save();
            getBookRequisition();
          }
        },
      ),
      appBar: appBarLogin(context, 'Book Requistion'),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: ListView(
          children: <Widget>[
            Container(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: 500,
                      height: 50,
                      alignment: Alignment.center,
                      decoration: new BoxDecoration(
                        boxShadow: [
                          new BoxShadow(
                              color: Colors.grey,
                              offset: new Offset(2.0, 2.0),
                              blurRadius: 20)
                        ],
                        gradient: isDark(context)
                            ? LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color(0xFF1F1F1F),
                                  Color(0xFF1F1F1F),
                                ],
                                stops: [
                                  0.7,
                                  0.9,
                                ],
                              )
                            : LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
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
                      child: Text(
                        studentJson['data']['name'].isEmpty
                            ? ''
                            : studentJson['data']['name'] == 'NA'
                                ? ''
                                : studentJson['data']['name'],
                        style: TextStyle(color: Colors.white),
//
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            height: 15,
                          ),
                          Form(
                            key: _bookRequisition,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                globalForms(
                                  context,
                                  '',
                                  (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Title is required';
                                    }
                                    return null;
                                  },
                                  (x) {
                                    setState(() {
                                      title = x;
                                    });
                                  },
                                  'Title',
                                  TextInputType.text,
                                ),
                                globalForms(
                                  context,
                                  '',
                                  (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Author name is required';
                                    }
                                    return null;
                                  },
                                  (x) {
                                    setState(() {
                                      author = x;
                                    });
                                  },
                                  'Author',
                                  TextInputType.text,
                                ),
                                globalForms(
                                  context,
                                  '',
                                  (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Edition is required';
                                    }
                                    return null;
                                  },
                                  (x) {
                                    setState(() {
                                      edition = x;
                                    });
                                  },
                                  'Edition',
                                  TextInputType.text,
                                ),
                                globalForms(
                                  context,
                                  '',
                                  (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Publisher name is required';
                                    }
                                    return null;
                                  },
                                  (x) {
                                    setState(() {
                                      publisher = x;
                                    });
                                  },
                                  'Publisher Name',
                                  TextInputType.text,
                                ),
                                globalForms(
                                  context,
                                  '',
                                  (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Year is required';
                                    }
                                    return null;
                                  },
                                  (x) {
                                    setState(() {
                                      year = x;
                                    });
                                  },
                                  'Year',
                                  TextInputType.number,
                                ),
                                globalForms(
                                  context,
                                  '',
                                  (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'ISBN is required';
                                    }
                                    return null;
                                  },
                                  (x) {
                                    setState(() {
                                      isbn = x;
                                    });
                                  },
                                  'ISBN Number',
                                  TextInputType.text,
                                ),
                                globalForms(
                                  context,
                                  '',
                                  (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Quantity is required';
                                    }
                                    return null;
                                  },
                                  (x) {
                                    setState(() {
                                      quantity = x;
                                    });
                                  },
                                  'Quantity',
                                  TextInputType.number,
                                ),
                                globalForms(
                                  context,
                                  '',
                                  (String value) {
                                    if (value.trim().isEmpty) {
                                      return 'Price is required';
                                    }
                                    return null;
                                  },
                                  (x) {
                                    setState(() {
                                      price = x;
                                    });
                                  },
                                  'Unit Price',
                                  TextInputType.number,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                dropDownWidget(
                                  context,
                                  'Select Type',
                                  type,
                                  libraryMaterialJson,
                                  'CatTypeName',
                                  'CatTypeName',
                                  (value) {
                                    setState(() {
                                      type = value;
                                    });
                                  },
                                  'Please Select Book Type',
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getLibraryMaterial() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/LibraryMaterial'),
        headers: {
          "API-KEY": API,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            libraryMaterialJson = json.decode(response.body)['data'];
          },
        );
        showLoading(false, context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        // showErrorServer(context, getLibraryMaterial());
      } else {
        showLoading(false, context);
        // showErrorConnect(context, getLibraryMaterial());
      }
    }
  }

  Future getBookRequisition() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/test/libraryBookRequisition'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'UserID': studentJson['data']['user_id'],
          'UserName': username,
          'Title': title,
          'Author': author,
          'Edition': edition,
          'Publisher': publisher,
          'Year': year,
          'IsbnNo': isbn,
          'Quantity': quantity,
          'UnitPrice': price,
          'TypeofMaterial': type,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            bookRequisitionJson = json.decode(response.body);
          },
        );
        showLoading(false, context);
      }

      showSuccessSnackBar(bookRequisitionJson['message'], context);
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getLibraryMaterial);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getLibraryMaterial);
      }
    }
  }
}
