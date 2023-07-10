import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../Controllers/global-controller.dart';
import '../../Controllers/parcel_payment_log_controller.dart';
import '../../utils/style.dart';
import '../Widgets/constant.dart';
import 'package:get/get.dart';

import '../Widgets/shimmer/parcel_payment_log_shimmer.dart';

class PaymentParcelHistoryPage extends StatefulWidget {
  const PaymentParcelHistoryPage({Key? key}) : super(key: key);

  @override
  State<PaymentParcelHistoryPage> createState() => _PaymentParcelHistoryState();
}

class _PaymentParcelHistoryState extends State<PaymentParcelHistoryPage> {
  final ParcelPaymentLogController parcelPaymentLogController =
      ParcelPaymentLogController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'parcel_payment_history'.tr,
          style: fontRegular.copyWith(
              color: kMainColor,
              fontSize: Dimensions.fontSizeExtraLarge.sp,
              fontWeight: FontWeight.w800),
        ),
        backgroundColor: kBgColor,
        elevation: 0.3,
        iconTheme: const IconThemeData(color: kBgColor),
      ),
      body: GetBuilder<ParcelPaymentLogController>(
          init: ParcelPaymentLogController(),
          builder: (controller) => Column(
                children: [
                  /// headline section
                  headline(),
                  const Divider(height: 1, color: Colors.grey),

                  /// data section
                  controller.loader
                      ? ParcelPaymentLogShimmer()
                      : data(controller),
                ],
              )),
    );
  }

  /// headline section
  Widget headline() {
    return Card(
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 8.0, top: 20, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "date".tr,
              style: fontRegular.copyWith(
                color: kMainColor,
                fontSize: 18,
              ),
            ),
            Text(
              "note".tr,
              style: fontRegular.copyWith(
                color: kMainColor,
                fontSize: 18,
              ),
            ),
            Text(
              "amount".tr,
              style: fontRegular.copyWith(
                color: kMainColor,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// data Section
  Widget data(ParcelPaymentLogController controller) {
    return Expanded(
      child: controller.parcelPaymentLogList.length == 0
          ? Center(
              child: Text(
                'no_item_found'.tr,
                style: fontRegular.copyWith(
                    color: kMainColor,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
            )
          : Card(
              child: ListView.separated(
                itemCount: controller.parcelPaymentLogList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 88,
                          child: Text(
                            controller.parcelPaymentLogList[index].date
                                .toString(),
                            style: fontRegular.copyWith(
                              color: kTitleColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 190,
                          child: Center(
                            child: Text(
                              controller.parcelPaymentLogList[index].note
                                  .toString(),
                              style: fontRegular.copyWith(
                                color: kTitleColor,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          child: Text(
                            '${Get.find<GlobalController>().currency!}${controller.parcelPaymentLogList[index].amount.toString()}',
                            textAlign: TextAlign.end,
                            style: fontRegular.copyWith(
                              color: kTitleColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider(height: 1, color: Colors.grey.withOpacity(.5));
                },
              ),
            ),
    );
  }
}
