import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:new_gradient_app_bar/new_gradient_app_bar.dart';
import 'package:quick_actions/quick_actions.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/homeBox.dart';
import 'package:skyline_university/widgets/feedBack/quiz_screen.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Global/homeBoxRow.dart';
import '../Login/loginpage.dart';
import '../widgets/auto_complete_navigation.dart';

import '../widgets/global_function.dart';
import '../widgets/global_widget.dart';
import '../widgets/product_model.dart';

void main() => runApp(Home());

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

Map<String, String> body;

List slidersJson = [];
final _scaffoldKey = GlobalKey<ScaffoldState>();
final QuickActions quickActions = QuickActions();

class _HomeState extends State<Home> {
  int _exit = 0;

//   final Firestore _db = Firestore.instance;

  String formattedDate = DateFormat('yyyy-MM-dd hh:mm').format(DateTime.now());
  String shortcut = "no action set";
  final _globalWidget = GlobalWidget();
  final _globalFunction = GlobalFunction();
  List<ProductModel> _getSuggestions(String query) {
    List<ProductModel> matches = [];
    matches.addAll(productData);
    matches.retainWhere(
        (data) => data.name.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  void initState() {
    super.initState();
    _setupQuickActions();
    _handleQuickActions();
    getLogs();
    getSliders();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _setupQuickActions() {
    quickActions.setShortcutItems(<ShortcutItem>[
      ShortcutItem(
          type: 'attendance',
          localizedTitle: 'Attendance',
          icon: Platform.isAndroid ? 'attendance' : 'attendance'),
      ShortcutItem(
          type: 'assessment',
          localizedTitle: 'Assessment',
          icon: Platform.isAndroid ? 'assessment' : 'assessment'), //
      ShortcutItem(
          type: 'class_schedul',
          localizedTitle: 'Class Schedule',
          icon: Platform.isAndroid ? 'class_schedul' : 'class_schedul')
    ]);
  }

  void _handleQuickActions() {
    quickActions.initialize((shortcutType) {
      switch (shortcutType) {
        case 'attendance':
          print('attendance');
          break;
        case 'assessment':
          print('assessment');

          break;
        case 'class_schedul':
          setState(() {
            Navigator.pushNamed(context, '/LoginApp');
          });
          print('class_schedul');

          break;
      }
    });
  }
  // void _setupQuickActions() {
  //   quickActions.initialize((String shortcutType) {
  //     setState(() {
  //       if (shortcutType != null) shortcut = shortcutType;
  //     });
  //   });

  //   quickActions.setShortcutItems(<ShortcutItem>[
  //     // NOTE: This first action icon will only work on iOS.
  //     // In a real world project keep the same file name for both platforms.
  //     const ShortcutItem(
  //       type: 'attendance',
  //       localizedTitle: 'Attendance',
  //       icon: 'AppIcon',
  //     ),

  //     // NOTE: This second action icon will only work on Android.
  //     // In a real world project keep the same file name for both platforms.
  //     const ShortcutItem(
  //         type: 'action_two',
  //         localizedTitle: 'Action two',
  //         icon: 'ic_launcher'),
  //   ]);
  // }

  // void _handleQuickActions() {
  //   quickActions.initialize((shortcutType) {
  //     if (shortcutType == 'attendance') {
  //       if (loggedin) {
  //         Navigator.push(
  //             context, MaterialPageRoute(builder: (context) => Attendance()));
  //       } else {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => LoginApp(
  //               page: 'attendance',
  //             ),
  //           ),
  //         );
  //       }
  //     } else if (shortcutType == 'action_two') {
  //       print('Show the help dialog!');
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: () {
            setState(() {
              // Get.to(QuizScreen()
              // QuizScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizScreen(),
                ),
              );
            });
          }),
          key: _scaffoldKey,

