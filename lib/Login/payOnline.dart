import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_pay/flutter_pay.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Login/payCard.dart';

void main() => runApp(PayOnline());

class PayOnline extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _PayOnlineState();
  }
}

// Map<String, int> body;

class _PayOnlineState extends State<PayOnline> {
  final flutterWebviewPlugin = new FlutterWebviewPlugin();
  TextEditingController programNameCnt = new TextEditingController();
  TextEditingController studentNameCnt = new TextEditingController();
  TextEditingController userIdCnt = new TextEditingController();
  TextEditingController outstandingNameCnt = new TextEditingController();
  final payOnline = GlobalKey<FormState>();

  bool isLoading = true;
  Map payOnlineJson = {};
  int optionValue;
  double balance;
  // FlutterPay flutterPay = FlutterPay();

  // void makePayment() async {
  //   List<PaymentItem> items = [
  //     PaymentItem(name: 'Tution Fees', price: balance)
  //   ];

  //   flutterPay.setEnvironment(environment: PaymentEnvironment.Production);

  //   flutterPay.makePayment(
  //     merchantIdentifier: 'merchant.com.skylineuniversity.skyline',
  //     gatewayName: '',
  //     merchantName: '',
  //     currencyCode: "AED",
  //     countryCode: "AE",
  //     paymentItems: items,
  //   );
  // }

