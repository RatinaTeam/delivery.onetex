import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../Controllers/language_controller.dart';
import '../../utils/image.dart';
import '../../utils/style.dart';
import '../Widgets/constant.dart';

// ignore: must_be_immutable
class ChangeLanguageView extends GetView {
  ChangeLanguageView({Key? key}) : super(key: key);
  LanguageController languageController = Get.put(LanguageController());
  final box = GetStorage();
  final bool isActive = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kBgColor,
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "change_language".tr,
            style: fontRegular.copyWith(
                fontSize: Dimensions.fontSizeExtraLarge.sp,
                fontWeight: FontWeight.w800,
                color: kMainColor),
          ),
          elevation: 0.3,
          backgroundColor: kBgColor,
          iconTheme: const IconThemeData(color: kMainColor),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 24, left: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text(
                    "choose_your_preferred_language".tr,
                    style: fontBlack,
                  ),
                ],
              ),
              SizedBox(
                height: 16.h,
              ),
              //english language
              InkWell(
                onTap: () {
                  languageController.changeLanguage("en");
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: box.read('lang') == 'en'
                        ? kMainColor.withOpacity(0.08)
                        : Colors.white,
                    border: box.read('lang') == 'en'
                        ? Border.all(color: kMainColor)
                        : Border.all(color: darkGrey),
                  ),
                  height: 56.h,
                  width: 328.w,
                  child: Row(children: [
                    SizedBox(width: 16.w),
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        Images.flagEn,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      "English",
                      style: fontMedium.copyWith(color: kTitleColor),
                    ),
                    const Spacer(),
                    box.read('lang') == 'en'
                        ? Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(
                          Images.iconRoundedTicked,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                        : const SizedBox(),
                  ]),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              //bangla language
              InkWell(
                onTap: () {
                  languageController.changeLanguage("bn");
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: box.read('lang') == 'bn'
                        ? kMainColor.withOpacity(0.08)
                        : Colors.white,
                    border: box.read('lang') == 'bn'
                        ? Border.all(color: kMainColor)
                        : Border.all(color: darkGrey),
                  ),
                  height: 56.h,
                  width: 328.w,
                  child: Row(children: [
                    SizedBox(width: 16.w),
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        Images.flagBd,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      "Bangla",
                      style: fontMedium.copyWith(color: kTitleColor),
                    ),
                    const Spacer(),
                    box.read('lang') == 'bn'
                        ? Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(
                          Images.iconRoundedTicked,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                        : const SizedBox(),
                  ]),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              //arabic language
              InkWell(
                onTap: () {
                  languageController.changeLanguage("ar");
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: box.read('lang') == 'ar'
                        ? kMainColor.withOpacity(0.08)
                        : Colors.white,
                    border: box.read('lang') == 'ar'
                        ? Border.all(color: kMainColor)
                        : Border.all(color: darkGrey),
                  ),
                  height: 56.h,
                  width: 328.w,
                  child: Row(children: [
                    SizedBox(width: 16.w),
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        Images.flagAr,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      "عربي",
                      style: fontMedium.copyWith(color: kTitleColor),
                    ),
                    const Spacer(),
                    box.read('lang') == 'ar'
                        ? Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(
                          Images.iconRoundedTicked,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                        : const SizedBox(),
                  ]),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
              //germany language
              InkWell(
                onTap: () {
                  languageController.changeLanguage("hi");
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: box.read('lang') == 'hi'
                        ? kMainColor.withOpacity(0.08)
                        : Colors.white,
                    border: box.read('lang') == 'hi'
                        ? Border.all(color: kMainColor)
                        : Border.all(color: darkGrey),
                  ),
                  height: 56.h,
                  width: 328.w,
                  child: Row(children: [
                    SizedBox(width: 16.w),
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Image.asset(
                        Images.flagIn,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Text(
                      "हिन्दी",
                      style: fontMedium.copyWith(color: kTitleColor),
                    ),
                    const Spacer(),
                    box.read('lang') == 'hi'
                        ? Padding(
                      padding: const EdgeInsets.only(right: 18),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: SvgPicture.asset(
                          Images.iconRoundedTicked,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                        : const SizedBox(),
                  ]),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        ));
  }
}
