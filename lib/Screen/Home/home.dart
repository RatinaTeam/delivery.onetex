import 'package:courier/Screen/Home/dashboard.dart';
import 'package:courier/Screen/Payment/payment.dart';
import 'package:courier/Screen/Profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/image.dart';
import '../../utils/style.dart';
import '../Payment/payment_parcel_history.dart';
import '../Widgets/constant.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSelected = true;
  int _currentPage = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    DashBoard(),
    PaymentPage(),
    PaymentParcelHistoryPage(),
    Profile(),
  ];
//              "payment_log".tr,   FontAwesomeIcons.clipboardList
  //              "parcel_payment_history".tr,               FontAwesomeIcons.paperPlane,
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: _widgetOptions.elementAt(_currentPage),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
            indicatorColor: kMainColor.withOpacity(0.2),
            labelTextStyle: MaterialStateProperty.all(
              fontRegular.copyWith(
                  color: kMainColor, fontSize: 10.sp, fontWeight: FontWeight.w700),
            ),
            labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected),
        child: NavigationBar(
          height: 70.h,
          backgroundColor: kBgColor,
          selectedIndex: _currentPage,
          animationDuration: Duration(seconds: 0),
          onDestinationSelected: (index) => setState(() {
            _currentPage = index;
          }),
          destinations: [
            NavigationDestination(
              icon: Image.asset(
                Images.homeLineIcon,
                width: 28.w,
                color: grayColor,
              ),
              selectedIcon: Image.asset(
                Images.homeIcon,
                width: 28.w,
                color: kMainColor,
              ),
              label: "home".tr,
            ),
            NavigationDestination(
              icon: Image.asset(
                Images.paperLineIcon,
                width: 28.w,
                color: grayColor,
              ),
              selectedIcon: Image.asset(
                Images.paperIcon ,
                width: 28.w,
                color: kMainColor,
              ),
              label: "payment_log".tr,
            ),
            NavigationDestination(
              icon: Image.asset(
                Images.transactionsLineIcon,
                width: 28.w,
                color: grayColor,
              ),
              selectedIcon: Image.asset(
                Images.transactionsIcon ,
                width: 28.w,
                color: kMainColor,
              ),
              label: "parcel_payment_history".tr,
            ),
            NavigationDestination(
              icon: Image.asset(
                Images.profileLineIcon,
                width: 28.w,
                color: grayColor,
              ),
              selectedIcon: Image.asset(
                Images.profileIcon ,
                width: 28.w,
                color: kMainColor,
              ),
              label: "profile".tr,
            ),
          ],
        ),
      ),
    );
  }
}
