import 'package:flutter/material.dart';
import 'package:skyline_university/Global/appBarLogin.dart';
import 'package:skyline_university/Global/exception.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/Global/pdfView.dart';
import 'package:skyline_university/Global/webView.dart';

void main() => runApp(AdmissionKit());

class AdmissionKit extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AdmissionKitState();
  }
}

class _AdmissionKitState extends State<AdmissionKit> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    // getInvoices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarLogin(context, 'Admission Kit'),
      body: Container(
        child: Row(
          children: <Widget>[
            Column(
              children: <Widget>[
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    elevation: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text("Download Your Ledger Fees",
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0, top: 5),
                          child: InkWell(
                            child: Text(
                              'Download',
                              style: TextStyle(color: Colors.blue),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebViews(
                                      url:
                                          'sky.skylineuniversity.ac.ae/page/PrintLMS.aspx?Id=$username&Type=LEDGER&Code=BEC'

                                      //  myLedgerJson['data']

                                      ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    elevation: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text("Download Your Admission Kit",
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0, top: 5),
                          child: InkWell(
                            child: Text(
                              'Download',
                              style: TextStyle(color: Colors.blue),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebViews(
                                      url:
                                          'http://sky.skylineuniversity.ac.ae/page/PrintKit.aspx?Id=$username&degcode=BEC'),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    elevation: 10,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text("Download Your Invoice",
                              style: TextStyle(
                                  color: isDark(context)
                                      ? Colors.white
                                      : Colors.black)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 15.0, top: 5),
                          child: InkWell(
                            child: Text(
                              'Download',
                              style: TextStyle(color: Colors.blue),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PdfViews(
                                      url:
                                          'http://sky.skylineuniversity.ac.ae/page/PrintLMS.aspx?Id=$username&Type=INVOICE&Code=BEC'),
                                ),
                              );
                            },
                          ),
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
