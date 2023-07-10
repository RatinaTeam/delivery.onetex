import 'package:courier/Screen/Widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../utils/style.dart';

class GlobalFormField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType type;
  final dynamic initial;
  final dynamic onSubmit;
  final dynamic onChange;
  final dynamic onTap;
  final dynamic validate;
  final bool isPassword;
  final String label;
  final String? hintText;
  final IconData? suffix;
  final IconData prefixIcon;
  final Function? suffixPressed;
  final bool isClickable;

  const GlobalFormField(
      {Key? key,
        required this.controller,
        required this.type,
        this.initial,
        this.onSubmit,
        this.onChange,
        this.onTap,
        this.isPassword = false,
        required this.validate,
        required this.label,
        this.hintText,
        this.suffix,
        required this.prefixIcon,
        this.suffixPressed,
        this.isClickable = true})
      : super(key: key);

  @override
  _GlobalFormFieldState createState() => _GlobalFormFieldState();
}

class _GlobalFormFieldState extends State<GlobalFormField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label,style: fontRegular.copyWith(color: kTitleColor,fontWeight: FontWeight.bold)),
        SizedBox(height: 8.h,),
        TextFormField(
          initialValue: widget.initial,
          controller: widget.controller,
          cursorColor: kMainColor,
          keyboardType: widget.type,
          obscureText: widget.isPassword,
          enabled: widget.isClickable,
          onFieldSubmitted: widget.onSubmit,
          onChanged: widget.onChange,
          onTap: widget.onTap,
          validator: widget.validate,
          style: fontRegular.copyWith(color: kTitleColor,fontSize: Dimensions.fontSizeDefault.sp),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 15.h),
            //labelText: widget.label,
            filled: true,
            fillColor: itembg,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kMainColor, width: 2.0),
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.transparent,
                width: 2.0,
              ),
            ),
            hintText: widget.hintText,
            hintStyle: fontRegular.copyWith(color: kGreyTextColor),
            prefixIcon: Icon(widget.prefixIcon, color: kTitleColor),
            suffixIcon: widget.suffix != null
                ? IconButton(
              onPressed: () {
                widget.suffixPressed!();
              },
              icon: Icon(
                widget.suffix,
              ),
            )
                : const SizedBox(),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),),
          ),
        ),
      ],
    );
  }
}
