import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../Controllers/profile_controller.dart';
import '../../utils/image.dart';
import '../../utils/size_config.dart';
import '../../utils/style.dart';
import '../Widgets/constant.dart';
import '../Widgets/loader.dart';
import '../Widgets/text_field_widget.dart';

class ChangePasswordView extends GetView {
  ChangePasswordView({Key? key}) : super(key: key);
  final ProfileController profileController = ProfileController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeConfigCustom sizeConfig = SizeConfigCustom();
    sizeConfig.init(context);
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        title: Text(
          'change_password'.tr,
          style: fontRegular.copyWith(
              fontSize: Dimensions.fontSizeExtraLarge.sp,
              fontWeight: FontWeight.w800,
              color: kMainColor),
        ),
        centerTitle: true,
        elevation: 0.3,
        backgroundColor: kBgColor,
        iconTheme: const IconThemeData(color: kMainColor),
      ),
      body: GetBuilder<ProfileController>(
          init: ProfileController(),
          builder: (profile) => Stack(children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 32.h,
                        ),
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20.h,
                              ),
                              GlobalFormField(
                                  controller: profile.passwordCurrentController,
                                  type: TextInputType.visiblePassword,
                                  validate: (value) => value!.isEmpty
                                      ? 'Enter old password'
                                      : null,
                                  label: 'old_password'.tr,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      Images.lockIcon,
                                      width: 24.w,
                                      height: 24.h,
                                    ),
                                  ),
                                  hintText: '************'),
                              SizedBox(
                                height: 20.h,
                              ),
                              GlobalFormField(
                                  controller: profile.passwordController,
                                  type: TextInputType.visiblePassword,
                                  validate: (value) => value!.isEmpty
                                      ? 'Enter new password'
                                      : null,
                                  label: 'new_password'.tr,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      Images.lockIcon,
                                      width: 24.w,
                                      height: 24.h,
                                    ),
                                  ),
                                  hintText: '************'),
                              SizedBox(
                                height: 20.h,
                              ),
                              GlobalFormField(
                                  controller: profile.passwordConfirmController,
                                  type: TextInputType.visiblePassword,
                                  validate: (value) => value!.isEmpty
                                      ? 'Enter confirmation password'
                                      : null,
                                  label: 'retype_new_password'.tr,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      Images.lockIcon,
                                      width: 24.w,
                                      height: 24.h,
                                    ),
                                  ),
                                  hintText: '************'),
                              SizedBox(
                                height: 30.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      final FormState? form =
                                          _formKey.currentState;
                                      if (form!.validate()) {
                                        profile.updateUserPassword(
                                            context: context);
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: kMainColor,
                                      minimumSize: Size(328.w, 52.h),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    child: Text(
                                      "change_password".tr,
                                      style: fontMedium,
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
                profile.passwordLoader
                    ? Positioned(
                        child: Container(
                            height: MediaQuery.of(context).size.height,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.white60,
                            child: const Center(child: LoaderCircle())),
                      )
                    : const SizedBox.shrink(),
              ])),
    );
  }
}
