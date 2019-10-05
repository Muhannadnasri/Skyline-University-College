import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skyline_university/Home/Chat/chat.dart';
import 'package:skyline_university/Home/Events/events.dart';
import 'package:skyline_university/Home/Info/HomeInfo.dart';
import 'package:skyline_university/Home/Location/location.dart';
import 'package:skyline_university/Home/News/news.dart';
import 'package:skyline_university/Home/home.dart';

import 'Home/Admission/admissionForm.dart';
import 'Home/Admission/home.dart';
import 'Home/Apptitude/apptutudeForm.dart';
import 'Home/FAQ/faq.dart';
import 'Home/Gallery/gallery.dart';
import 'Home/Info/academicAdvisingAndMentoring.dart';
import 'Home/Info/board.dart';
import 'Home/Info/clubs.dart';
import 'Home/Info/committees.dart';
import 'Home/Info/council.dart';
import 'Home/Info/dean.dart';
import 'Home/Info/faculty.dart';
import 'Home/Info/founder.dart';
import 'Home/Info/glance.dart';
import 'Home/Info/goals.dart';
import 'Home/Info/info.dart';
import 'Home/Info/internationalStudents.dart';
import 'Home/Info/knowMoreAboutSkyline.dart';
import 'Home/Info/sportsDepartment.dart';
import 'Home/Info/studentEventCommittees.dart';
import 'Home/Info/studentLife.dart';
import 'Home/Info/studentServicesDepartment.dart';
import 'Home/Info/virtual.dart';
import 'Home/programs/ProfessionalCourses.dart';
import 'Home/programs/centreContinuingLearning.dart';
import 'Home/programs/englishLanguageCentre.dart';
import 'Home/programs/executiveDevelopmentProgram.dart';
import 'Home/programs/feeStructures.dart';
import 'Home/programs/homeGraduate.dart';
import 'Home/programs/homePrograms.dart';
import 'Home/programs/homeUndergraduate.dart';
import 'Home/programs/mastersQualifyingProgram.dart';
import 'Home/programs/professionalProgram.dart';
import 'Home/programs/scholarship.dart';
import 'Home/programs/undergraduateBusiness.dart';
import 'Home/programs/undergraduateIT.dart';
import 'Home/programs/undergraduateProgram.dart';
import 'Login/Circulars/circulars.dart';
import 'Login/ContactsList/contactList.dart';
import 'Login/E-Reques/airTicketRequest.dart';
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
import 'Login/E-Reques/updateInformation.dart';
import 'Login/Faculty/advisors.dart';
import 'Login/Faculty/classScheduleFAC.dart';
import 'Login/Faculty/courseAllocationEvening.dart';
import 'Login/Faculty/courseAllocationMorning.dart';
import 'Login/Faculty/courseAllocationWeekend.dart';
import 'Login/Student/Advisor/advisorAppointment.dart';
import 'Login/Student/Advisor/myAdvisor.dart';
import 'Login/Student/Assessment/assessmentMarkCourses.dart';
import 'Login/Student/Attendance/attendance.dart';
import 'Login/Student/Attendance/attendanceCalendar.dart';
import 'Login/Student/CDP/cdp.dart';
import 'Login/Student/CDP/cdpFaculty.dart';
import 'Login/Student/Classes/ClassHome.dart';
import 'Login/Student/Classes/classDetails.dart';
import 'Login/Student/Classes/classScheduleMqpWeekday.dart';
import 'Login/Student/Classes/classScheduleWeekday.dart';
import 'Login/Student/Classes/classScheduleWeekend.dart';
import 'Login/Student/Fees/admissionKit.dart';
import 'Login/Student/Fees/feesHome.dart';
import 'Login/Student/Fees/payOnline.dart';
import 'Login/Student/Results/finalGradeResult.dart';
import 'Login/Student/Results/gpaRequirments.dart';
import 'Login/Student/Results/midTermMarks.dart';
import 'Login/Student/Results/resultHome.dart';
import 'Login/Student/Results/studentGPAProfile.dart';
import 'Login/home.dart';
import 'Login/loginpage.dart';
import 'NotificationSection/announcements.dart';
import 'NotificationSection/notification.dart';

