import 'package:courier/Screen/Widgets/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../Controllers/auth-controller.dart';
import '../../utils/image.dart';
import '../../utils/size_config.dart';
import '../../utils/style.dart';
import '../Widgets/button_global.dart';
import 'package:get/get.dart';

import '../Widgets/loader.dart';
import '../Widgets/text_field_widget.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  bool isChecked = true;
  final _formKey = GlobalKey<FormState>();
  late bool _passwordVisible;

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  AuthController authController = AuthController();

  @override
  void initState() {
    _passwordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfigCustom sizeConfig = SizeConfigCustom();
    sizeConfig.init(context);
    return GetBuilder<AuthController>(
      init: AuthController(),
      builder: (auth) => SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: kBgColor,
          body: Stack(
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 80.h,
                      ),
                      Center(
                        child: Container(
                          height: 120.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(Images.appLogo1),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15.0.h,
                      ),
                      Text(
                        'please_enter_your_user_information'.tr,
                        style: fontRegular.copyWith(
                            color: fontColor, fontSize: 18.0),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SizedBox(height: 20.0.h),
                                GlobalFormField(
                                    controller: _emailController,
                                    type: TextInputType.emailAddress,
                                    validate: (value) {
                                      if (_emailController.text.isEmpty) {
                                        return "this_field_can_t_be_empty".tr;
                                      }
                                      return null;
                                    },
                                    label: 'email_mobile'.tr,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(12.0),
                                      child: Image.asset(
                                        Images.emailIcon,
                                        width: 24.w,
                                        height: 24.h,
                                      ),
                                    ),
                                    hintText: 'example@gmail.com'),
                                SizedBox(height: 20.0.h),
                                GlobalFormField(
                                  controller: _passwordController,
                                  type: TextInputType.visiblePassword,
                                  validate: (value) {
                                    if (_passwordController.text.isEmpty) {
                                      return "this_field_can_t_be_empty".tr;
                                    }
                                    return null;
                                  },
                                  label: 'password'.tr,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      Images.lockIcon,
                                      width: 24.w,
                                      height: 24.h,
                                    ),
                                  ),
                                  hintText: '********',
                                  isPassword: _passwordVisible,
                                  suffix: _passwordVisible
                                      ? Image.asset(
                                          Images.viewIcon,
                                          width: 24.w,
                                          height: 24.h,
                                        )
                                      : Image.asset(
                                          Images.hideIcon,
                                          width: 24.w,
                                          height: 24.h,
                                        ),
                                  suffixPressed: () {
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                                SizedBox(height: 10.h),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Checkbox(
                                      activeColor: kMainColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(2.0),
                                      ),
                                      value: isChecked,
                                      onChanged: (val) {
                                        setState(
                                          () {
                                            isChecked = val!;
                                          },
                                        );
                                      },
                                    ),
                                    Text(
                                      'remember_me'.tr,
                                      style: fontRegular.copyWith(
                                          color: kTitleColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                                SizedBox(height: 10.0.h),
                                ButtonGlobal(
                                  buttontext: 'sign_in'.tr,
                                  buttonDecoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: kMainColor),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      auth.loginOnTap(
                                          email: _emailController.text
                                              .toString()
                                              .trim(),
                                          pass: _passwordController.text
                                              .toString()
                                              .trim());
                                    }
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              auth.loader
                  ? Positioned(
                      child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.white60,
                          child: const Center(child: LoaderCircle())),
                    )
                  : const SizedBox.shrink(),
            ],
          ),
        ),
      ),
    );
  }
}
