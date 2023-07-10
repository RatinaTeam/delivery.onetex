import 'package:cached_network_image/cached_network_image.dart';
import 'package:courier/Controllers/dashboard_controller.dart';
import 'package:courier/Screen/Home/home.dart';
import 'package:courier/Screen/Payment/payment.dart';
import 'package:courier/Screen/Payment/payment_parcel_history.dart';
import 'package:courier/Screen/Profile/profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../Controllers/global-controller.dart';
import '../../Controllers/language_controller.dart';
import '../../Models/dashboard_model.dart';
import '../../Models/language_model.dart';
import '../../utils/image.dart';
import '../../utils/style.dart';
import '../Widgets/constant.dart';
import '../Widgets/custom_form_field.dart';
import '../Widgets/form_title.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  Language? selectedLang;
  DashboardController dashboardController = Get.put(DashboardController());
  GlobalController globalController = GlobalController();
  LanguageController languageController = Get.put(LanguageController());
  final box = GetStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {});

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Get.rawSnackbar(
        snackPosition: SnackPosition.TOP,
        title: message.notification?.title,
        message: message.notification?.body,
        backgroundColor: kMainColor.withOpacity(.9),
        maxWidth: ScreenSize(context).mainWidth / 1.007,
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    selectedLang = languageController.languageList[languageController
        .languageList
        .indexWhere((i) => i.locale == Get.locale)];
    return GetBuilder<DashboardController>(
      init: DashboardController(),
      builder: (dashboard) => DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: kBgColor,
          drawer: Drawer(
            backgroundColor: kBgColor,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50.0),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: kMainColor,
                      ),
                      child: Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl:
                                Get.find<GlobalController>().userImage == null
                                    ? 'images/profile.png'
                                    : Get.find<GlobalController>()
                                        .userImage
                                        .toString(),
                            imageBuilder: (context, imageProvider) =>
                                CircleAvatar(
                              radius: 25.0,
                              backgroundImage: imageProvider,
                              backgroundColor: Colors.transparent,
                            ),
                            placeholder: (context, url) => Shimmer.fromColors(
                              child: CircleAvatar(radius: 25.0),
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey[400]!,
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Get.find<GlobalController>().userName == null
                                    ? Text('')
                                    : Text(
                                        Get.find<GlobalController>()
                                            .userName
                                            .toString(),
                                        style: fontRegular.copyWith(
                                            color: kBgColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                Get.find<GlobalController>().userEmail == null
                                    ? Text('')
                                    : Text(
                                        Get.find<GlobalController>()
                                            .userEmail
                                            .toString(),
                                        style: fontRegular.copyWith(
                                            color: kBgColor),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListTile(
                      onTap: (() => const Home().launch(context)),
                      contentPadding: EdgeInsets.zero,
                      horizontalTitleGap: 0,
                      leading: const Icon(
                        FontAwesomeIcons.house,
                        color: kTitleColor,
                        size: 18.0,
                      ),
                      title: Text(
                        'dashboard'.tr,
                        style: fontRegular.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(FeatherIcons.chevronRight,
                            color: kTitleColor, size: 18),
                      ),
                    ),
                    ListTile(
                      onTap: (() => const Profile().launch(context)),
                      contentPadding: EdgeInsets.zero,
                      horizontalTitleGap: 0,
                      leading: const Icon(
                        FontAwesomeIcons.user,
                        color: kTitleColor,
                        size: 18.0,
                      ),
                      title: Text(
                        'profile'.tr,
                        style: fontRegular.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(FeatherIcons.chevronRight,
                            color: kTitleColor, size: 18),
                      ),
                    ),
                    ListTile(
                      onTap: (() => const PaymentPage().launch(context)),
                      contentPadding: EdgeInsets.zero,
                      horizontalTitleGap: 0,
                      leading: const Icon(
                        FontAwesomeIcons.list,
                        color: kTitleColor,
                        size: 18.0,
                      ),
                      title: Text(
                        'payment_log'.tr,
                        style: fontRegular.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(FeatherIcons.chevronRight,
                            color: kTitleColor, size: 18),
                      ),
                    ),
                    ListTile(
                      onTap: (() =>
                          const PaymentParcelHistoryPage().launch(context)),
                      contentPadding: EdgeInsets.zero,
                      horizontalTitleGap: 0,
                      leading: const Icon(
                        FontAwesomeIcons.clipboardList,
                        color: kTitleColor,
                        size: 18.0,
                      ),
                      title: Text(
                        'parcel_payment_history'.tr,
                        style: fontRegular.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(FeatherIcons.chevronRight,
                            color: kTitleColor, size: 18),
                      ),
                    ),
                    ListTile(
                      onTap: () => {
                        Get.find<GlobalController>().userLogout(),
                        Navigator.of(context).pop()
                      },
                      contentPadding: EdgeInsets.zero,
                      horizontalTitleGap: 0,
                      leading: const Icon(
                        Icons.exit_to_app,
                        color: kTitleColor,
                        size: 18.0,
                      ),
                      title: Text(
                        'log_out'.tr,
                        style: fontRegular.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.all(2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(FeatherIcons.chevronRight,
                            color: kTitleColor, size: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          appBar: AppBar(
            iconTheme: const IconThemeData(color: kMainColor),
            titleSpacing: 0,
            backgroundColor: kBgColor,
            elevation: 0.3,
            title: ListTile(
              horizontalTitleGap: 0,
              contentPadding: const EdgeInsets.all(10.0),
              title: Image.asset(
                Images.appLogo1,
                width: 30,
                height: 30,
              ),
              trailing: Container(
                padding: EdgeInsets.only(left: 8, right: 0),
                decoration: BoxDecoration(
                  color: kBgColor, //<-- SEE HERE
                ),
                height: 25.0,
                child: DropdownButton<Language>(
                  icon: Icon(
                    Icons.arrow_drop_down_circle_outlined,
                    color: kMainColor,
                  ),
                  iconSize: 18,
                  focusColor: kMainColor,
                  elevation: 16,
                  value: selectedLang,
                  style: fontRegular.copyWith(color: kMainColor),
                  underline: Container(
                    padding: const EdgeInsets.only(left: 4, right: 4),
                    color: Colors.transparent,
                  ),
                  onChanged: (newValue) async {
                    setState(() {
                      selectedLang = newValue!;
                      if (newValue.langName == 'English') {
                        languageController.changeLanguage("en");
                      } else if (newValue.langName == 'Bangla') {
                        languageController.changeLanguage("bn");
                      } else if (newValue.langName == 'हिन्दी') {
                        languageController.changeLanguage("hi");
                      } else if (newValue.langName == 'عربي') {
                        languageController.changeLanguage("ar");
                      }
                    });
                  },
                  items: languageController.languageList
                      .map<DropdownMenuItem<Language>>((Language value) {
                    return DropdownMenuItem<Language>(
                      value: value,
                      child: Text(value.langName,
                          style: fontRegular.copyWith(
                              color: kMainColor,
                              fontSize: Dimensions.fontSizeDefault.sp,
                              fontWeight: FontWeight.w500)),
                    );
                  }).toList(),
                ),
              ),
            ),
            bottom: TabBar(
              padding: EdgeInsets.zero,
              isScrollable: true,
              indicatorPadding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              labelColor: kMainColor,
              labelStyle: fontRegular.copyWith(
                  color: kMainColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700),
              unselectedLabelColor: kTitleColor,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: kSecondaryColor,
              tabs: [
                Tab(
                  child: Container(
                    margin:
                        EdgeInsets.only(top: 5, bottom: 0, left: 0, right: 0),
                    width: MediaQuery.of(context).size.width / 2.5,
                    padding: const EdgeInsets.only(top: 5),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          'delivered_pending'.tr,
                        ),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 4.50,
                    margin: EdgeInsets.symmetric(horizontal: 15.w),
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5)),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          'return'.tr,
                        ),
                      ),
                    ),
                  ),
                ),
                Tab(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3.50,
                    margin: EdgeInsets.only(left: 20.w),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(
                          'delivered'.tr,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: TabBarView(
            physics: const BouncingScrollPhysics(),
            children: [
              GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: RefreshIndicator(
                  displacement: 250,
                  backgroundColor: Colors.yellow,
                  color: Colors.red,
                  strokeWidth: 3,
                  onRefresh: () async {
                    await Future.delayed(Duration(milliseconds: 1500));
                    setState(() {
                      dashboard.onInit();
                    });
                  },
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 18.h),
                            child: dashboard.deliverymanAssignList.length == 0
                                ? Padding(
                                    padding: EdgeInsets.only(top: 250.h),
                                    child: Center(
                                      child: Text(
                                        'no_item_found'.tr,
                                        style: fontRegular.copyWith(
                                            fontSize: Dimensions
                                                .fontSizeExtraLarge22.sp,
                                            fontWeight: FontWeight.bold,
                                            color: kMainColor),
                                      ),
                                    ),
                                  )
                                : RefreshIndicator(
                                    displacement: 250,
                                    backgroundColor: Colors.yellow,
                                    color: Colors.red,
                                    strokeWidth: 3,
                                    onRefresh: () async {
                                      await Future.delayed(
                                          Duration(milliseconds: 1500));
                                      setState(() {
                                        dashboard.onInit();
                                      });
                                    },
                                    child: ListView.builder(
                                      itemCount: dashboard
                                          .deliverymanAssignList.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                            onTap: () {
                                              setState(() {
                                                showPopUp(dashboard
                                                        .deliverymanAssignList[
                                                    index]);
                                              });
                                            },
                                            child: Card(
                                              color: kBgColor,
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 7),
                                              elevation: 1,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                              ),
                                              child: Container(
                                                height: 165.h,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          6.0),
                                                  gradient: LinearGradient(
                                                      stops: [
                                                        0.02,
                                                        0.02
                                                      ],
                                                      colors: [
                                                        kMainColor,
                                                        Colors.white
                                                      ]),
                                                ),
                                                padding:
                                                    EdgeInsetsDirectional.only(
                                                  start: 5.0.w,
                                                  top: 10.0.h,
                                                  bottom: 10.0.h,
                                                  end: 20.0.w,
                                                ),
                                                child: Row(
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(50),
                                                        color: Colors.white,
                                                        image: DecorationImage(
                                                          image: AssetImage(
                                                              Images.parcel),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                      height: 60.h,
                                                      width: 60.w,
                                                    ),
                                                    SizedBox(
                                                      width: 10.w,
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Icon(
                                                                    CupertinoIcons
                                                                        .person,
                                                                    color:
                                                                        kMainColor,
                                                                    size: 16,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 4.w,
                                                                  ),
                                                                  Text(
                                                                    dashboard
                                                                        .deliverymanAssignList[
                                                                            index]
                                                                        .customerName
                                                                        .toString(),
                                                                    style: fontRegular
                                                                        .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w700,
                                                                      fontSize:
                                                                          14.sp,
                                                                      color:
                                                                          kMainColor,
                                                                    ),
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ],
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  Get.back();
                                                                  showStatusPopUp(
                                                                      dashboard
                                                                              .deliverymanAssignList[
                                                                          index]);
                                                                },
                                                                child: SizedBox(
                                                                  height: 35.h,
                                                                  child: Card(
                                                                    elevation:
                                                                        1,
                                                                    color:
                                                                        deleveryColor,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              6.0),
                                                                    ),
                                                                    child:
                                                                        Padding(
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .only(
                                                                        left: 5,
                                                                        right:
                                                                            5,
                                                                      ),
                                                                      child:
                                                                          Text(
                                                                        'change_status'
                                                                            .tr,
                                                                        style: fontRegular.copyWith(
                                                                            color:
                                                                                darkGreen,
                                                                            fontSize:
                                                                                14,
                                                                            fontWeight:
                                                                                FontWeight.bold),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 15.h,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  Icon(
                                                                    Icons
                                                                        .location_on_outlined,
                                                                    color:
                                                                        hintColor,
                                                                    size: 14,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 2.w,
                                                                  ),
                                                                  SizedBox(
                                                                    width:
                                                                        100.w,
                                                                    child: Text(
                                                                      dashboard
                                                                          .deliverymanAssignList[
                                                                              index]
                                                                          .customerAddress
                                                                          .toString(),
                                                                      style: fontRegular
                                                                          .copyWith(
                                                                        fontWeight:
                                                                            FontWeight.w400,
                                                                        fontSize:
                                                                            14,
                                                                        color:
                                                                            hintColor,
                                                                      ),
                                                                      maxLines:
                                                                          2,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      var url =
                                                                          'https://www.google.com/maps/dir/?api=1&origin=&destination=${dashboard.deliverymanAssignList[index].customerAddress.toString()}&travelmode=driving';
                                                                      _launchMapURL(
                                                                          Uri.parse(
                                                                              url));
                                                                    },
                                                                    style: TextButton.styleFrom(
                                                                        padding:
                                                                            EdgeInsets
                                                                                .zero,
                                                                        minimumSize: Size(
                                                                            50,
                                                                            30),
                                                                        tapTargetSize:
                                                                            MaterialTapTargetSize
                                                                                .shrinkWrap,
                                                                        alignment:
                                                                            Alignment.centerLeft),
                                                                    child: Row(
                                                                      children: [
                                                                        Image
                                                                            .asset(
                                                                          Images
                                                                              .mapIcon,
                                                                          width:
                                                                              25.w,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 25.w,
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Icon(
                                                                    CupertinoIcons
                                                                        .phone,
                                                                    color:
                                                                        hintColor,
                                                                    size: 14,
                                                                  ),
                                                                  SizedBox(
                                                                    width: 2.w,
                                                                  ),
                                                                  Text(
                                                                    dashboard
                                                                        .deliverymanAssignList[
                                                                            index]
                                                                        .customerPhone
                                                                        .toString(),
                                                                    style: fontRegular
                                                                        .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          14,
                                                                      color:
                                                                          hintColor,
                                                                    ),
                                                                    maxLines: 1,
                                                                  ),
                                                                ],
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Row(
                                                                    children: [
                                                                      TextButton(
                                                                        onPressed: () => _launchURL(dashboard
                                                                            .deliverymanAssignList[index]
                                                                            .customerPhone
                                                                            .toString()),
                                                                        style: TextButton.styleFrom(
                                                                            padding: EdgeInsets
                                                                                .zero,
                                                                            minimumSize: Size(50,
                                                                                30),
                                                                            tapTargetSize:
                                                                                MaterialTapTargetSize.shrinkWrap,
                                                                            alignment: Alignment.centerLeft),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Image.asset(
                                                                              Images.phoneIcon,
                                                                              width: 25.w,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  Row(
                                                                    children: [
                                                                      TextButton(
                                                                        onPressed: () => _launchWhatsAppURL(dashboard
                                                                            .deliverymanAssignList[index]
                                                                            .customerPhone
                                                                            .toString()),
                                                                        style: TextButton.styleFrom(
                                                                            padding: EdgeInsets
                                                                                .zero,
                                                                            minimumSize: Size(50,
                                                                                30),
                                                                            tapTargetSize:
                                                                                MaterialTapTargetSize.shrinkWrap,
                                                                            alignment: Alignment.centerLeft),
                                                                        child:
                                                                            Row(
                                                                          children: [
                                                                            Image.asset(
                                                                              Images.whatsAppIcon,
                                                                              width: 25.w,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        width:
                                                                            5.w,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(
                                                            height: 5.h,
                                                          ),
                                                          Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Icon(
                                                                CupertinoIcons
                                                                    .money_dollar_circle,
                                                                color:
                                                                    kTitleColor,
                                                                size: 16,
                                                              ),
                                                              SizedBox(
                                                                width: 2.w,
                                                              ),
                                                              Text(
                                                                '${Get.find<GlobalController>().currency!}${dashboard.deliverymanAssignList[index].cashCollection.toString()}',
                                                                style: fontRegular
                                                                    .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontSize:
                                                                      14.sp,
                                                                  color:
                                                                      kTitleColor,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ));
                                      },
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: RefreshIndicator(
                  displacement: 250,
                  backgroundColor: Colors.yellow,
                  color: Colors.red,
                  strokeWidth: 3,
                  onRefresh: () async {
                    await Future.delayed(Duration(milliseconds: 1500));
                    setState(() {
                      dashboard.onInit();
                    });
                  },
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 18.h),
                            child: dashboard.returnToCourierList.length == 0
                                ? Padding(
                                    padding: EdgeInsets.only(top: 250.h),
                                    child: Center(
                                      child: Text(
                                        'no_item_found'.tr,
                                        style: fontRegular.copyWith(
                                            fontSize: 24,
                                            color: kMainColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                : RefreshIndicator(
                                    displacement: 250,
                                    backgroundColor: Colors.yellow,
                                    color: Colors.red,
                                    strokeWidth: 3,
                                    onRefresh: () async {
                                      await Future.delayed(
                                          Duration(milliseconds: 1500));
                                      setState(() {
                                        dashboard.onInit();
                                      });
                                    },
                                    child: ListView.builder(
                                      itemCount:
                                          dashboard.returnToCourierList.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              showPopUp(dashboard
                                                  .returnToCourierList[index]);
                                            });
                                          },
                                          child: Card(
                                            color: kBgColor,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 7),
                                            elevation: 1,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                            ),
                                            child: Container(
                                              height: 165.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                gradient: LinearGradient(
                                                    stops: [
                                                      0.02,
                                                      0.02
                                                    ],
                                                    colors: [
                                                      kMainColor,
                                                      Colors.white
                                                    ]),
                                              ),
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                start: 5.0.w,
                                                top: 10.0.h,
                                                bottom: 10.0.h,
                                                end: 20.0.w,
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: Colors.white,
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            Images.parcel),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    height: 60.h,
                                                    width: 60.w,
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(
                                                              CupertinoIcons
                                                                  .person,
                                                              color: kMainColor,
                                                              size: 16,
                                                            ),
                                                            SizedBox(
                                                              width: 4.w,
                                                            ),
                                                            Text(
                                                              dashboard
                                                                  .returnToCourierList[
                                                                      index]
                                                                  .customerName
                                                                  .toString(),
                                                              style: fontRegular
                                                                  .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 14.sp,
                                                                color:
                                                                    kMainColor,
                                                              ),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 15.h,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .location_on_outlined,
                                                                  color:
                                                                      hintColor,
                                                                  size: 14,
                                                                ),
                                                                SizedBox(
                                                                  width: 2.w,
                                                                ),
                                                                SizedBox(
                                                                  width: 100.w,
                                                                  child: Text(
                                                                    dashboard
                                                                        .returnToCourierList[
                                                                            index]
                                                                        .customerAddress
                                                                        .toString(),
                                                                    style: fontRegular
                                                                        .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          14,
                                                                      color:
                                                                          hintColor,
                                                                    ),
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    var url =
                                                                        'https://www.google.com/maps/dir/?api=1&origin=&destination=${dashboard.returnToCourierList[index].customerAddress.toString()}&travelmode=driving';
                                                                    _launchMapURL(
                                                                        Uri.parse(
                                                                            url));
                                                                  },
                                                                  style: TextButton.styleFrom(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      minimumSize:
                                                                          Size(
                                                                              50,
                                                                              30),
                                                                      tapTargetSize:
                                                                          MaterialTapTargetSize
                                                                              .shrinkWrap,
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft),
                                                                  child: Row(
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        Images
                                                                            .mapIcon,
                                                                        width:
                                                                            25.w,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 25.w,
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Icon(
                                                                  CupertinoIcons
                                                                      .phone,
                                                                  color:
                                                                      hintColor,
                                                                  size: 14,
                                                                ),
                                                                SizedBox(
                                                                  width: 2.w,
                                                                ),
                                                                Text(
                                                                  dashboard
                                                                      .returnToCourierList[
                                                                          index]
                                                                      .customerPhone
                                                                      .toString(),
                                                                  style: fontRegular
                                                                      .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w400,
                                                                    fontSize:
                                                                        14,
                                                                    color:
                                                                        hintColor,
                                                                  ),
                                                                  maxLines: 1,
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                Row(
                                                                  children: [
                                                                    TextButton(
                                                                      onPressed: () => _launchURL(dashboard
                                                                          .returnToCourierList[
                                                                              index]
                                                                          .customerPhone
                                                                          .toString()),
                                                                      style: TextButton.styleFrom(
                                                                          padding: EdgeInsets
                                                                              .zero,
                                                                          minimumSize: Size(
                                                                              50,
                                                                              30),
                                                                          tapTargetSize: MaterialTapTargetSize
                                                                              .shrinkWrap,
                                                                          alignment:
                                                                              Alignment.centerLeft),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Image
                                                                              .asset(
                                                                            Images.phoneIcon,
                                                                            width:
                                                                                25.w,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    TextButton(
                                                                      onPressed: () => _launchWhatsAppURL(dashboard
                                                                          .returnToCourierList[
                                                                              index]
                                                                          .customerPhone
                                                                          .toString()),
                                                                      style: TextButton.styleFrom(
                                                                          padding: EdgeInsets
                                                                              .zero,
                                                                          minimumSize: Size(
                                                                              50,
                                                                              30),
                                                                          tapTargetSize: MaterialTapTargetSize
                                                                              .shrinkWrap,
                                                                          alignment:
                                                                              Alignment.centerLeft),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Image
                                                                              .asset(
                                                                            Images.whatsAppIcon,
                                                                            width:
                                                                                25.w,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    SizedBox(
                                                                      width:
                                                                          5.w,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(
                                                              CupertinoIcons
                                                                  .money_dollar_circle,
                                                              color:
                                                                  kTitleColor,
                                                              size: 16,
                                                            ),
                                                            SizedBox(
                                                              width: 2.w,
                                                            ),
                                                            Text(
                                                              '${Get.find<GlobalController>().currency!}${dashboard.returnToCourierList[index].cashCollection.toString()}',
                                                              style: fontRegular
                                                                  .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14.sp,
                                                                color:
                                                                    kTitleColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: RefreshIndicator(
                  displacement: 250,
                  backgroundColor: Colors.yellow,
                  color: Colors.red,
                  strokeWidth: 3,
                  onRefresh: () async {
                    await Future.delayed(Duration(milliseconds: 1500));
                    setState(() {
                      dashboard.onInit();
                    });
                  },
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 18.h),
                            child: dashboard.deliveredList.length == 0
                                ? Padding(
                                    padding: EdgeInsets.only(top: 250.h),
                                    child: Center(
                                      child: Text(
                                        'no_item_found'.tr,
                                        style: fontRegular.copyWith(
                                            fontSize: 24,
                                            color: kMainColor,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  )
                                : RefreshIndicator(
                                    displacement: 250,
                                    backgroundColor: Colors.yellow,
                                    color: Colors.red,
                                    strokeWidth: 3,
                                    onRefresh: () async {
                                      await Future.delayed(
                                          Duration(milliseconds: 1500));
                                      setState(() {
                                        dashboard.onInit();
                                      });
                                    },
                                    child: ListView.builder(
                                      itemCount: dashboard.deliveredList.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      padding: EdgeInsets.zero,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: () {
                                            setState(() {
                                              showPopUp(dashboard
                                                  .deliveredList[index]);
                                            });
                                          },
                                          child: Card(
                                            color: kBgColor,
                                            margin: EdgeInsets.symmetric(
                                                vertical: 7),
                                            elevation: 1,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(6.0),
                                            ),
                                            child: Container(
                                              height: 165.h,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(6.0),
                                                gradient: LinearGradient(
                                                    stops: [
                                                      0.02,
                                                      0.02
                                                    ],
                                                    colors: [
                                                      kMainColor,
                                                      Colors.white
                                                    ]),
                                              ),
                                              padding:
                                                  EdgeInsetsDirectional.only(
                                                start: 5.0.w,
                                                top: 10.0.h,
                                                bottom: 10.0.h,
                                                end: 20.0.w,
                                              ),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      color: Colors.white,
                                                      image: DecorationImage(
                                                        image: AssetImage(
                                                            Images.parcel),
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    height: 60.h,
                                                    width: 60.w,
                                                  ),
                                                  SizedBox(
                                                    width: 10.w,
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(
                                                              CupertinoIcons
                                                                  .person,
                                                              color: kMainColor,
                                                              size: 16,
                                                            ),
                                                            SizedBox(
                                                              width: 4.w,
                                                            ),
                                                            Text(
                                                              dashboard
                                                                  .deliveredList[
                                                                      index]
                                                                  .customerName
                                                                  .toString(),
                                                              style: fontRegular
                                                                  .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700,
                                                                fontSize: 14.sp,
                                                                color:
                                                                    kMainColor,
                                                              ),
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 15.h,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .location_on_outlined,
                                                                  color:
                                                                      hintColor,
                                                                  size: 14,
                                                                ),
                                                                SizedBox(
                                                                  width: 2.w,
                                                                ),
                                                                SizedBox(
                                                                  width: 100.w,
                                                                  child: Text(
                                                                    dashboard
                                                                        .deliveredList[
                                                                            index]
                                                                        .customerAddress
                                                                        .toString(),
                                                                    style: fontRegular
                                                                        .copyWith(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w400,
                                                                      fontSize:
                                                                          14,
                                                                      color:
                                                                          hintColor,
                                                                    ),
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Row(
                                                              children: [
                                                                TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    var url =
                                                                        'https://www.google.com/maps/dir/?api=1&origin=&destination=${dashboard.deliveredList[index].customerAddress.toString()}&travelmode=driving';
                                                                    _launchMapURL(
                                                                        Uri.parse(
                                                                            url));
                                                                  },
                                                                  style: TextButton.styleFrom(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      minimumSize:
                                                                          Size(
                                                                              50,
                                                                              30),
                                                                      tapTargetSize:
                                                                          MaterialTapTargetSize
                                                                              .shrinkWrap,
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft),
                                                                  child: Row(
                                                                    children: [
                                                                      Image
                                                                          .asset(
                                                                        Images
                                                                            .mapIcon,
                                                                        width:
                                                                            25.w,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 25.w,
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Text(
                                                              dashboard
                                                                  .deliveredList[
                                                                      index]
                                                                  .customerPhone
                                                                  .toString(),
                                                              style: fontRegular
                                                                  .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14,
                                                                color:
                                                                    hintColor,
                                                              ),
                                                              maxLines: 1,
                                                            ),
                                                            Row(
                                                              children: [
                                                                TextButton(
                                                                  onPressed: () => _launchURL(dashboard
                                                                      .deliveredList[
                                                                          index]
                                                                      .customerPhone
                                                                      .toString()),
                                                                  style: TextButton.styleFrom(
                                                                      padding:
                                                                          EdgeInsets
                                                                              .zero,
                                                                      minimumSize:
                                                                          Size(
                                                                              50,
                                                                              30),
                                                                      tapTargetSize:
                                                                          MaterialTapTargetSize
                                                                              .shrinkWrap,
                                                                      alignment:
                                                                          Alignment
                                                                              .centerLeft),
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                        Icons
                                                                            .phone_outlined,
                                                                        color: Colors
                                                                            .green,
                                                                        size:
                                                                            20,
                                                                      ),
                                                                      Text(
                                                                        "Call me",
                                                                        style: fontRegular
                                                                            .copyWith(
                                                                          fontWeight:
                                                                              FontWeight.w800,
                                                                          fontSize:
                                                                              14,
                                                                          color:
                                                                              Colors.green,
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                  width: 20.w,
                                                                )
                                                              ],
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 5.h,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Icon(
                                                              CupertinoIcons
                                                                  .money_dollar_circle,
                                                              color:
                                                                  kTitleColor,
                                                              size: 16,
                                                            ),
                                                            SizedBox(
                                                              width: 2.w,
                                                            ),
                                                            Text(
                                                              '${Get.find<GlobalController>().currency!}${dashboard.deliveredList[index].cashCollection.toString()}',
                                                              style: fontRegular
                                                                  .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                fontSize: 14.sp,
                                                                color:
                                                                    kTitleColor,
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
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
      ),
    );
  }

  _launchURL(String phoneNumber) async {
    final Uri launchUri = Uri(
      scheme: 'tel',
      path: phoneNumber,
    );
    await launchUrl(launchUri);
  }

  _launchMapURL(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw 'Could not launch $url';
    }
  }

  _launchWhatsAppURL(String phoneNumber) async {
    String url = "whatsapp://send?phone=$phoneNumber";

    await canLaunchUrlString(url)
        ? launchUrlString(url)
        : print('Could not launch $url');
  }

  void showPopUp(parcel) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Card(
                        elevation: 1,
                        color: kSecondaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Text(
                            '${parcel.statusName}',
                            style: fontRegular.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    'merchant'.tr,
                    style: fontRegular.copyWith(
                        color: kTitleColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: kGreyTextColor.withOpacity(0.5),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Text(
                        'shop_name'.tr + ':',
                        style: fontRegular.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${parcel.merchantName}',
                        style: fontRegular.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Text(
                        'phone'.tr + ':',
                        style: fontRegular.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${parcel.merchantMobile}',
                        style: fontRegular.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Text(
                        'pickup_address'.tr + ':',
                        style: fontRegular.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                    ],
                  ),
                  SizedBox(
                    width: 400,
                    child: Text(
                      '${parcel.merchantAddress}',
                      style: fontRegular.copyWith(color: kGreyTextColor),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Text(
                    'parcel_info'.tr,
                    style: fontRegular.copyWith(
                        color: kTitleColor,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    thickness: 1.0,
                    color: kGreyTextColor.withOpacity(0.5),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Text(
                        'tracking_id'.tr + ':',
                        style: fontRegular.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${parcel.trackingId}',
                        style: fontRegular.copyWith(color: Colors.blue),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Text(
                        'delivery_type'.tr + ':',
                        style: fontRegular.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${parcel.deliveryType}',
                        style: fontRegular.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Text(
                        'pickup_time'.tr + ':',
                        style: fontRegular.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${parcel.pickupDate}',
                        style: fontRegular.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Text(
                        'delivery_time'.tr + ':',
                        style: fontRegular.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${parcel.deliveryDate}',
                        style: fontRegular.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Text(
                        'total_charge_amount'.tr + ':',
                        style: fontRegular.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${Get.find<GlobalController>().currency!}${parcel.totalDeliveryAmount}',
                        style: fontRegular.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Text(
                        'vat_amount'.tr + ':',
                        style: fontRegular.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${Get.find<GlobalController>().currency!}${parcel.vatAmount}',
                        style: fontRegular.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Text(
                        'current_payable'.tr + ':',
                        style: fontRegular.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${Get.find<GlobalController>().currency!}${parcel.currentPayable}',
                        style: fontRegular.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      Text(
                        'cash_collection'.tr + ':',
                        style: fontRegular.copyWith(
                            color: kTitleColor, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Text(
                        '${Get.find<GlobalController>().currency!}${parcel.cashCollection}',
                        style: fontRegular.copyWith(color: kGreyTextColor),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15.0),
                  Center(
                    child: Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                            color: kMainColor, shape: BoxShape.circle),
                        child: const Icon(
                          FontAwesomeIcons.x,
                          color: kBgColor,
                        )).onTap(
                      () => finish(context),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  List<DropdownMenuItem<String>> get dropdownItems {
    List<DropdownMenuItem<String>> menuItems = [
      DropdownMenuItem(
          child: Text(
            "delivered".tr,
            style: fontRegular.copyWith(
              color: kTitleColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          value: '9'),
      DropdownMenuItem(
          child: Text(
            "partial_delivered".tr,
            style: fontRegular.copyWith(
              color: kTitleColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          value: "32"),
      DropdownMenuItem(
          child: Text(
            "return_to_courier".tr,
            style: fontRegular.copyWith(
              color: kTitleColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          value: "24"),
    ];
    return menuItems;
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void showStatusPopUp(DeliverymanAssign parcel) {
    showDialog(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                'change_status'.tr,
                                style: fontRegular.copyWith(
                                    color: kTitleColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                                padding: const EdgeInsets.all(10.0),
                                decoration: const BoxDecoration(
                                    color: kMainColor, shape: BoxShape.circle),
                                child: const Icon(
                                  FontAwesomeIcons.x,
                                  color: kBgColor,
                                )).onTap(() => finish(context)),
                          ],
                        ),
                        const SizedBox(height: 10.0),
                        Divider(
                          thickness: 1.0,
                          color: kGreyTextColor.withOpacity(0.5),
                        ),
                        FormTitle(title: 'select_status'.tr),
                        dropdownItems.isEmpty
                            ? Container()
                            : Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  height: 48,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: borderColors,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: ButtonTheme(
                                    alignedDropdown: true,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton(
                                          isExpanded: true,
                                          menuMaxHeight:
                                              ScreenSize(context).mainHeight /
                                                  3,
                                          items: dropdownItems,
                                          value: dashboardController.statusID,
                                          onChanged: (String? newValue) {
                                            dashboardController.statusID =
                                                newValue!;

                                            (context as Element)
                                                .markNeedsBuild();
                                          }),
                                    ),
                                  ),
                                ),
                              ),
                        const SizedBox(height: 10.0),
                        dashboardController.statusID == '32'
                            ? FormTitle(title: 'cash_collection_tk'.tr)
                            : SizedBox().marginZero,
                        dashboardController.statusID == '32'
                            ? CustomFormField(
                                controller: dashboardController.cashController,
                                validatorTxt: 'please_type_your_amount'.tr,
                              )
                            : SizedBox().marginZero,
                        const SizedBox(height: 10.0),
                        FormTitle(title: 'note'.tr),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: TextFormField(
                            controller: dashboardController.noteController,
                            textInputAction: TextInputAction.done,
                            keyboardType: TextInputType.text,
                            cursorColor: kMainColor,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 50.0, horizontal: 10.0),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.red,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0),
                                borderSide: BorderSide(
                                  width: 1,
                                  color: Colors.red,
                                ),
                              ),
                              fillColor: Colors.red,
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5)),
                                borderSide:
                                    BorderSide(width: 1, color: kMainColor),
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(5),
                                  bottomLeft: Radius.circular(5),
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                                borderSide:
                                    BorderSide(width: 1, color: borderColors),
                              ),
                            ),
                            onFieldSubmitted: (value) {
                              //add code
                            },
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              child: Container(
                                height: 45,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: kTitleColor,
                                ),
                                child: Center(
                                  child: Text(
                                    'cancel'.tr,
                                    style: fontRegular.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                            TextButton(
                              child: Container(
                                height: 45,
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: kMainColor,
                                ),
                                child: Center(
                                  child: Text(
                                    'yes_sure'.tr,
                                    style: fontRegular.copyWith(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: kBgColor,
                                    ),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                final FormState? form = _formKey.currentState;
                                if (form!.validate()) {
                                  Get.back();
                                  dashboardController.changeStatus(
                                      context, parcel.id.toString());
                                }
                              },
                            )
                          ],
                        ),
                      ],
                    )),
              ),
            ),
          );
        });
  }
}
