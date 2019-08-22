import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/rowSection.dart';
import 'package:skyline_university/Global/zigzag.dart';

void main() => runApp(HomeFees());

class HomeFees extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeFeesState();
  }
}

class _HomeFeesState extends State<HomeFees> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Container(
        child: ListView(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                rowSection(context, 'images/admission.png', 'Pay Online',
                    "/PayOnline"),
                rowSection(context, 'images/admission.png', 'Admission Kit',
                    "/AdmissionKit"),
              ],
            ),
          ],
        ),
      ),
      appBar:
       PreferredSize(
        preferredSize: Size.fromHeight(250.0),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                ZigZag(
                  clipType: ClipType.waved,
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius:
                                              12.0, // has the effect of softening the shadow
                                          spreadRadius:
                                              3.0, // has the effect of extending the shadow
                                        )
                                      ],
                                    ),
                                    child: Image.asset(
                                      studentJson['data']['user_type'] == 'FAC'
                                          ? 'images/professor-male.png'
                                          : studentJson['data']['Gender'] == 'M'
                                              ? 'images/male.png'
                                              : studentJson['data']['Gender'] ==
                                                      'F'
                                                  ? 'images/female.png'
                                                  : 'images/professor-male.png',
                                      height: 25,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      studentJson['data']['name'].toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                              studentJson['data']['user_type'] == 'STF'
                                  ? SizedBox(
                                      height: 10,
                                    )
                                  : Row(
                                      children: <Widget>[
                                        Container(
                                          decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.white,
                                                blurRadius:
                                                    12.0, // has the effect of softening the shadow
                                                spreadRadius:
                                                    3.0, // has the effect of extending the shadow
                                              )
                                            ],
                                          ),
                                          child: Image.asset(
                                            'images/degree.png',
                                            height: 25,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            studentJson['data']['program']
                                                .toString(),
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                              Row(
                                children: <Widget>[
                                  Container(
                                    decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.white,
                                          blurRadius:
                                              12.0, // has the effect of softening the shadow
                                          spreadRadius:
                                              3.0, // has the effect of extending the shadow
                                        )
                                      ],
                                    ),
                                    child: Image.asset(
                                      'images/year.png',
                                      height: 25,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      studentJson['data']['acadyear_desc']
                                          .toString(),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    height: 250,
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
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 70.0, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  studentJson['photo'].toString() ==
                          "https:\/\/skylineportal.com\/sitgmioxg\/professor.png"
                      ? Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Container(
                            width: 110.0,
                            height: 110.0,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: AssetImage(
                                  'images/logosmall.png',
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container(
                          decoration: BoxDecoration(shape: BoxShape.circle),
                          child: Container(
                            width: 110.0,
                            height: 110.0,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue),
                              shape: BoxShape.circle,
                              color: Colors.white,
                              image: DecorationImage(
                                fit: BoxFit.fitHeight,
                                image: NetworkImage(
                                  studentJson['photo'].toString(),
                                ),
                              ),
                            ),
                          ),
                        ), //TODO: Image Profile
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.arrow_back_ios,
                          size: 15,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Back',
                          style: TextStyle(fontSize: 15, color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: GestureDetector(
                    onTap: () {
                      logOut(context);
                    },
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        Icon(
                          FontAwesomeIcons.powerOff,
                          color: Colors.red,
                          size: 17,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Logout',
                          style: TextStyle(fontSize: 17, color: Colors.red),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