import 'package:firebase_messaging/firebase_messaging.dart';

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
    return MaterialApp(
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
        '/News': (context) => News(),
        '/HomeLogin': (context) => HomeLogin(),
        '/Events': (context) => Events(),
        '/Attendance': (context) => Attendance(),
        '/AssessmentMarkCourses': (context) => AssessmentMarkCourses(),
        '/MidTermMarks': (context) => MidTermMarks(),
        '/FinalTermResults': (context) => FinalTermResults(),
        '/HomeResult': (context) => HomeResult(),
        '/StudentGPAProfile': (context) => StudentGPAProfile(),
        '/CourseDetails': (context) => CourseDetails(),
        '/ClassScheduleWeekday': (context) => ClassScheduleWeekday(),
        '/ClassScheduleMqpWeekDay': (context) => ClassScheduleMqpWeekDay(),
        '/ClassScheduleWeekend': (context) => ClassScheduleWeekend(),
        '/MyAdvisor': (context) => MyAdvisor(),
        '/GetGPARequirments': (context) => GetGPARequirments(),
        '/AdvisorAppointment': (context) => AdvisorAppointment(),
        '/Circulars': (context) => Circulars(),
        '/HomeFees': (context) => HomeFees(),
        '/PayOnline': (context) => PayOnline(),
        '/AdmissionKit': (context) => AdmissionKit(),
        '/OnlineRequest': (context) => OnlineRequest(),
        '/HomeERequest': (context) => HomeERequest(),
        '/ChangeClassTime': (context) => ChangeClassTime(),
        '/ReinStatement': (context) => ReinStatement(),
        '/CourseWithdrawal': (context) => CourseWithdrawal(),
        '/UpdateInformation': (context) => UpdateInformation(),
        '/CDPDownload': (context) => CDPDownload(),
        '/LeaveApplication': (context) => LeaveApplication(),
        '/PassportWithdrawal': (context) => PassportWithdrawal(),
        '/ContactList': (context) => ContactList(),
        '/PassportRetaining': (context) => PassportRetaining(),
        '/SalaryCertificate': (context) => SalaryCertificate(),
        '/LeaveHoliday': (context) => LeaveHoliday(),
        '/BookRequisition': (context) => BookRequisition(),
        '/MembershipForm': (context) => MembershipForm(),
        '/AdmissionForm': (context) => AdmissionForm(),
        '/GeneralAppointment': (context) => GeneralAppointment(),
        '/CourseAllocation': (context) => CourseAllocation(),
        '/Faculty': (context) => Faculty(),
        '/HomeAdmission': (context) => HomeAdmission(),
        '/FAQ': (context) => FAQ(),
        '/AirTicketRequest': (context) => AirTicketRequest(),
        '/Gallery': (context) => Gallery(),
        '/Conference': (context) => Conference(),
        '/Advisors': (context) => Advisors(),
        '/HomeClass': (context) => HomeClass(),
        '/UndergraduateProgram': (context) => UndergraduateProgram(),
        '/virtual': (context) => Virtual(),
        '/attendanceCalendar': (context) => AttendanceCalendar(),
        '/homePrograms': (context) => HomePrograms(),
        '/undergraduateBusiness': (context) => UndergraduateBusiness(),
        '/undergraduateIT': (context) => UndergraduateIT(),
        '/homeUndergraduate': (context) => HomeUndergraduate(),
        '/leaveApplicationForm': (context) => LeaveApplicationForm(),
        '/info': (context) => Info(),
        '/professionalCourses': (context) => ProfessionalCourses(),
        '/glance': (context) => Glance(),
        '/goals': (context) => Goals(),
        '/board': (context) => Board(),
        '/founder': (context) => Founder(),
        '/council': (context) => Council(),
        '/dean': (context) => Dean(),
        '/committees': (context) => Committees(),
        '/homeGraduate': (context) => HomeGraduate(),
        '/professionalProgram': (context) => ProfessionalProgram(),
        '/centreContinuingLearning': (context) => CentreContinuingLearning(),
        '/executiveDevelopmentProgram': (context) =>
            ExecutiveDevelopmentProgram(),
        '/englishLanguageCentre': (context) => EnglishLanguageCentre(),
        '/mastersQualifyingProgram': (context) => MastersQualifyingProgram(),
        '/scholarship': (context) => Scholarship(),
        '/feeStructures': (context) => FeeStructures(),
        '/studentLife': (context) => StudentLife(),
        '/internationalStudents': (context) => InternationalStudents(),
        '/knowMoreAboutSkyline': (context) => KnowMoreAboutSkyline(),
        '/studentServicesDepartment': (context) => StudentServicesDepartment(),
        '/academicAdvisingAndMentoring': (context) =>
            AcademicAdvisingAndMentoring(),
        '/clubs': (context) => Clubs(),
        '/studentEventCommittees': (context) => StudentEventCommittees(),
        '/sportsDepartment': (context) => SportsDepartment(),
        '/courseAllocationMorning': (context) => CourseAllocationMorning(),
        '/courseAllocationEvening': (context) => CourseAllocationEvening(),
        '/courseAllocationWeekend': (context) => CourseAllocationWeekend(),
        '/apptutudeForm': (context) => ApptutudeForm(),
        '/announcements': (context) => Announcements(),
        '/notifications': (context) => Notifications(),
        '/cdpFaculty': (context) => CdpFaculty(),
      },
    );
  }
}
