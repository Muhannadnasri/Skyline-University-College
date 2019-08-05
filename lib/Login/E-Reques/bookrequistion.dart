import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/zigzag.dart';
import 'package:skyline_university/Home/home.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

void main() => runApp(BookRequisition());

class BookRequisition extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BookRequisitionState();
  }
}

final _title = GlobalKey<FormState>();
final _author = GlobalKey<FormState>();
final _edition = GlobalKey<FormState>();
final _publisher = GlobalKey<FormState>();
final _year = GlobalKey<FormState>();
final _isbn = GlobalKey<FormState>();
final _quantity = GlobalKey<FormState>();
final _price = GlobalKey<FormState>();

// Map<String, int> body;

class _BookRequisitionState extends State<BookRequisition> {
  Map bookRequisitionJson={};

  String _type;

  @override
  void initState() {
    super.initState();
    getLibraryMaterial();
    bookRequisitionJson={};
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: PreferredSize(

        preferredSize: Size.fromHeight(70.0),
        child:


        Stack(

          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  height: 70,
                  decoration: new BoxDecoration(
                    gradient: LinearGradient(
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

                ), 


              ],
            ),


            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[


                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);

                    },
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(

                        children: <Widget>[

                          Icon(Icons.arrow_back_ios,size: 15,color: Colors.white,),
                          SizedBox(width: 5,),
                          Text('Back',style: TextStyle(fontSize: 15,color: Colors.white),),
                        ],
                      ),
                    ),
                  ),
                  Text("Book Requistion",style: TextStyle(color: Colors.white),),

                  GestureDetector(
                    onTap: () {
                     logOut(context);},

                     child: GestureDetector(
                      onTap: (){
                        logOut(context);

                      },
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Row(
                          children: <Widget>[

                            Icon(FontAwesomeIcons.powerOff,color: Colors.red,size: 15,),
                            SizedBox(width: 5,),
                            Text('Logout',style: TextStyle(fontSize: 15,color: Colors.red),),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],),
            ),
            //TODO: Put all Icon Container
          ],
        ),
      ),
      body: ListView(

        children: <Widget>[
          GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    alignment: Alignment.center,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 450,
                          height: 60,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10))),
                            elevation: 10,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  studentJson['data']['name'],
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: _title,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                            TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    bTitle = x;
                                  },
                                  decoration:

                                  InputDecoration(
                                    labelText: "Title",
                                    fillColor: Colors.white,

                                    helperStyle: TextStyle(fontSize: 13),
                                    hintText: 'Please enter title book you want',hintStyle: TextStyle(fontSize: 15),
                                    isDense: true,
                                    prefixIcon: Icon(FontAwesomeIcons.heading,size: 15,color: Colors.purple,),
                                  ),
                                ),

                            ],
                          ),
                        ),
                      
                        SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: _author,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                            TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    bAuthor = x;
                                  },
                                  decoration:

                                InputDecoration(
                                  labelText: "Author",
                                  fillColor: Colors.white,

                                  helperStyle: TextStyle(fontSize: 13),
                                  hintText: 'Please enter author book you want',hintStyle: TextStyle(fontSize: 15),
                                  isDense: true,
                                  prefixIcon: Icon(FontAwesomeIcons.at,size: 15,color: Colors.purple,),
                                ),
                                ),

                            ],
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: _edition,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[

                          TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    bEdition = x;
                                  },
                            decoration:

                            InputDecoration(
                              labelText: "Edition",
                              fillColor: Colors.white,

                              helperStyle: TextStyle(fontSize: 13),
                              hintText: 'Please enter edition book you want',hintStyle: TextStyle(fontSize: 15),
                              isDense: true,
                              prefixIcon: Icon(FontAwesomeIcons.iCursor,size: 15,color: Colors.purple,),
                            ),
                                ),

                            ],
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: _publisher,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                             TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    bPublisher = x;
                                  },
                               decoration:

                               InputDecoration(
                                 labelText: "Publisher",
                                 fillColor: Colors.white,

                                 helperStyle: TextStyle(fontSize: 13),
                                 hintText: 'Please enter publisher book you want',hintStyle: TextStyle(fontSize: 15),
                                 isDense: true,
                                 prefixIcon: Icon(FontAwesomeIcons.userTie,size: 15,color: Colors.purple,),
                               ),
                                ),

                            ],
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: _year,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    bYear = x;
                                  },
                                decoration:

                                InputDecoration(
                                  labelText: "Year",
                                  fillColor: Colors.white,

                                  helperStyle: TextStyle(fontSize: 13),
                                  hintText: 'Please enter year book you want',hintStyle: TextStyle(fontSize: 15),
                                  isDense: true,
                                  prefixIcon: Icon(FontAwesomeIcons.calendarAlt,size: 15,color: Colors.purple,),
                                ),
                                ),

                            ],
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: _isbn,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    bIsbn = x;
                                  },
                                decoration:

                                InputDecoration(
                                  labelText: "ISBN No",
                                  fillColor: Colors.white,

                                  helperStyle: TextStyle(fontSize: 13),
                                  hintText: 'Please enter ISBN No book you want',hintStyle: TextStyle(fontSize: 15),
                                  isDense: true,
                                  prefixIcon: Icon(FontAwesomeIcons.barcode,size: 15,color: Colors.purple,),
                                ),
                                ),

                            ],
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: _quantity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                             TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    bQuantity = x;
                                  },
                               decoration:

                               InputDecoration(
                                 labelText: "Quantity",
                                 fillColor: Colors.white,

                                 helperStyle: TextStyle(fontSize: 13),
                                 hintText: 'Please enter quantity you want',hintStyle: TextStyle(fontSize: 15),
                                 isDense: true,
                                 prefixIcon: Icon(FontAwesomeIcons.cartPlus,size: 15,color: Colors.purple,),
                               ),
                                ),

                            ],
                          ),
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Form(
                          key: _price,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              TextFormField(
                                  textCapitalization: TextCapitalization.words,
                                  maxLines: null,
                                  onSaved: (x) {
                                    bPrice = x;
                                  },
                                  decoration:

                                InputDecoration(
                                  labelText: "Price",
                                  fillColor: Colors.white,

                                  helperStyle: TextStyle(fontSize: 13),
                                  hintText: 'Please enter price you aspect',hintStyle: TextStyle(fontSize: 15),
                                  isDense: true,
                                  prefixIcon: Icon(FontAwesomeIcons.moneyCheck,size: 15,color: Colors.purple,),
                                ),
                                ),
                              
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(

                      alignment: Alignment.centerLeft,
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Please Select Book Type',style: TextStyle(color: Colors.grey[500]),),
                  )),
                  SizedBox(
                    height: 5,
                  ),

                  Column(
                    children: <Widget>[
                      DropdownButton<String>(
                        value: _type,
                        hint: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Select Type',style: TextStyle(color:Colors.black),),
                        ),
                        isExpanded: true,
                        items: libraryMaterialJson
                                ?.map(
                                  (item) => DropdownMenuItem<String>(
                                        value: item['CatTypeName'].toString(),
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(item['CatTypeName']),
                                            ),
                                          ],
                                        ),
                                      ),
                                )
                                ?.toList() ??
                            [],
                        onChanged: (value) {
                          setState(() {
                            _type = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 15,),
                  Container(
                      height: 35,
                      width: 80,
                      decoration: new BoxDecoration(
                        gradient: LinearGradient(
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
                      child: GestureDetector(
                          onTap: () {
                            getBookRequisition();
                          },
                          child: Center(
                              child: Text(
                                'Submit',
                                style: TextStyle(color: Colors.white),
                              ))))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

 

  void _showError(String msg, IconData icon) {
    showLoading(false,context);
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {},
            child: new AlertDialog(
              title: Image.asset('images/logo.png',
                height: 50,
              ),
              shape: SuperellipseShape(
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.only(left: 30.0),
                child: new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: new Icon(icon),
                    ),
                    new Text(msg)
                  ],
                ),
              ),
              actions: <Widget>[
                new FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    getLibraryMaterial();
                  },
                  child: new Text('Try again'),
                ),
              ],
            ),
          );
        });
  }



  Future getLibraryMaterial() async {
    Future.delayed(Duration.zero, () {
      showLoading(true,context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/getLibraryMaterial'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'usertype':studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            libraryMaterialJson = json.decode(response.body)['data'];
          },
        );
        showLoading(false,context);
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false,context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,context,getLibraryMaterial);
      } else {
          showLoading(false,context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi,context,getLibraryMaterial);
      }
    }
  }

  Future getBookRequisition() async {
    if (_title.currentState.validate()) {
      _title.currentState.save();
    }
    if (_author.currentState.validate()) {
      _author.currentState.save();
    }
    if (_edition.currentState.validate()) {
      _edition.currentState.save();
    }
    if (_publisher.currentState.validate()) {
      _publisher.currentState.save();
    }
    if (_year.currentState.validate()) {
      _year.currentState.save();
    }
    if (_isbn.currentState.validate()) {
      _isbn.currentState.save();
    }
    if (_quantity.currentState.validate()) {
      _quantity.currentState.save();
    }
    if (_price.currentState.validate()) {
      _price.currentState.save();
    }
    Future.delayed(Duration.zero, () {
      showLoading(true,context);
    });

    try {
      final response = await http.post(
        Uri.encodeFull(
            'https://skylineportal.com/moappad/api/web/libraryBookRequisition'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'user_id': username,
          'username': studentJson['data']['login'],
          'title': bTitle,
          'author': bAuthor,
          'edition': bEdition,
          'publisher': bPublisher,
          'year': bYear,
          'isbn_no': bIsbn,
          'quantity': bQuantity,
          'price': bPrice,
          'type_of_material': _type,
          'usertype':studentJson['data']['user_type'],
          'ipaddress': '1',
          'deviceid': '1',
          'devicename': '1',
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(
          () {
            bookRequisitionJson = json.decode(response.body);
          },
        );
        showLoading(false,context);
      }
      if ( bookRequisitionJson['success'] == '0'){
        showLoading(false,context);
        Fluttertoast.showToast(
            msg: bookRequisitionJson['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIos: 1,
            backgroundColor: Colors.grey[400],
            textColor: Colors.black87,
            fontSize: 13.0
        );
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showLoading(false,context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,context,getLibraryMaterial);
      } else {
          showLoading(false,context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi,context,getLibraryMaterial);
      }
    }
  }
}
