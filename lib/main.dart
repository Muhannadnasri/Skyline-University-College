import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skyline_university/Home/Admission/admissionForm.dart';
import 'package:skyline_university/Home/Chat/chat.dart';
import 'package:skyline_university/Home/Events/events.dart';
import 'package:skyline_university/Home/Info/HomeInfo.dart';
import 'package:skyline_university/Home/News/news.dart';
import 'package:skyline_university/Home/home.dart';
import 'package:skyline_university/Home/Location/location.dart';

import 'Home/Admission/home.dart';
import 'Home/FAQ/faq.dart';
import 'Home/Gallery/gallery.dart';
import 'Home/Info/faculty.dart';
import 'Home/Info/staff.dart';
import 'Home/programs/program.dart';
import 'Home/programs/programBusiness.dart';
import 'Home/programs/programIT.dart';

import 'Login/Admin/admin.dart';
import 'Login/Admin/staffAccess.dart';
import 'Login/Admin/studentAccess.dart';
import 'Login/Circulars/circulars.dart';

import 'Login/ContactsList/contactList.dart';
import 'Login/E-Reques/airTicketRequest.dart';
import 'Login/E-Reques/bookrequistion.dart';
import 'Login/E-Reques/changeClassTime.dart';
import 'Login/E-Reques/conference.dart';
import 'Login/E-Reques/courseWithdrawal.dart';
import 'Login/E-Reques/generalAppointment.dart';
import 'Login/E-Reques/home.dart';
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

import 'Login/Student/ClassesHome.dart';
import 'Login/Student/admissionKit.dart';
import 'Login/Student/advisorAppointment.dart';
import 'Login/Student/assessmentMarkCourses.dart';
import 'Login/Student/attendance.dart';
import 'Login/Student/cdp.dart';
import 'Login/Student/classSchedule.dart';
import 'Login/Student/classScheduleMqpWeekday.dart';
import 'Login/Student/classScheduleWeekday.dart';
import 'Login/Student/classScheduleWeekend.dart';
import 'Login/Student/feesHome.dart';
import 'Login/Student/finalGradeResult.dart';
import 'Login/Student/gpaRequirments.dart';
import 'Login/Student/midTermMarks.dart';
import 'Login/Student/myAdvisor.dart';
import 'Login/Student/payOnline.dart';
import 'Login/Student/resultHome.dart';

import 'Login/Student/studentGPAProfile.dart';
import 'Login/home.dart';
import 'Login/loginpage.dart';

void main() async {
  SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(
    new MyApp(),
  );
}

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
        '/Staff': (context) => Staff(),
        '/AirTicketRequest': (context) => AirTicketRequest(),
        '/Gallery': (context) => Gallery(),
        '/Conference': (context) => Conference(),
        '/Advisors': (context) => Advisors(),
        '/GPA': (context) => GPA(),
        '/GPAS': (context) => GPAS(),
        '/GPASS': (context) => GPASS(),
        '/HomeClass': (context) => HomeClass(),
        '/Program': (context) => Program(),
        '/programBusiness': (context) => ProgramBusiness(),
        '/ProgramIT': (context) => ProgramIT(),
      },
    );
  }
}
