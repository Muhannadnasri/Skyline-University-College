import 'package:flutter/material.dart';
import 'package:superellipse_shape/superellipse_shape.dart';

import 'package:url_launcher/url_launcher.dart';

Map studentJson = {};

bool copyRight = false;

//API-Key
String API = '965a0109d2fde592b05b94588bcb43f5';
//Global String

String pFName = '';
String pMName = '';
String pLName = '';
String pBox = '';
String pTown = '';
String pState = '';
String pPost = '';
String pTel = '';
String pMobile = '';
String hBox = '';
String hTown = '';
String hState = '';
String hPost = '';
String hTel = '';
String hMobile = '';
String hEmail = '';
String q1School = '';
String q1Duration = '';
String q1Result = '';
String q2School = '';
String q2Duration = '';
String q2Result = '';
String q3School = '';
String q3Duration = '';
String q3Result = '';
String q4School = '';
String q4Duration = '';
String q4Result = '';
String year = '';
String overall = '';
String e1time = '';
String e1name = '';
String e1location = '';
String e1position = '';
String e2time = '';
String e2name = '';
String e2location = '';
String e2position = '';
String aName = '';
String from = '';
String contactNo = '';
String documentSubmitted = '';
String mobileNo = '';
String addressTo = '';
String reasonLeave = '';
String to = '';
String localName = '';
String localNumber = '';
String internationalName = '';
String internationalNumber = '';
String reasonPassport = '';
String dateReturn = '';
String nameForm = '';
String residential = '';
String homeForm = '';
String workForm = '';
String mobileForm = '';
String bTitle = '';
String bAuthor = '';
String bEdition = '';
String bPublisher = '';
String bYear = '';
String bIsbn = '';
String bQuantity = '';
String bPrice = '';
String remarkAppointment = '';
String email = '';
String mobileNumber = '';
String eid = '';
String passport = '';
String visa = '';
String pName = '';
String pEid = '';
String pMobileNumber = '';
String pEmail = '';
String pMobileTelephone = '';
String pWork = '';
String pDesignation = '';
String boxNumber = '';
String addressLeave = '';
String reasonTravel = '';
String eName = '';
String eEmail = '';
String eRelationship = '';
String placeFrom = '';
String placeTo = '';
String remarksAir = '';

String eMobile = '';
String eResidence = '';
String eOffice = '';
String eAddress = '';
String other = '';
String comapny = '';
String addressCertificate = '';
String cityCertificate = '';
String reasonPassportRetaining = '';

String username = '';

String documentry = '';

String reason = '';
String address = '';
String remark = '';
String remarkCourse = '';
String studentProblem = '';
String password = '';

//Global List and Map

List courseAllocationJson = [];
List courseAllocationWeekendJson = [];
List courseAllocationMorningJson = [];
List courseAllocationEveningJson = [];

List admissionFormDropdownCountriesJson;
List admissionFormDropdownProgramJson;
List admissionFormDropdownTermsJson;
List admissionFormDropdownQualificationJson;
List admissionFormDropdownIELTSJson;
Map appJson;
Map appEventsJson;

List programsByCategory2Json;
List programsByCategory1Json;
Map admissionForm;
List libraryMaterialJson;
List othersJson = [];
Map studentPersonalInfoJson;
Map courseNameJson = {};
List courseWithdrawalCoursesJson;

List locationJson = [];
List getDirectoryJson = [];
Map getFeeStructuresJson;
List faqByTypeJson = [];
Map faqByTypeMessageJson;

Map payOnlineJson;

List onlineListJson = [];


List advisorScheduleJson = [];

Map classScheduleCourseMessageJson = {};

Map marksIeltsJson;

// Admin
Map gpaJson = {};
List imageJson = [];
List finalJson = [];
List marksJson = [];
List staffPJson = [];
List studentPJson = [];
List finalxJson = [];
// 


String conference = '';
String conferenceName = '';


int selectStudent;
int selectStaff;

phoneCall() async {
  if (await canLaunch("tel:+97165441155")) {
    await launch("tel:+97165441155");
  } else {
    print('Could not Call');
  }
}

logOut(BuildContext context) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Yes"),
    onPressed: () {
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
    },
  );
  Widget continueButton = FlatButton(
    textColor: Colors.grey,
    child: Text("No"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  // set up the AlertDialog

  AlertDialog alert = AlertDialog(
    shape: SuperellipseShape(
      borderRadius: BorderRadius.all(
        Radius.circular(20),
      ),
    ),
    title: Image.asset(
      'images/logo.png',
      height: 50,
    ),
    content: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text("Are you sure you want to logout ?"),
    ),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void showLoading(isLoading, context) {
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

void showError(String msg, IconData icon, context, action) {
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
              padding: const EdgeInsets.only(left: 30.0),
              child: FittedBox(
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
            ),
            actions: <Widget>[
              new FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                  action();
                },
                child: new Text('Try again'),
              ),
            ],
          ),
        );
      });
}
