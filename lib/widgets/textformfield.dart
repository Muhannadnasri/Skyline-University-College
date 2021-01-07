import 'package:flutter/material.dart';
import 'package:skyline_university/Global/global.dart';
import 'package:skyline_university/widgets/responsive_ui.dart';

class CustomTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final TextInputType keyboardType;
  final bool obscureText;
  final TextInputAction textInputAction;
  final String Function(String) validator;
  final IconData icon;
  final focus = FocusNode();
  final void Function(String) onSaved;
  final Widget suffixIcon;
  double _width;
  double _pixelRatio;
  bool large;
  bool medium;

  CustomTextField({
    this.suffixIcon,
    this.onSaved,
    this.validator,
    this.textInputAction,
    this.hint,
    this.textEditingController,
    this.keyboardType,
    this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);
    return Material(
      color: isDark(context) ? Color(0xFF1F1F1F) : Colors.white,
      borderRadius: BorderRadius.circular(25.0),
      elevation: large ? 12 : (medium ? 10 : 8),
      child: TextFormField(
        obscureText: obscureText,
        controller: textEditingController,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        validator: validator,
        style: TextStyle(
          color: isDark(context) ? Colors.white : Colors.black,
        ),
        onFieldSubmitted: (v) {
          FocusScope.of(context).requestFocus(focus);
        },
        onSaved: onSaved,
        cursorColor: Color(0xFF104c90),
        decoration: InputDecoration(
          // hintStyle: TextStyle(
          //   color: isDark(context) ? Colors.white : Colors.black,
          // ),
          suffixIcon: suffixIcon,
          prefixIcon: Icon(icon, color: Color(0xFF104c90), size: 20),
          // hintText: hint,
          labelText: hint,
          labelStyle: TextStyle(
            color: isDark(context) ? Colors.white : Colors.black,
          ),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
