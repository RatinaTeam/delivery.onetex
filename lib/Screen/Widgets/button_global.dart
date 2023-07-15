import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/style.dart';

import 'constant.dart';

// ignore: must_be_immutable
class ButtonGlobal extends StatelessWidget {
  final String buttontext;
  final Decoration buttonDecoration;

  // ignore: prefer_typing_uninitialized_variables
  var onPressed;

  // ignore: use_key_in_widget_constructors
  ButtonGlobal(
      {required this.buttontext,
        required this.buttonDecoration,
        required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 20,),
        minimumSize: Size(50, 30),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 12.0, bottom: 12.0,),
        decoration: buttonDecoration,
        child: Center(
          child: Text(
            buttontext,
            style: fontRegular.copyWith(
                fontSize: 18.0,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ButtonGlobalWithoutIcon extends StatelessWidget {
  final String buttontext;
  final Decoration buttonDecoration;

  // ignore: prefer_typing_uninitialized_variables
  var onPressed;
  final Color buttonTextColor;

  // ignore: use_key_in_widget_constructors
  ButtonGlobalWithoutIcon(
      {required this.buttontext,
        required this.buttonDecoration,
        required this.onPressed,
        required this.buttonTextColor});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        decoration: buttonDecoration,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              buttontext,
              style: fontRegular.copyWith(fontSize: 20.0.sp, color: buttonTextColor),
            ),
          ],
        ),
      ),
    );
  }
}
