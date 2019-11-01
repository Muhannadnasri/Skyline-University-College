import 'package:flutter/material.dart';

import 'global.dart';

Widget exception(BuildContext context, icon, msg) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon,color:isDark(context)?Colors.white:Colors.black,),
        SizedBox(
          height: 25,
        ),
        Text(msg,style: TextStyle(color:isDark(context)?Colors.white:Colors.black, ) )
      ],
    ),
  );
}
