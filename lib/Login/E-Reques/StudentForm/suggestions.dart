import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/bottomAppBar.dart';
import 'package:skyline_university/Global/global.dart';

import 'dropList.dart';

void main() => runApp(Suggestions());

class Suggestions extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SuggestionsState();
  }
}

// Map<String, int> body;

class _SuggestionsState extends State<Suggestions> {
  var caseIDCnt = TextEditingController();
  var caseNameCnt = TextEditingController();
  final _suggestionsAppointmentForm = GlobalKey<FormState>();

  String remark = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: bottomappBar(
        context,
        () {
          setState(() {
            if (_suggestionsAppointmentForm.currentState.validate() &&
                caseIDCnt.text != '') {
              _suggestionsAppointmentForm.currentState.save();
              sendSuggestionsAppointment();
            }
          });
        },
      ),
      appBar: appBarLogin(context, 'Suggestions'),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: <Widget>[
                  requestCaseWidget(),
                  remarkAndAddressWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget requestCaseWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Case Category',
          style:
              TextStyle(color: isDark(context) ? Colors.white : Colors.black),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DropList(
                  type: 'suggestions',
                ),
              ),
            ).then((val) async {
              setState(() {
                // miscName = val['MiscName'];
                // miscID = val['MiscID'];
                caseNameCnt.text = val['CATEGORY_DESCRIPTION'];
                caseIDCnt.text = val['CATEGORY_ID'].toString();
              });
            });
          },
          child: AbsorbPointer(
            child: TextFormField(
              validator: (x) => x.isEmpty ? "Please select request type" : null,
              onChanged: (x) {
                setState(() {
                  // isEditing = true;
                });
              },
              controller: caseNameCnt,
            ),
          ),
        ),
        SizedBox(
          height: 25,
        ),
      ],
    );
  }

  Widget remarkAndAddressWidget() {
    return Form(
      key: _suggestionsAppointmentForm,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Remarks',
            style:
                TextStyle(color: isDark(context) ? Colors.white : Colors.black),
          ),
          TextFormField(
            validator: (x) => x.isEmpty ? "Please enter remark" : null,
            onChanged: (x) {
              setState(() {
                // isEditing = true;
              });
            },
            // initialValue: widget.sessionId == null
            //     ? ''
            //     : widget.sessionInfo['remarks'],
            onSaved: (x) {
              setState(() {
                remark = x;
              });
              // sessionRemarks = x;
            },
            keyboardType: TextInputType.text,
          ),
          SizedBox(
            height: 25,
          ),
        ],
      ),
    );
  }

  Future sendSuggestionsAppointment() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      final response = await http.post(
        Uri.parse(
            'https://skylineportal.com/moappad/api/test/generalAppointment'),
        headers: {
          "API-KEY": API,
        },
        body: {
          'Stud_ID': username,
          // username,
          'CASETYPE_ID': '2',
          'CATEGORY_ID': caseIDCnt.text.toString(),
          'StudentRemarks': remark.toString(),
        },
      );

      if (response.statusCode == 200) {
        showLoading(false, context);

        bottomSheetSuccess(context);
      } else {
        showLoading(false, context);

        bottomSheetFailure(context);
      }

      // showSuccessSnackBar(
      //     context, 'Your request has been successfully submitted');
      // if (response.statusCode == 200) {
      //   setState(
      //     () {
      //       generalRequestJson = json.decode(response.body);
      //     },
      //   );
      //   showLoading(false, context);
      //   if (generalRequestJson['success'] == '0') {
      //     showfailureSnackBar(context, generalRequestJson['message']);
      //   }
      //   if (generalRequestJson['success'] == '1') {
      //     showSuccessSnackBar(context, generalRequestJson['message']);
      //   }
      // }
    } catch (x) {
      print(x);
      if (x.toString().contains("TimeoutException")) {
        showLoading(false, context);

        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, sendSuggestionsAppointment);
      } else {
        showLoading(false, context);
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            sendSuggestionsAppointment);
      }
    }
  }
}