  void initState() {
    super.initState();
    programNameCnt.text = studentJson['data']['program'];
    studentNameCnt.text = studentJson['data']['name'];
    userIdCnt.text = studentJson['data']['user_id'];
    getPayOnline();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              //  Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              //   children: [
              //   Expanded(
              // flex: 1,
              // child:
              GestureDetector(
            onTap: () {
              if (payOnline.currentState.validate()) {
                setState(() {
                  payOnline.currentState.save();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PayCard(
                        reamount: '',
                        amount: balance.toString(),
                        studentId: userIdCnt.text.toString(),
                        requestId: '',
                      ),
                    ),
                  );
                });
              } else {}
            },
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10)),
              elevation: 3,
              shadowColor: Colors.black,
              color: isDark(context) ? Color(0xFF121212) : Color(0xFF275d9b),
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Text(
                  "Card",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ),
          // ),
          // SizedBox(
          //   width: 20,
        ),
        // Platform.isIOS
        //     ? Expanded(
        //         flex: 1,
        //         child: GestureDetector(
        //           onTap: () {
        //             makePayment();
        //           },
        //           child: Material(
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: new BorderRadius.circular(10)),
        //             elevation: 3,
        //             shadowColor: Colors.black,
        //             color: Color(0xFF121212),
        //             child: Padding(
        //               padding: const EdgeInsets.all(13.0),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Icon(
        //                     FontAwesomeIcons.apple,
        //                     color: Colors.white,
        //                   ),
        //                   SizedBox(
        //                     width: 8.0,
        //                   ),
        //                   Text(
        //                     "Apple Pay",
        //                     textAlign: TextAlign.center,
        //                     style: TextStyle(
        //                         color: Colors.white, fontSize: 20),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //       )
        //     : Expanded(
        //         flex: 1,
        //         child: GestureDetector(
        //           onTap: () {
        //             makePayment();
        //           },
        //           child: Material(
        //             shape: RoundedRectangleBorder(
        //                 borderRadius: new BorderRadius.circular(10)),
        //             elevation: 3,
        //             shadowColor: Colors.black,
        //             color: Color(0xFF121212),
        //             child: Padding(
        //               padding: const EdgeInsets.all(13.0),
        //               child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Icon(
        //                     FontAwesomeIcons.apple,
        //                     color: Colors.white,
        //                   ),
        //                   SizedBox(
        //                     width: 8.0,
        //                   ),
        //                   Text(
        //                     "Google Pay",
        //                     textAlign: TextAlign.center,
        //                     style: TextStyle(
        //                         color: Colors.white, fontSize: 20),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
      ),
      appBar: appBarLogin(context, 'Online Payment'),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: ListView(
          children: [
            Form(
              key: payOnline,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    readOnly: true,
                    enabled: false,
                    controller: userIdCnt,
                    style: TextStyle(
                        color: isDark(context)
                            ? Color(0xFF979ca4)
                            : Color(0xFF757575)),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(30, 8, 12, 10),
                      enabled: false,
                      labelText: 'Student ID',
                      labelStyle: TextStyle(
                          color: isDark(context)
                              ? Color(0xFFe5e7ea)
                              : Color(0xFF41444A)),
                      filled: true,
                      fillColor: isDark(context)
                          ? Color(0xFF41444A)
                          : Color(0xFFe5e7ea),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    readOnly: true,
                    enabled: false,
                    controller: studentNameCnt,
                    style: TextStyle(
                        color: isDark(context)
                            ? Color(0xFF979ca4)
                            : Color(0xFF757575)),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(30, 8, 12, 10),
                      enabled: false,
                      labelText: 'Student Name',
                      labelStyle: TextStyle(
                          color: isDark(context)
                              ? Color(0xFFe5e7ea)
                              : Color(0xFF41444A)),
                      filled: true,
                      fillColor: isDark(context)
                          ? Color(0xFF41444A)
                          : Color(0xFFe5e7ea),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    readOnly: true,
                    enabled: false,
                    controller: programNameCnt,
                    onSaved: (x) {
                      setState(() {
                        // remark = x;
                      });
                      // sessionRemarks = x;
                    },
                    style: TextStyle(
                        color: isDark(context)
                            ? Color(0xFF979ca4)
                            : Color(0xFF757575)),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(30, 8, 12, 10),
                      enabled: false,
                      labelText: 'Program',
                      labelStyle: TextStyle(
                          color: isDark(context)
                              ? Color(0xFFe5e7ea)
                              : Color(0xFF41444A)),
                      filled: true,
                      fillColor: isDark(context)
                          ? Color(0xFF41444A)
                          : Color(0xFFe5e7ea),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    controller: outstandingNameCnt,
                    readOnly: true,
                    enabled: false,

                    // initialValue: payOnlineJson['Bal'].toString(),
                    style: TextStyle(
                        color: isDark(context)
                            ? Color(0xFF979ca4)
                            : Color(0xFF757575)),
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(30, 8, 12, 10),
                      enabled: false,
                      labelText: 'Outstanding Balance (AED):',
                      labelStyle: TextStyle(
                          color: isDark(context)
                              ? Color(0xFFe5e7ea)
                              : Color(0xFF41444A)),
                      filled: true,
                      fillColor: isDark(context)
                          ? Color(0xFF41444A)
                          : Color(0xFFe5e7ea),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                    keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                    validator: (x) =>
                        x.isEmpty ? "Please enter correct balance" : null,
                    style: TextStyle(
                        color: isDark(context)
                            ? Color(0xFF979ca4)
                            : Color(0xFF757575)),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^(\d+(\.\d{0,4})?)$')),
                    ],
                    onSaved: (value) => balance = double.parse(value),
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: EdgeInsets.fromLTRB(30, 8, 12, 10),
                      labelText: 'Balance',
                      labelStyle: TextStyle(
                          color: isDark(context)
                              ? Color(0xFFe5e7ea)
                              : Color(0xFF41444A)),
                      filled: true,
                      fillColor: isDark(context)
                          ? Color(0xFF41444A)
                          : Color(0xFFe5e7ea),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future getPayOnline() async {
    Future.delayed(Duration.zero, () {
      showLoading(true, context);
    });

    try {
      http.Response response = await http.post(
        Uri.parse(
            "https://skylineportal.com/moappad/api/test/getPaymentBalacnce"),
        headers: {
          "API-KEY": API,
        },
        body: {
          'Stud_ID': username,
        },
      ).timeout(Duration(seconds: 35));

      if (response.statusCode == 200) {
        setState(() {
          payOnlineJson = json.decode(response.body)['data'];
          outstandingNameCnt.text = payOnlineJson['Bal'].toString();

          // isLoading = false;
        });
        showLoading(false, context);
        if (payOnlineJson['success'] == '0') {
          showfailureSnackBar(context, payOnlineJson['message']);
        }
      }
    } catch (x) {
      if (x.toString().contains("TimeoutException")) {
        showError("Time out from server", FontAwesomeIcons.hourglassHalf,
            context, getPayOnline);
      } else {
        showError("Sorry, we can't connect", Icons.perm_scan_wifi, context,
            getPayOnline);
      }
    }
  }
}
