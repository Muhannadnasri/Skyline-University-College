import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:skyline_university/Home/Admission/admissionForm.dart';
import 'package:skyline_university/Home/Chat/chat.dart';
import 'package:skyline_university/Home/Events/events.dart';
import 'package:skyline_university/Home/Info/HomeInfo.dart';
import 'package:skyline_university/Home/News/news.dart';
import 'package:skyline_university/Home/home.dart';
import 'package:skyline_university/Home/Location/location.dart';

import 'Global/online.dart';
import 'Home/Admission/home.dart';
import 'Home/FAQ/faq.dart';
import 'Home/Gallery/gallery.dart';
import 'Home/Info/faculty.dart';
import 'Home/Info/staff.dart';
import 'Login/Assessment Marks/assessmentMarkCourses.dart';
import 'Login/Attendance/attendance.dart';
import 'Login/CDP Download/cdp.dart';
import 'Login/Circulars/circulars.dart';
import 'Login/Class Schedule/FAC/CourseAllocationEvening.dart';
import 'Login/Class Schedule/FAC/CourseAllocationMorning.dart';
import 'Login/Class Schedule/FAC/CourseAllocationWeekend.dart';
import 'Login/Class Schedule/FAC/classSchedule.dart';

import 'Login/Class Schedule/courseDetails.dart';
import 'Login/Class Schedule/classScheduleMqpWeekday.dart';
import 'Login/Class Schedule/classScheduleWeekday.dart';
import 'Login/Class Schedule/classScheduleWeekend.dart';
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
import 'Login/My Advisory/adisorAppointment.dart';
import 'Login/My Advisory/advisors.dart';
import 'Login/My Advisory/myAdvisor.dart';
import 'Login/My Fees/admissionKit.dart';
import 'Login/My Fees/home.dart';
import 'Login/My Fees/payOnline.dart';
import 'Login/Result/GPA.dart';
import 'Login/Result/GPASS.dart';
import 'Login/Result/GPAS.dart';
import 'Login/Result/GPASS.dart';
import 'Login/Result/finalGradeResult.dart';
import 'Login/Result/gpaRequirments.dart';
import 'Login/Result/home.dart';
import 'Login/Result/midTermMarks.dart';
import 'Login/Result/studentGPAProfile.dart';
import 'Login/contactList.dart';
import 'Login/home.dart';
import 'Login/loginpage.dart';


void main()  async {
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

    '/CourseEvening': (context) => CourseEvening(),
    '/CourseAllocationEvening': (context) => CourseAllocationEvening(),
    '/CourseAllocationWeekend': (context) => CourseAllocationWeekend(),

        '/Faculty': (context) => Faculty(),

        '/HomeAdmission': (context) => HomeAdmission(),
        '/FAQ': (context) => FAQ(),


        '/Staff': (context) => Staff(),
        '/AirTicketRequest': (context) => AirTicketRequest(),

        '/Gallery': (context) => Gallery(),
        '/Conference': (context) =>Conference(),
        '/online': (context) =>Online(),
        '/Advisors': (context) =>Advisors(),
        '/GPA': (context) =>GPA(),
                '/GPAS': (context) =>GPAS(),
                '/GPASS': (context) =>GPASS(),







      },
    );
  }
}
