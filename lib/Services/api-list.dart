class APIList {
  static String? server = "https://weapps.wemaxdevs.com/api/v10/";
  static String? apiUrl = "weapps.wemaxdevs.com";
  static String? apiCheckKey = "123456rx-ecourier123456";
  static String? apiEndPoint = "/api/v10/";
  static String? login = "${server!}deliveryman/login";
  static String? logout = "${server!}sign-out";
  static String? refreshToken = "${server!}refresh";
  static String? otpLogin = "${server!}otp-login";
  static String? otpResend = "${server!}resend-otp";
  static String? verifyOtp = "${server!}otp-verification";
  static String? device = "${server!}device";
  static String? fcmSubscribe = "${server!}fcm-subscribe";
  static String? fcmUnSubscribe = "${server!}fcm-unsubscribe";
  static String? profile = "${server!}deliveryman/profile";
  static String? generalSettings = "${server!}general-settings";
  static String? profileUpdate = "${server!}profile/update";
  static String? passwordUpdate = "${server!}update-password";
  static String? dashboard = "${server!}deliveryman/dashboard";
  static String? paymentLogs = "${server!}deliveryman/payment-logs";
  static String? paymentParcelLogs = "${server!}deliveryman/parcel-payment-logs";
  static String? changeStatus = "deliveryman/parcel-status-update";

}