          body: CustomScrollView(
            shrinkWrap: true,
            slivers: <Widget>[
              SliverAppBar(
                expandedHeight: MediaQuery.of(context).size.height / 7,

                flexibleSpace: Container(
                  decoration: BoxDecoration(
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
                  child: FlexibleSpaceBar(
                    background: Column(
                      children: <Widget>[
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 8),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(10.0, 6.0, 10.0, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.white,
                            ),
                            height: 40.0,
                            width: double.infinity,
                            child: TypeAheadField(
                              textFieldConfiguration: TextFieldConfiguration(
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(

                                    // borderRadius: BorderRadius.circular(8.0),
                                    //     color: Color(0xffF0F1F5),
                                    border: InputBorder.none,
                                    //  OutlineInputBorder(
                                    //     // borderRadius: BorderRadius.circular(20.0),
                                    //     ),
                                    prefixIcon: Icon(Icons.search),
                                    // prefix: Padding(
                                    //   padding: const EdgeInsets.fromLTRB(
                                    //       9.0, 6.0, 9.0, 6.0),
                                    //   child: Icon(
                                    //     Icons.search,
                                    //     color: Colors.red,
                                    //   ),
                                    // ),
                                    hintStyle: TextStyle(color: Colors.black),
                                    contentPadding: const EdgeInsets.all(8.0),
                                    hintText: 'Search Here ...'),
                              ),
                              suggestionsCallback: (pattern) {
                                return _getSuggestions(pattern);
                              },
                              // getImmediateSuggestions: false,
                              suggestionsBoxDecoration:
                                  SuggestionsBoxDecoration(
                                      borderRadius: BorderRadius.circular(20.0),
                                      shadowColor: Colors.black,
                                      elevation: 10.0),
                              transitionBuilder: (context, suggestionsBox,
                                      animationController) =>
                                  FadeTransition(
                                child: suggestionsBox,
                                opacity: CurvedAnimation(
                                    parent: animationController,
                                    curve: Curves.fastOutSlowIn),
                              ),
                              itemBuilder: (context, ProductModel suggestion) {
                                return ListTile(
                                  // leading: ClipRRect(
                                  //   borderRadius:
                                  //       BorderRadius.all(Radius.circular(4)),
                                  //   // child: buildCacheNetworkImage(
                                  //   //     width: boxImageSize,
                                  //   //     height: boxImageSize,
                                  //   //     url: suggestion.image),
                                  // ),
                                  title: Text(suggestion.name),
                                  // subtitle: Text('\$ ' +
                                  //     _globalFunction.removeDecimalZeroFormat(
                                  //         suggestion.price)),
                                );
                              },

                              onSuggestionSelected: (suggestion) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginApp(
                                        destination:
                                            suggestion.location.toString()),
                                  ),
                                );
                                // print(suggestion);
                              },
                            ),
                            // CupertinoTextField(
                            //   keyboardType: TextInputType.text,
                            //   placeholder: 'Search Here...',
                            //   placeholderStyle: TextStyle(
                            //     color: Color(0xffC4C6CC),
                            //     fontSize: 14.0,
                            //   ),
                            //   prefix: Padding(
                            //     padding:
                            //         const EdgeInsets.fromLTRB(9.0, 6.0, 9.0, 6.0),
                            //     child: Icon(
                            //       Icons.search,
                            //       color: Color(0xffC4C6CC),
                            //     ),
                            //   ),
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(8.0),
                            //     color: Color(0xffF0F1F5),
                            //   ),
                            // ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // leading: Icon(Icons.person),
                // automaticallyImplyLeading: false,

                pinned: true,
                titleSpacing: 5,

                title: Container(
                  // width: double.infinity,
                  child: Container(
                    height: 150,
                    width: 230,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.scaleDown,
                        image: AssetImage(
                          'images/skyline_white.png',
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SliverFillRemaining(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.only(top: 0),
                        children: <Widget>[
                          CarouselSlider.builder(
                            itemCount: slidersJson.length,
                            // Give the controller
                            options: CarouselOptions(
                                aspectRatio: 2.0, autoPlay: true),
                            itemBuilder: (BuildContext context, int index,
                                int pageViewIndex) {
                              return slidersJson.isEmpty
                                  ? Center(
                                      // decoration: BoxDecoration(
                                      //     borderRadius:
                                      //         BorderRadius.circular(20),
                                      //     image: DecorationImage(
                                      //       image: AssetImage(
                                      //           'images/launcher3.png'),
                                      //       fit: BoxFit.contain,
                                      //     )),

                                      child: CircularProgressIndicator(
                                        color: Color(0xFF3773AC),
                                      ),

                                      // margin: EdgeInsets.symmetric(
                                      //     horizontal: 5, vertical: 15),
                                      // child: Image.network(imgUrls[index],
                                      //     fit: BoxFit.cover, width: 1000),
                                    )
                                  : GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _launchURL(
                                              slidersJson[index]['link']);
                                        });
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  slidersJson[index]['image']
                                                      .toString()),
                                              fit: BoxFit.cover,
                                            )),

                                        // child:

                                        margin: EdgeInsets.symmetric(
                                            horizontal: 5, vertical: 15),
                                        // child: Image.network(imgUrls[index],
                                        //     fit: BoxFit.cover, width: 1000),
                                      ),
                                    );
                            },
                          ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // Padding(
                          //   padding: const EdgeInsets.all(8.0),
                          //   child: Container(
                          //     child: Text(
                          //       'Student Services',
                          //       style: TextStyle(
                          //         fontSize: 17,
                          //         fontWeight: FontWeight.bold,
                          //         color:
                          //             isDark(context) ? Colors.white : Colors.black,
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // SingleChildScrollView(
                          //     scrollDirection: Axis.horizontal,
                          //     child: Row(children: [
                          //       SizedBox(
                          //         width: 10,
                          //       ),
                          //       homeBoxRow(
                          //         context,
                          //         'images-white/admission.png',
                          //         'images/admission.png',
                          //         "/HomeAdmission",
                          //         'Admission',
                          //       ),
                          //       homeBoxRow(
                          //         context,
                          //         'images-white/admission.png',
                          //         'images/admission.png',
                          //         "/HomeAdmission",
                          //         'Admission',
                          //       ),
                          //       homeBoxRow(
                          //         context,
                          //         'images-white/admission.png',
                          //         'images/admission.png',
                          //         "/HomeAdmission",
                          //         'Admission',
                          //       ),
                          //       homeBoxRow(
                          //         context,
                          //         'images-white/admission.png',
                          //         'images/admission.png',
                          //         "/HomeAdmission",
                          //         'Admission',
                          //       ),
                          //       homeBoxRow(
                          //         context,
                          //         'images-white/admission.png',
                          //         'images/admission.png',
                          //         "/HomeAdmission",
                          //         'Admission',
                          //       ),
                          //       homeBoxRow(
                          //         context,
                          //         'images-white/admission.png',
                          //         'images/admission.png',
                          //         "/HomeAdmission",
                          //         'Admission',
                          //       ),
                          //       homeBoxRow(
                          //         context,
                          //         'images-white/admission.png',
                          //         'images/admission.png',
                          //         "/HomeAdmission",
                          //         'Admission',
                          //       ),
                          //       homeBoxRow(
                          //         context,
                          //         'images-white/admission.png',
                          //         'images/admission.png',
                          //         "/HomeAdmission",
                          //         'Admission',
                          //       ),
                          //       SizedBox(
                          //         width: 10,
                          //       ),
                          //     ])),
                          // SizedBox(
                          //   height: 10,
                          // ),
                          // Divider(
                          //   color: Colors.grey,
                          //   // indent: 15,
                          //   height: 15,
                          //   // endIndent: 15,
                          //   thickness: 2,
                          // ),
                          FittedBox(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      homeBox(
                                        context,
                                        'images-white/admission.png',
                                        'images/admission.png',
                                        "/HomeAdmission",
                                        'Admission',
                                      ),
                                      homeBox(
                                        context,
                                        'images-white/programs.png',
                                        'images/programs.png',
                                        "/homePrograms",
                                        'Programs',
                                      ),
                                      homeBox(
                                        context,
                                        'images-white/news.png',
                                        'images/news.png',
                                        "/news",
                                        'News',
                                      ),
                                    ],
                                  ),
                                ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      homeBox(
                                        context,
                                        'images-white/location.png',
                                        'images/location.png',
                                        "/Location",
                                        'Location',
                                      ),
                                      homeBox(
                                        context,
                                        'images-white/info.png',
                                        'images/info.png',
                                        "/HomeInfo",
                                        'SUC Info',
                                      ),
                                      homeBox(
                                        context,
                                        'images-white/login.png',
                                        'images/login.png',
                                        "/LoginPage",
                                        'SUC Login',
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      homeBox(
                                        context,
                                        'images-white/events.png',
                                        'images/events.png',
                                        "/events",
                                        'Events',
                                      ),
                                      homeBox(
                                        context,
                                        'images-white/FAQ.png',
                                        'images/FAQ.png',
                                        "/FAQ",
                                        'FAQ ?',
                                      ),
                                      homeBox(
                                        context,
                                        'images-white/gallery.png',
                                        'images/gallery.png',
                                        "/Gallery",
                                        'Gallery',
                                      ),
                                    ],
                                  ),
                                ),
                                // Row(
                                //   children: <Widget>[
                                //     homeBox(
                                //       context,
                                //       'images-white/aptitude.png',
                                //       'images/aptitude.png',
                                //       "/apptutudeForm",
                                //       Colors.white,
                                //       Colors.black,
                                //       'Apptitude Test',
                                //       Colors.white,
                                //       Colors.black,
                                //     ),
                                //     homeBox(
                                //       context,
                                //       'images-white/aptitude.png',
                                //       'images/visitor.png',
                                //       "/VisitorInfo",
                                //       Colors.white,
                                //       Colors.black,
                                //       'Visitor Info',
                                //       Colors.white,
                                //       Colors.black,
                                //     ),
                                //     // homeBox(
                                //     //   context,
                                //     //   'images-white/fees.png',
                                //     //   'images/fees.png',
                                //     //   "/loginFees",
                                //     //   Colors.white,
                                //     //   Colors.black,
                                //     //   'Pay Fees',
                                //     //   Colors.white,
                                //     //   Colors.black,
                                //     // ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // appBar: NewGradientAppBar(
          //   // centerTitle: true,
          //   title: Container(
          //     // height: 170,
          //     // width: 180,
          //     decoration: BoxDecoration(
          //       image: DecorationImage(
          //         fit: BoxFit.scaleDown,
          //         image: AssetImage(
          //           'images/launcher3.png',
          //         ),
          //       ),
          //     ),
          //   ),
          //   leading: Icon(Icons.person),

