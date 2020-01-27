import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';

import 'Global/global.dart';
import 'Global/lists.dart';
import 'Home/Admission/admissionForm.dart';
import 'Home/Admission/home.dart';
import 'Home/Apptitude/apptutudeForm.dart';
import 'Home/Chat/chat.dart';
import 'Home/FAQ/faq.dart';
import 'Home/Gallery/gallery.dart';
import 'Home/Info/HomeInfo.dart';
import 'Home/Info/faculty.dart';
import 'Home/Info/info.dart';
import 'Home/Info/infoDetails.dart';
import 'Home/Info/studentLife.dart';
import 'Home/Info/virtual.dart';
import 'Home/Location/location.dart';
import 'Home/home.dart';
import 'Home/programs/ProfessionalCourses.dart';
import 'Home/programs/centreContinuingLearning.dart';
import 'Home/programs/englishLanguageCentre.dart';
import 'Home/programs/executiveDevelopmentProgram.dart';
import 'Home/programs/feeStructures.dart';
import 'Home/programs/homeGraduate.dart';
import 'Home/programs/homePrograms.dart';
import 'Home/programs/homeUndergraduate.dart';
import 'Home/programs/mastersQualifyingProgram.dart';
import 'Home/programs/scholarship.dart';
import 'Home/programs/undergraduateBusiness.dart';
import 'Home/programs/undergraduateIT.dart';
import 'Login/ClassHome.dart';
import 'Login/E-Reques/FacForm/bookrequistion.dart';
import 'Login/E-Reques/FacForm/conference.dart';
import 'Login/E-Reques/FacForm/leaveapplication.dart';
import 'Login/E-Reques/FacForm/permissionToLeave.dart';
import 'Login/E-Reques/FacForm/salaryCertificate.dart';
import 'Login/E-Reques/StudentForm/advisorAppointment.dart';
import 'Login/E-Reques/StudentForm/changeClassTime.dart';
import 'Login/E-Reques/StudentForm/complains.dart';
import 'Login/E-Reques/StudentForm/courseWithdrawal.dart';
import 'Login/E-Reques/StudentForm/generalAppointment.dart';
import 'Login/E-Reques/StudentForm/leaveApplicationForm.dart';
import 'Login/E-Reques/StudentForm/letterRequest.dart';
import 'Login/E-Reques/StudentForm/onlineRequest.dart';
import 'Login/E-Reques/StudentForm/passportRetaining.dart';
import 'Login/E-Reques/StudentForm/passportWithdrawal.dart';
import 'Login/E-Reques/StudentForm/reinstatment.dart';
import 'Login/E-Reques/StudentForm/suggestions.dart';
import 'Login/E-Reques/StudentForm/updateInformation.dart';
import 'Login/E-Reques/StudentForm/visitorInfoLan.dart';
import 'Login/E-Reques/home.dart';
import 'Login/E-Reques/homeAppointment.dart';
import 'Login/E-Reques/homeSuggestion.dart';
import 'Login/Results/finalGradeResult.dart';
import 'Login/Results/gpaRequirments.dart';
import 'Login/Results/midTermMarks.dart';
import 'Login/Results/resultHome.dart';
import 'Login/Results/studentGPAProfile.dart';
import 'Login/admissionKit.dart';
import 'Login/advisors.dart';
import 'Login/assessmentMarkCourses.dart';
import 'Login/attendance.dart';
import 'Login/cdp.dart';
import 'Login/cdpFaculty.dart';
import 'Login/circulars.dart';
import 'Login/classDetails.dart';
import 'Login/classSchedule.dart';
import 'Login/classScheduleFAC.dart';
import 'Login/contactList.dart';
import 'Login/courseAllocationEvening.dart';
import 'Login/courseAllocations.dart';
import 'Login/feesHome.dart';
import 'Login/home.dart';
import 'Login/loginpage.dart';
import 'Login/myAdvisor.dart';
import 'Login/notification.dart';
import 'Login/payOnline.dart';

void main() async {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(
    new MyApp(),
  );
}

