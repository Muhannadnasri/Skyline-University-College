import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:skyline_university/Home/Chat/chat.dart';
import 'package:skyline_university/Home/Info/HomeInfo.dart';
import 'package:skyline_university/Home/Location/location.dart';
import 'package:skyline_university/Home/home.dart';

import 'Global/global.dart';
import 'Global/lists.dart';
import 'Home/Admission/admissionForm.dart';
import 'Home/Admission/home.dart';
import 'Home/Apptitude/apptutudeForm.dart';
import 'Home/FAQ/faq.dart';
import 'Home/Gallery/gallery.dart';
import 'Home/Info/info.dart';
import 'Home/Info/studentLife.dart';
import 'Home/Info/virtual.dart';
import 'Home/programs/ProfessionalCourses.dart';
import 'Home/programs/homePrograms.dart';
import 'Home/programs/homeUndergraduate.dart';
import 'Login/Circulars/circulars.dart';
import 'Login/ContactsList/contactList.dart';
import 'Login/ContactsList/internet.dart';
import 'Login/E-Reques/bookrequistion.dart';
import 'Login/E-Reques/changeClassTime.dart';
import 'Login/E-Reques/conference.dart';
import 'Login/E-Reques/courseWithdrawal.dart';
import 'Login/E-Reques/generalAppointment.dart';
import 'Login/E-Reques/home.dart';
import 'Login/E-Reques/leaveApplicationForm.dart';
import 'Login/E-Reques/leaveapplication.dart';
import 'Login/E-Reques/membershipForm.dart';
import 'Login/E-Reques/onlineRequest.dart';
import 'Login/E-Reques/passportRetaining.dart';
import 'Login/E-Reques/passportWithdrawal.dart';
import 'Login/E-Reques/permissionToLeave.dart';
import 'Login/E-Reques/reinstatment.dart';
import 'Login/E-Reques/salaryCertificate.dart';
import 'Login/Faculty/CourseAllocations.dart';
import 'Login/Faculty/advisors.dart';
import 'Login/Faculty/classScheduleFAC.dart';
import 'Login/Faculty/courseAllocationEvening.dart';
import 'Login/Student/Advisor/advisorAppointment.dart';
import 'Login/Student/Advisor/myAdvisor.dart';
import 'Login/Student/Assessment/assessmentMarkCourses.dart';
import 'Login/Student/Attendance/attendance.dart';
import 'Login/Student/CDP/cdp.dart';
import 'Login/Student/CDP/cdpFaculty.dart';
import 'Login/Student/Classes/ClassHome.dart';
import 'Login/Student/Classes/classDetails.dart';
import 'Login/Student/Classes/classSchedule.dart';
import 'Login/Student/Fees/feesHome.dart';
import 'Login/Student/Results/finalGradeResult.dart';
import 'Login/Student/Results/gpaRequirments.dart';
import 'Login/Student/Results/midTermMarks.dart';
import 'Login/Student/Results/resultHome.dart';
import 'Login/Student/Results/studentGPAProfile.dart';
import 'Login/home.dart';
import 'Login/loginpage.dart';
import 'NotificationSection/notification.dart';

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
          //TODO: Payonline Like Smart campus Dubia app
          // {
          // // '/PayOnline': (context) => PayOnline(),
          // // '/AdmissionKit': (context) => AdmissionKit(),
          // }
          '/onlineRequest': (context) => OnlineRequest(),
          '/HomeERequest': (context) => HomeERequest(),
          '/ChangeClassTime': (context) => ChangeClassTime(),
          '/reinStatement': (context) => ReinStatement(),
          '/courseWithdrawal': (context) => CourseWithdrawal(),
          // '/UpdateInformation': (context) => UpdateInformation(),
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
          // '/Faculty': (context) => Faculty(),
          '/HomeAdmission': (context) => HomeAdmission(),
          '/FAQ': (context) => FAQ(),
          // '/AirTicketRequest': (context) => AirTicketRequest(),
          '/Gallery': (context) => Gallery(),
          '/conference': (context) => Conference(),
          '/advisors': (context) => Advisors(),
          '/HomeClass': (context) => HomeClass(),
          // '/UndergraduateProgram': (context) => UndergraduateProgram(),
          '/virtual': (context) => Virtual(),
          // '/attendanceCalendar': (context) => AttendanceCalendar(),
          '/homePrograms': (context) => HomePrograms(),
          // '/undergraduateBusiness': (context) => UndergraduateBusiness(),
          // '/undergraduateIT': (context) => UndergraduateIT(),
          '/homeUndergraduate': (context) => HomeUndergraduate(),
          '/leaveApplicationForm': (context) => LeaveApplicationForm(),
          '/info': (context) => Info(),
          '/professionalCourses': (context) => ProfessionalCourses(),

          // '/glance': (context) => Glance(),
          // '/goals': (context) => Goals(),
          // '/board': (context) => Board(),
          // '/founder': (context) => Founder(),
          // '/council': (context) => Council(),
          // '/dean': (context) => Dean(),
          // '/committees': (context) => Committees(),
          // '/homeGraduate': (context) => HomeGraduate(),
          // '/professionalProgram': (context) => ProfessionalProgram(),
          // '/centreContinuingLearning': (context) => CentreContinuingLearning(),
          // '/executiveDevelopmentProgram': (context) =>
          //     ExecutiveDevelopmentProgram(),
          // '/englishLanguageCentre': (context) => EnglishLanguageCentre(),
          // '/mastersQualifyingProgram': (context) => MastersQualifyingProgram(),
          // '/scholarship': (context) => Scholarship(),
          // '/feeStructures': (context) => FeeStructures(),
          '/studentLife': (context) => StudentLife(),
          // '/internationalStudents': (context) => InternationalStudents(),
          // '/knowMoreAboutSkyline': (context) => KnowMoreAboutSkyline(),
          // '/studentServicesDepartment': (context) =>
          //     StudentServicesDepartment(),
          '/news': (context) => Lists(
                title: 'News',
                value: 'news',
              ),
          '/events': (context) => Lists(
                title: 'Events',
                value: 'events',
              ),
          // '/academicAdvisingAndMentoring': (context) =>
          //     AcademicAdvisingAndMentoring(),
          // '/clubs': (context) => Clubs(),
          // '/studentEventCommittees': (context) => StudentEventCommittees(),
          // '/sportsDepartment': (context) => SportsDepartment(),
          // '/courseAllocationMorning': (context) => CourseAllocationMorning(),
          '/courseAllocationEvening': (context) => CourseAllocationEvening(),
          // '/courseAllocationWeekend': (context) => CourseAllocationWeekend(),
          '/apptutudeForm': (context) => ApptutudeForm(),
          // '/announcements': (context) => Announcements(),
          '/notifications': (context) => Notifications(),
          '/cdpFaculty': (context) => CdpFaculty(),
          // '/': (context) => Internet(),
          //internet
        },
      ),
    );
  }
}