          //   centerTitle: false,
          //   gradient: isDark(context)
          //       ? LinearGradient(
          //           begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter,
          //           colors: [
          //             Color(0xFF1F1F1F),
          //             Color(0xFF1F1F1F),
          //           ],
          //           stops: [
          //             0.7,
          //             0.9,
          //           ],
          //         )
          //       : LinearGradient(
          //           begin: Alignment.topCenter,
          //           end: Alignment.bottomCenter,
          //           colors: [
          //             Color(0xFF104C90),
          //             Color(0xFF3773AC),
          //           ],
          //           stops: [
          //             0.7,
          //             0.9,
          //           ],
          //         ),
          // ),
        ),
      ),
      onWillPop: () => _exitApp(context),
    );
  }

  Future getLogs() async {
    try {
      final response = await http.post(
        Uri.parse('http://muhannadnasri.com/App/logUser.php'),
        body: {
          'date': formattedDate,
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          if (response.body == 'True') {
            newVersion = true;
            showVersionDialog(context);
          }
        });
      }
    } catch (x) {}
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (_exit == 1) return true;

    _exit = 1;
    new Timer(Duration(seconds: 5), () {
      _exit = 0;
    });
    final snackBar = SnackBar(content: Text('Press back again for exit'));
    _scaffoldKey.currentState.showSnackBar(snackBar);
    return false;
  }

  Future getSliders() async {
    try {
      http.Response response = await http.post(
          Uri.parse("http://muhannadnasri.com/App/slider/data.json"),
          body: body);

      if (response.statusCode == 200) {
        slidersJson = json.decode(response.body)["slider"];
      }
    } catch (x) {}
  }
}

class MyImageView extends StatelessWidget {
  String imgPath;

  MyImageView(this.imgPath);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: FittedBox(
          fit: BoxFit.fill,
          child: Image.asset(
            imgPath,
          ),
        ));
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
