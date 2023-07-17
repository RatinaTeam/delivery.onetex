import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

import '../../Controllers/global-controller.dart';
import '../../Controllers/profile_controller.dart';
import '../../utils/image.dart';
import '../../utils/style.dart';
import '../Widgets/constant.dart';
import 'package:get/get.dart';

import '../Widgets/profile_card.dart';
import '../Widgets/shimmer/profile_shimmer.dart';
import 'change_language_view.dart';
import 'change_password_view.dart';
import 'edit_profile_view.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'profile'.tr,
          style: fontRegular.copyWith(
              color: kMainColor,
              fontSize: Dimensions.fontSizeExtraLarge.sp,
              fontWeight: FontWeight.w800),
        ),
        backgroundColor: kBgColor,
        elevation: 0.3,
        iconTheme: const IconThemeData(color: kBgColor),
      ),
      body: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (profile) => SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.0.h),
              Column(
                children: [
                  profile.profileLoader
                      ? ProfileShimmer()
                      : Padding(
                          padding: EdgeInsets.only(
                              left: 10.w, right: 10.w, bottom: 10.h),
                          child: SizedBox(
                            child: Column(
                              children: [
                                //first box
                                SizedBox(
                                  child: Column(
                                    children: [
                                      Container(
                                        height: height * 0.6,
                                        child: LayoutBuilder(builder:
                                            (BuildContext,
                                            BoxConstraints) {
                                          double innerHeight =
                                              BoxConstraints.maxHeight;
                                          double innerWidth =
                                              BoxConstraints.maxWidth;
                                          return Stack(
                                            fit: StackFit.expand,
                                            children: [
                                              Positioned(
                                                bottom: 0,
                                                left: 0,
                                                right: 0,
                                                child: Card(
                                                  elevation: 1,
                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    side: BorderSide(color: kDarkWhite, width: 0.5),
                                                    borderRadius:
                                                    BorderRadius.circular(6.0),
                                                  ),
                                                  child: Container(
                                                    height:
                                                    innerHeight * 0.85,
                                                    width: innerWidth,
                                                    child: Column(
                                                      children: [
                                                        SizedBox(height: 55.h),
                                                        Text(
                                                            profile.profileUser.user!.name.toString(),
                                                          style: fontRegular.copyWith(
                                                              color: kTitleColor,
                                                              fontSize: Dimensions.fontSizeLarge.sp,
                                                              fontWeight: FontWeight.w700
                                                          ),
                                                        ),
                                                        SizedBox(height: 4.h,),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Image.asset(
                                                              Images.emailIcon,
                                                              width: 14.w,
                                                            ),
                                                            SizedBox(
                                                              height: 4.w,
                                                            ),
                                                            Text(
                                                              profile.profileUser.user!.email
                                                                  .toString(),
                                                              style: fontRegular.copyWith(
                                                                  color: grayColor,
                                                                  fontSize: Dimensions.fontSizeSmall.sp,
                                                                  fontWeight: FontWeight.w500
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Image.asset(
                                                                  Images.phoneIcon,
                                                                  width: 14.w,
                                                                ),
                                                                SizedBox(
                                                                  height: 4.w,
                                                                ),
                                                                Text(
                                                                  profile.profileUser.user!.phone
                                                                      .toString(),
                                                                  style: fontRegular.copyWith(
                                                                      color: grayColor,
                                                                      fontSize: Dimensions.fontSizeSmall.sp,
                                                                      fontWeight: FontWeight.w500
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Text(" . ",
                                                              style: fontRegular.copyWith(
                                                                  color: kMainColor,
                                                                  fontSize: Dimensions.fontSizeLarge.sp,
                                                                  fontWeight: FontWeight.w700
                                                              ),
                                                            ),
                                                            Row(
                                                              children: [
                                                                Image.asset(
                                                                  Images.locationLineIcon,
                                                                  width: 14.w,
                                                                ),
                                                                SizedBox(
                                                                  height: 4.w,
                                                                ),
                                                                Text(
                                                                  profile.profileUser.user!.address
                                                                      .toString(),
                                                                  style: fontRegular.copyWith(
                                                                      color: grayColor,
                                                                      fontSize: Dimensions.fontSizeSmall.sp,
                                                                      fontWeight: FontWeight.w500
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],),
                                                        SizedBox(height: 20.h,),
                                                        Row(
                                                          mainAxisAlignment:
                                                          MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            Tracker(
                                                              trackNo: profile
                                                                  .profileUser.deliveryInProgress
                                                                  .toString(),
                                                              track: "delivered_progress".tr,
                                                            ),
                                                            Tracker(
                                                              trackNo: profile
                                                                  .profileUser.completedDelivered
                                                                  .toString(),
                                                              track: "delivered_completed".tr,
                                                            ),
                                                            Tracker(
                                                              trackNo: profile
                                                                  .profileUser.canceledDelivered
                                                                  .toString(),
                                                              track: "canceled".tr,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(height: 20.h,),
                                                        Row(
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            ProfileCard(
                                                              page: false,
                                                              topic: 'balance'.tr,
                                                              amount:
                                                              ' ${Get.find<GlobalController>().currency!} ${profile.profileUser.currentBalance.toString()}',
                                                              imgUrl: Images.logo,
                                                              cardColor: kSecondaryColor,
                                                            ),
                                                            ProfileCard(
                                                              page: true,
                                                              topic: "earning".tr,
                                                              amount:
                                                              ' ${Get.find<GlobalController>().currency!} ${profile.profileUser.deliverymanEarn.toString()}',
                                                              imgUrl: Images.logo,
                                                              cardColor: kMainColor,
                                                            ),
                                                            ProfileCard(
                                                              page: true,
                                                              topic: "total_cod".tr,
                                                              amount:
                                                              ' ${Get.find<GlobalController>().currency!}${profile.profileUser.totalCod.toString()}',
                                                              imgUrl: Images.logo,
                                                              cardColor: titleColor,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Positioned(
                                                top: innerHeight* 0.05,
                                                left: 0,
                                                right: 0,
                                                child: SizedBox(
                                                  width: innerWidth* 0.45,
                                                  child: Center(
                                                    child:
                                                    CachedNetworkImage(
                                                      imageUrl: profile
                                                          .profileUser
                                                          .user!.image
                                                          .toString(),
                                                      imageBuilder: (context,
                                                          imageProvider) =>
                                                          CircleAvatar(
                                                            radius: 50.0,
                                                            backgroundColor:
                                                            Colors
                                                                .transparent,
                                                            backgroundImage:
                                                            imageProvider,
                                                          ),
                                                      placeholder: (context,
                                                          url) =>
                                                          Shimmer
                                                              .fromColors(
                                                            child: CircleAvatar(
                                                                radius:
                                                                50.0),
                                                            baseColor:
                                                            Colors.grey[
                                                            300]!,
                                                            highlightColor:
                                                            Colors.grey[
                                                            400]!,
                                                          ),
                                                      errorWidget:
                                                          (context,
                                                          url,
                                                          error) =>
                                                          Icon(
                                                            CupertinoIcons
                                                                .person,
                                                            size: 50,
                                                          ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                        }),
                                      ),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                    ],
                                  ),
                                ),
                                //second box
                                Card(
                                  elevation: 1,
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    side: BorderSide(color: kDarkWhite, width: 0.5),
                                    borderRadius:
                                    BorderRadius.circular(6.0),
                                  ),
                                  child: Container(
                                    height: height * 0.37,
                                    width: width,
                                    padding: EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        profileItem(
                                            EditProfileView(),
                                            Images.iconEditProfile,
                                            "edit_profile".tr),
                                        profileItem(
                                            ChangePasswordView(),
                                            Images.iconChangePass,
                                            "change_password".tr),
                                        profileItem(
                                            ChangeLanguageView(),
                                            Images.iconChangeLang,
                                            "change_language".tr),
                                        SizedBox(
                                          height: 14,
                                        ),
                                        InkWell(
                                          onTap: () {
                                            Get.find<GlobalController>()
                                                .userLogout();
                                          },
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    Images.iconLogout,
                                                    height: 16.h,
                                                    width: 16.w,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  SizedBox(
                                                    width: 16.h,
                                                  ),
                                                  Text(
                                                    "log_out".tr,
                                                    style: fontProfile,
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: 14.h,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 30.h,
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
      ),
    );
  }

  InkWell profileItem(route, icon, textValue) {
    return InkWell(
      onTap: () => Get.to(route),
      child: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Row(
            children: [
              SvgPicture.asset(
                icon,
                height: 18.h,
                width: 18.w,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: 16.h,
              ),
              Text(
                "$textValue",
                style: fontProfile,
              ),
            ],
          ),
          SizedBox(
            height: 14.h,
          ),
          const Divider(
            thickness: 1,
            endIndent: 10,
            color: dividerColor,
          ),
        ],
      ),
    );
  }
}

class Tracker extends StatelessWidget {
  const Tracker({Key? key, required this.trackNo, required this.track})
      : super(key: key);
  final String trackNo;
  final String track;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenSize(context).mainHeight / 7.7,
      width: ScreenSize(context).mainWidth / 3.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(1, 1), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            trackNo,
            style: fontRegular.copyWith(
              color: kTitleColor,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            track,
            style: fontRegular.copyWith(
              color: kTitleColor,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
