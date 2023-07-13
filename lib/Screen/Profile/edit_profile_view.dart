import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:courier/Screen/Widgets/constant.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';

import '../../Controllers/profile_controller.dart';
import '../../utils/image.dart';
import '../../utils/size_config.dart';
import '../../utils/style.dart';
import '../Widgets/loader.dart';
import '../Widgets/shimmer/profile_shimmer.dart';
import '../Widgets/text_field_widget.dart';

//ignore: must_be_immutable
class EditProfileView extends GetView {
  EditProfileView({Key? key}) : super(key: key);

  final ProfileController profileController = ProfileController();
  final _formKey = GlobalKey<FormState>();
  String imageFile = '';

  @override
  Widget build(BuildContext context) {
    SizeConfigCustom sizeConfig = SizeConfigCustom();
    sizeConfig.init(context);
    void _pickFile() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles();

      if (result != null && result.files.single.path != null) {
        PlatformFile imageFiles = result.files.first;
        imageFile = imageFiles.path!;
        (context as Element).markNeedsBuild();
      }
      ;
    }

    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'edit_profile'.tr,
          style: fontRegular.copyWith(
              color: kMainColor,
              fontSize: Dimensions.fontSizeExtraLarge.sp,
              fontWeight: FontWeight.w800),
        ),
        backgroundColor: kBgColor,
        elevation: 0.3,
        iconTheme: const IconThemeData(color: kMainColor),
      ),
      body: GetBuilder<ProfileController>(
        init: ProfileController(),
        builder: (profile) => profile.profileLoader
            ? ProfileShimmer()
            : Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 30.h,),
                          Stack(
                            children: [
                              SizedBox(
                                width: 100.w,
                                height: 100.h,
                                child: Center(
                                    child: imageFile == ''
                                        ? CachedNetworkImage(
                                            imageUrl: profile
                                                .profileUser.user!.image
                                                .toString(),
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    CircleAvatar(
                                              radius: 50.0,
                                              backgroundColor:
                                                  Colors.transparent,
                                              backgroundImage: imageProvider,
                                            ),
                                            placeholder: (context, url) =>
                                                Shimmer.fromColors(
                                              child:
                                                  CircleAvatar(radius: 50.0),
                                              baseColor: Colors.grey[300]!,
                                              highlightColor:
                                                  Colors.grey[400]!,
                                            ),
                                            errorWidget:
                                                (context, url, error) => Icon(
                                              CupertinoIcons.person,
                                              size: 50,
                                            ),
                                          )
                                        : CircleAvatar(
                                            radius: 50.0,
                                            backgroundColor:
                                                Colors.transparent,
                                            backgroundImage: FileImage(
                                                File(imageFile.toString())),
                                          )),
                              ),
                              Positioned(
                                top: 75,
                                right: 20,
                                child: InkWell(
                                  onTap: (() => _pickFile()),
                                  child: SizedBox(
                                    width: 30.w,
                                    height: 30.h,
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      child: SizedBox(
                                        width: 30.w,
                                        height: 30.h,
                                        child: CircleAvatar(
                                          backgroundColor: darkGray,
                                          child: Image.asset(
                                            Images.iconEdit,
                                            fit: BoxFit.cover,
                                            height: 22.h,
                                            width: 22.w,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 20.0.h),
                                GlobalFormField(
                                  controller: profile.nameController
                                    ..text = profile.name
                                    ..selection = TextSelection.collapsed(
                                        offset:
                                        profile.nameController.text.length),
                                  type: TextInputType.name,
                                  validate: (value) {
                                    return null;
                                  },
                                  onChange: (value) {
                                    profile.name = profile.nameController.text;
                                    (context as Element).markNeedsBuild();
                                  },
                                  label: 'name'.tr,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      Images.profileLineIcon,
                                      width: 24.w,
                                      height: 24.h,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.0.h),
                                GlobalFormField(
                                  controller: profile.emailController
                                    ..text = profile.email
                                    ..selection = TextSelection.collapsed(
                                        offset: profile
                                            .emailController.text.length),
                                  type: TextInputType.emailAddress,
                                  validate: (value) {
                                    return null;
                                  },
                                  onChange: (value) {
                                    profile.email =
                                        profile.emailController.text;
                                    (context as Element).markNeedsBuild();
                                  },
                                  label: 'email'.tr,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      Images.emailIcon,
                                      width: 24.w,
                                      height: 24.h,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.0.h),
                                GlobalFormField(
                                  controller: profile.phoneController
                                    ..text = profile.mobile
                                    ..selection = TextSelection.collapsed(
                                        offset: profile
                                            .phoneController.text.length),
                                  type: TextInputType.phone,
                                  validate: (value) {
                                    return null;
                                  },
                                  onChange: (value) {
                                    profile.mobile =
                                        profile.phoneController.text;
                                    (context as Element).markNeedsBuild();
                                  },
                                  label: 'phone'.tr,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      Images.phoneIcon,
                                      width: 24.w,
                                      height: 24.h,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 20.0.h),
                                GlobalFormField(
                                  controller: profile.addressController
                                    ..text = profile.address
                                    ..selection = TextSelection.collapsed(
                                        offset: profile
                                            .addressController.text.length),
                                  type: TextInputType.phone,
                                  validate: (value) {
                                    return null;
                                  },
                                  onChange: (value) {
                                    profile.address =
                                        profile.addressController.text;
                                    (context as Element).markNeedsBuild();
                                  },
                                  label: 'address'.tr,
                                  prefixIcon: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Image.asset(
                                      Images.locationLineIcon,
                                      width: 24.w,
                                      height: 24.h,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30.0.h),
                                ElevatedButton(
                                  onPressed: () async {
                                    if (imageFile == '') {
                                      await profile.updateUserProfile(
                                          imageFile, false);
                                    } else {
                                      await profile.updateUserProfile(
                                          imageFile, true);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: kMainColor,
                                    minimumSize: Size(328.h, 48.w),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    "update".tr,
                                    style: fontMedium,
                                  ),
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  profile.loader
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
    );
  }
}