// http://muhannadnasri.com/App/logUser.php
class MyApp extends StatefulWidget {
  @override
  MyAppState createState() {
    return new MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return OverlaySupport(
      child: MaterialApp(
        darkTheme: ThemeData(
          iconTheme: IconThemeData(color: Colors.black),
          scaffoldBackgroundColor: Color(0xFF000000),
          textTheme: TextTheme(
            body1: TextStyle(color: Colors.black),
          ),
          brightness: Brightness.dark,
        ),
        debugShowCheckedModeBanner: false,
        builder: (BuildContext context, Widget child) {
          return new Builder(
            builder: (BuildContext context) {
              return new MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: 1.0,
                ),
                child: child,
              );
            },
          );
        },
        initialRoute: '/',
        routes: {
          '/': (context) => Home(),
          '/LoginApp': (context) => LoginApp(),
          '/Location': (context) => Location(),
          '/HomeInfo': (context) => HomeInfo(),
          '/Chat': (context) => Chat(),
          '/HomeLogin': (context) => HomeLogin(),
          '/attendance': (context) => Attendance(),
          '/assessmentMarkCourses': (context) => AssessmentMarkCourses(),
          '/midTermMarks': (context) => MidTermMarks(),
          '/finalTermResults': (context) => FinalTermResults(),
          '/homeResult': (context) => HomeResult(),
          '/studentGPAProfile': (context) => StudentGPAProfile(),
          '/courseDetails': (context) => CourseDetails(),

          '/courseAllocationWeekend': (context) => CourseAllocations(
                data: courseAllocationWeekendJson,
              ),

          '/courseAllocationMorning': (context) => CourseAllocations(
                data: courseAllocationMorningJson,
              ),

          '/classScheduleWeekday': (context) => ClassSchedule(
                link: 'classScheduleWeekday',
                title: 'Class Schedule Weekday',
              ),
          '/classScheduleMqpWeekDay': (context) => ClassSchedule(
                link: 'classScheduleMQPWeekday',
                title: 'class Schedule MQP Weekday',
              ),
          '/classScheduleWeekend': (context) => ClassSchedule(
                link: 'classScheduleWeekend',
                title: 'class Schedule Weekend',
              ),
          '/myAdvisor': (context) => MyAdvisor(),
          '/getGPARequirments': (context) => GetGPARequirments(),
          '/advisorAppointment': (context) => AdvisorAppointment(),
          '/circulars': (context) => Circulars(),
          '/HomeFees': (context) => HomeFees(),

          '/PayOnline': (context) => PayOnline(),
          '/AdmissionKit': (context) => AdmissionKit(),

          '/letterRequest': (context) => LetterRequest(),

          '/onlineRequest': (context) => OnlineRequest(),
          '/HomeERequest': (context) => HomeERequest(),
          '/homeAppointment': (context) => HomeAppointment(),
          '/homeSuggestion': (context) => HomeSuggestion(),
          '/complains': (context) => Complains(),
          '/suggestions': (context) => Suggestions(),

          '/ChangeClassTime': (context) => ChangeClassTime(),
          '/reinStatement': (context) => ReinStatement(),
          '/courseWithdrawal': (context) => CourseWithdrawal(),

          '/UpdateInformation': (context) => UpdateInformation(),
          '/cdpDownload': (context) => CDPDownload(),
          '/leaveApplication': (context) => LeaveApplication(),
          '/passportWithdrawal': (context) => PassportWithdrawal(),
          '/ContactList': (context) => ContactList(),
          '/passportRetaining': (context) => PassportRetaining(),
          '/salaryCertificate': (context) => SalaryCertificate(),
          '/leaveHoliday': (context) => LeaveHoliday(),
          '/bookRequisition': (context) => BookRequisition(),
          // '/membershipForm': (context) => MembershipForm(),
          '/AdmissionForm': (context) => AdmissionForm(),
          '/generalAppointment': (context) => GeneralAppointment(),
          '/courseAllocation': (context) => CourseAllocation(),
          '/faculty': (context) => Faculty(),
          '/HomeAdmission': (context) => HomeAdmission(),
          '/FAQ': (context) => FAQ(),
          // '/AirTicketRequest': (context) => AirTicketRequest(),
          '/Gallery': (context) => Gallery(),
          '/conference': (context) => Conference(),
          '/advisors': (context) => Advisors(),
          '/HomeClass': (context) => HomeClass(),
          '/virtual': (context) => Virtual(),
          '/homePrograms': (context) => HomePrograms(),
          '/underGraduateBusiness': (context) => UndergraduateBusiness(),
          '/underGraduateIT': (context) => UndergraduateIT(),
          '/homeUndergraduate': (context) => HomeUndergraduate(),
          '/leaveApplicationForm': (context) => LeaveApplicationForm(),
          '/info': (context) => Info(),
          '/professionalCourses': (context) => ProfessionalCourses(),
          '/glance': (context) => InfoDetails(
                name: 'SUC Info',
              ),
          '/goals': (context) => InfoDetails(
                name: 'SUC Goals',
              ),
          '/board': (context) => InfoDetails(
                name: 'SUC Board',
              ),

          '/founder': (context) => InfoDetails(
                name: 'SUC Founder',
              ),
          '/council': (context) => InfoDetails(
                name: 'SUC Council',
              ),

          '/committees': (context) => InfoDetails(
                name: 'SUC Committees',
              ),
          '/dean': (context) => InfoDetails(
                name: 'SUC Dean',
              ),

          '/visitorInfoLan': (context) => VisitorInfoLan(),

          '/homeGraduate': (context) => HomeGraduate(),
          '/centreContinuingLearning': (context) => CentreContinuingLearning(),
          '/executiveDevelopmentProgram': (context) =>
              ExecutiveDevelopmentProgram(),
          '/englishLanguageCentre': (context) => EnglishLanguageCentre(),
          '/mastersQualifyingProgram': (context) => MastersQualifyingProgram(),
          '/scholarship': (context) => Scholarship(),
          '/feeStructures': (context) => FeeStructures(),
          '/studentLife': (context) => StudentLife(),

          '/internationalStudents': (context) => InfoDetails(
                name: 'International Students',
              ),

          '/knowMoreAboutSkyline': (context) => InfoDetails(
                name: 'Know More About Skyline',
              ),
          '/studentServicesDepartment': (context) => InfoDetails(
                name: 'Student Services Department',
              ),
          '/news': (context) => Lists(
                title: 'News',
                value: 'news',
              ),
          '/events': (context) => Lists(
                title: 'Events',
                value: 'events',
              ),

          '/academicAdvisingAndMentoring': (context) => InfoDetails(
                name: 'Academic Advising And Mentoring',
              ),

          '/clubs': (context) => InfoDetails(
                name: 'Clubs',
              ),
          '/studentEventCommittees': (context) => InfoDetails(
                name: 'Student Event Committees',
              ),
          '/sportsDepartment': (context) => InfoDetails(
                name: 'Sports Department',
              ),
          // '/courseAllocationMorning': (context) => CourseAllocationMorning(),
          '/courseAllocationEvening': (context) => CourseAllocationEvening(),
          // '/courseAllocationWeekend': (context) => CourseAllocationWeekend(),
          '/apptutudeForm': (context) => ApptutudeForm(),
          // '/announcements': (context) => Announcements(),
          '/notifications': (context) => Notifications(),
          '/cdpFaculty': (context) => CdpFaculty(),
        },
      ),
    );
  }
}
