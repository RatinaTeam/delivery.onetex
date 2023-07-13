import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/style.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    Key? key,
    required this.page,
    required this.topic,
    required this.amount,
    required this.imgUrl,
    required this.cardColor,
  }) : super(key: key);
  final bool page;
  final String topic;
  final String amount;
  final String imgUrl;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    return
      Container(
        height: ScreenSize(context).mainHeight / 7.7,
        width: ScreenSize(context).mainWidth / 3.7,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                topic,
                textAlign: TextAlign.center,
                style: fontRegular.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
              Text(
                amount,
                style: fontRegular.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14.sp,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      );

  }
}
