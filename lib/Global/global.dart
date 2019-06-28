

import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';






//CopyRight
bool copyRight = false;

String program =  studentJson['data']['program'];
String usertype = studentJson['data']['user_type'];
//Global String

String pFName ='';
String pMName ='';
String pLName ='';
String pBox ='';
String pTown ='';
String pState ='';
String pPost ='';
String pTel ='';
String pMobile ='';
String hBox ='';
String hTown ='';
String hState ='';
String hPost ='';
String hTel ='';
String hMobile ='';
String hEmail ='';
String q1School ='';
String q1Duration ='';
String q1Result ='';
String q2School ='';
String q2Duration ='';
String q2Result ='';
String q3School ='';
String q3Duration ='';
String q3Result ='';
String q4School ='';
String q4Duration ='';
String q4Result ='';
String year ='';
String overall ='';
String e1time ='';
String e1name ='';
String e1location ='';
String e1position ='';
String e2time ='';
String e2name ='';
String e2location ='';
String e2position ='';
String aName ='';
String from ='';
String contactNo ='';
String documentSubmitted ='';
String mobileNo ='';
String addressTo ='';
String reasonLeave ='';
String to ='';
String localName ='';
String localNumber ='';
String internationalName ='';
String internationalNumber ='';
String reasonPassport ='';
String  dateReturn='';
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
String remarkAppointment ='';
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
Map personalFamilyTimesMessageJson;

List personalFamilyTimesJson=[];

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

String semester = studentJson['data']['acadyear_desc'];
String name = studentJson['data']['name'];


String documentry = '';

String reason = '';
String address = '';
String remark = '';
String remarkCourse = '';
String studentProblem = '';
String password = '';
Map logOutJson;
//Global List and Map
List leaveTypesJson=[];
List cdpCourseJson=[];
Map cdpCourseMessageJson={};
List generalAPPtJson=[];
List generalApptDate =[];
List advisingScheduleJson=[];
List courseAllocationJson= [];
List courseAllocationWeekendJson=[];
List courseAllocationMorningJson =[];
List courseAllocationEveningJson =[];

List generalAPPtDepartmentJson = [];
List generalAPPtTimeJson = [];
List admissionFormDropdownCountriesJson;
List admissionFormDropdownProgramJson;
List admissionFormDropdownTermsJson;
List admissionFormDropdownQualificationJson;
List admissionFormDropdownIELTSJson;
Map appJson;
Map appEventsJson;

Map attendanceMessageJson;
List programsByCategory2Json;
List programsByCategory1Json;
Map admissionForm;
Map membershipFormJson;
List membershipRelationsJson;
List libraryMaterialJson;
Map bookRequisitionJson;
Map leaveHolidayJson;
Map passportWithdrawalJson;
Map leaveApplicationJson;
Map salaryCertificateJson;
List purposeJson=[];
List countryJson=[];
List othersJson=[];
Map studentPersonalInfoJson;
Map courseNameJson= {};
List courseWithdrawalCoursesJson;
Map reinStatementJson;
Map requestAmountJson = {};
List onlineRequestTypeJson=[] ;
Map onlineRequestTypeMessageJson;
Map onlineRequestJson;
List getLocationJson=[];
List getDirectoryJson=[];
Map getFeeStructuresJson;
Map courseWithdrawalJson;
List faqByTypeJson =[];
Map faqByTypeMessageJson;
Map currentTimeJson={};
Map policyChangeTimeJson;
Map changeClassTimingJson;
List currentAndNewShiftJson = [];
List circularsJson = [];
Map payOnlineJson;
List contactListJson=[];
List onlineListJson=[];
Map admissionKitJson;
Map invoicesJson;
Map passportRetainingJson;
Map underTakingJson;
List advisorScheduleJson = [];
Map myLedgerJson;
Map advisorNameJson;
Map studentJson={};
List personalFamilyPersonalJson;
List personalFamilyFamilyJson;
String conference = '';
String conferenceName='';
Map studentGPAProfileJson={};
List attendanceJson;
Map attendanceDetailsJsonMessage;
List attendanceDetailsJson = [];
Map assessmentMarkCoursesJsonMessage;
List assessmentMarkCoursesJson = [];
List assessmentMarksJson = [];
Map assessmentMarksJsonMessage;
List gpaRequirmentsJson = [];
List classScheduleCourseJson = [];
Map classScheduleCourseMessageJson ={};
List scheduleMqpWeekDayJson = [];
Map scheduleMqpWeekDayMessageJson={};
List classScheduleWeekendJson = [];
Map classScheduleWeekendMessageJson={};
List classScheduleWeekdayJson = [];
Map classScheduleWeekdayMessageJson={};
List finalTermResultsJson = [];
Map finalTermResultsMessageJson;
List finalTermMarksJson = [];
List midTermMarksJson = [];
Map midTermMarksMessageJson;
Map marksIeltsJson;
List myAdvisorJson = [];
List myAdvisorsJson=[];
Map gpaJson={};
List imageJson =[];
List finalJson =[];
List marksJson=[];
List staffPJson=[];
List studentPJson =[];
Map advisorAppointmentJson;
List advisorDateJson;
List advisorCaseJson;
List advisorApptTimeJson = [];
Map studentInfoJson;

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
    onPressed:  () {
      Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

    },
  );
  Widget continueButton = FlatButton(

    textColor: Colors.grey,
    child: Text("No"),
    onPressed:  () {

      Navigator.pop(context);
    },
  );
  // set up the AlertDialog


  AlertDialog alert = AlertDialog(

    title: Image.asset('images/logo.png',
      height: 50,
    ),
    content:


    Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text("Are you sure want to logout ?"),
    ),
    actions: [

      cancelButton,
      continueButton,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );


}




