import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Login/E-Reques/StudentForm/visitorInfo.dart';

void main() => runApp(VisitorInfoLan());

class VisitorInfoLan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VisitorInfoLanState();
  }
}

class _VisitorInfoLanState extends State<VisitorInfoLan> {
  bool languageAr = false;
  @override
  void initState() {
    super.initState();

    // getCurrentAndNewShift();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        resizeToAvoidBottomPadding: true,
        appBar: appBarLogin(
          context,
          'Visitor Information',
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Please Choose Your Language',
              style: TextStyle(
                  // letterSpacing: 1,
                  fontSize: 20,
                  color: isDark(context) ? Colors.white : Colors.black),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 9,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VisitorInfo(
                                languageAr: false,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          child: Icon(Icons.language,
                              size: 50,
                              color: isDark(context)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                      Text(
                        'English',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color:
                                isDark(context) ? Colors.white : Colors.black),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VisitorInfo(
                                languageAr: true,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          child: Icon(Icons.language,
                              size: 50,
                              color: isDark(context)
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      ),
                      Text(
                        'Arabic',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            color:
                                isDark(context) ? Colors.white : Colors.black),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 10,
            ),
          ],
        ));
  }
}
