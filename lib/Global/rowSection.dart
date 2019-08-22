import 'package:flutter/material.dart';

Widget rowSection(BuildContext context, image, text, location) {
  return Column(
    children: <Widget>[
      FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, location
                    // "/GetGPARequirments"
                    );
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 8, right: 8.0),
                child: Container(
                  width: 380,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    border: Border.all(width: 1.0),
                    borderRadius: BorderRadius.all(
                        Radius.circular(10.0) //         <--- border radius here
                        ),
                  ),
                  child: Container(
                    width: 80,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(
                          width: 15,
                        ),
                        Image.asset(
                          // 'images/admission.png'
                          image,
                          height: 30,
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          // 'GPA Requirments'
                          text,
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 20,
      ),
    ],
  );
}
