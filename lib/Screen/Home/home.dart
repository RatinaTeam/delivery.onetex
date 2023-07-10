import 'package:courier/Screen/Home/dashboard.dart';
import 'package:courier/Screen/Payment/payment.dart';
import 'package:courier/Screen/Profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
                  color: kMainColor, fontSize: 13, fontWeight: FontWeight.w700),
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
              icon: Icon(
                Icons.home_outlined,
                size: 28.0,
                color: grayColor,
              ),
              selectedIcon: Icon(Icons.home, size: 28.0.h, color: kMainColor),
              label: "home".tr,
            ),
            NavigationDestination(
              icon: Icon(
                CupertinoIcons.square_list,
                size: 28.0,
                color: grayColor,
              ),
              selectedIcon:
              Icon(CupertinoIcons.square_list_fill, size: 28.0, color: kMainColor),
              label: "payment_log".tr,
            ),
            NavigationDestination(
              icon: Icon(
                Icons.payments_outlined,
                size: 28.0,
                color: grayColor,
              ),
              selectedIcon:
              Icon(Icons.payments, size: 28.0, color: kMainColor),
              label: "parcel_payment_history".tr,
            ),
            NavigationDestination(
              icon: Icon(
                Icons.person_2_outlined,
                size: 28.0,
                color: grayColor,
              ),
              selectedIcon: Icon(Icons.person_2, size: 28.0, color: kMainColor),
              label: "profile".tr,
            ),
          ],
        ),
      ),
    );
  }
}
