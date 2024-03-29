import 'package:get/get.dart';

import '../modules/CameraDesign/bindings/camera_design_binding.dart';
import '../modules/CameraDesign/views/camera_design_view.dart';
import '../modules/CompletedRideDetails/bindings/completed_ride_details_binding.dart';
import '../modules/CompletedRideDetails/views/completed_ride_details_view.dart';
import '../modules/InputCardDetails/bindings/input_card_details_binding.dart';
import '../modules/InputCardDetails/views/input_card_details_view.dart';
import '../modules/Report/bindings/report_binding.dart';
import '../modules/Report/views/report_view.dart';
import '../modules/ReportAnIssue/bindings/report_an_issue_binding.dart';
import '../modules/ReportAnIssue/views/report_an_issue_view.dart';
import '../modules/TotalPayment/bindings/total_payment_binding.dart';
import '../modules/TotalPayment/views/total_payment_view.dart';
import '../modules/Zone/bindings/zone_binding.dart';
import '../modules/Zone/views/zone_view.dart';
import '../modules/booking/bindings/booking_binding.dart';
import '../modules/booking/views/booking_view.dart';
import '../modules/documentTypeList/bindings/document_type_list_binding.dart';
import '../modules/documentTypeList/views/document_type_list_view.dart';
import '../modules/help/bindings/help_binding.dart';
import '../modules/help/views/help_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/insuranceVerification/bindings/insurance_verification_binding.dart';
import '../modules/insuranceVerification/views/insurance_verification_view.dart';
import '../modules/licenceVerificationForm/bindings/licence_verification_form_binding.dart';
import '../modules/licenceVerificationForm/views/licence_verification_form_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/paymentFinalDetails/bindings/payment_final_details_binding.dart';
import '../modules/paymentFinalDetails/views/payment_final_details_view.dart';
import '../modules/preInsuranceVerification/bindings/pre_insurance_verification_binding.dart';
import '../modules/preInsuranceVerification/views/pre_insurance_verification_view.dart';
import '../modules/preLicenceVerification/bindings/pre_licence_verification_binding.dart';
import '../modules/preLicenceVerification/views/pre_licence_verification_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/rideBooked/bindings/ride_booked_binding.dart';
import '../modules/rideBooked/views/ride_booked_view.dart';
import '../modules/rideHistory/bindings/ride_history_binding.dart';
import '../modules/rideHistory/views/ride_history_view.dart';
import '../modules/savedCards/bindings/saved_cards_binding.dart';
import '../modules/savedCards/views/saved_cards_view.dart';
import '../modules/settings/bindings/settings_binding.dart';
import '../modules/settings/views/settings_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/viewInsurance/bindings/view_insurance_binding.dart';
import '../modules/viewInsurance/views/view_insurance_view.dart';
import '../modules/viewLicence/bindings/view_licence_binding.dart';
import '../modules/viewLicence/views/view_licence_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.SETTINGS,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.PRE_LICENCE_VERIFICATION,
      page: () => const PreLicenceVerificationView(),
      binding: PreLicenceVerificationBinding(),
    ),
    GetPage(
      name: _Paths.LICENCE_VERIFICATION_FORM,
      page: () => const LicenceVerificationFormView(),
      binding: LicenceVerificationFormBinding(),
    ),
    GetPage(
      name: _Paths.PRE_INSURANCE_VERIFICATION,
      page: () => const PreInsuranceVerificationView(),
      binding: PreInsuranceVerificationBinding(),
    ),
    GetPage(
      name: _Paths.INSURANCE_VERIFICATION,
      page: () => const InsuranceVerificationView(),
      binding: InsuranceVerificationBinding(),
    ),
    GetPage(
      name: _Paths.HELP,
      page: () => const HelpView(),
      binding: HelpBinding(),
    ),
    GetPage(
      name: _Paths.RIDE_HISTORY,
      page: () => const RideHistoryView(),
      binding: RideHistoryBinding(),
    ),
    GetPage(
      name: _Paths.VIEW_LICENCE,
      page: () => ViewLicenceView(),
      binding: ViewLicenceBinding(),
    ),
    GetPage(
      name: _Paths.VIEW_INSURANCE,
      page: () => ViewInsuranceView(),
      binding: ViewInsuranceBinding(),
    ),
    GetPage(
      name: _Paths.DOCUMENT_TYPE_LIST,
      page: () => DocumentTypeListView(),
      binding: DocumentTypeListBinding(),
    ),
    GetPage(
      name: _Paths.RIDE_BOOKED,
      page: () => RideBookedView(),
      binding: RideBookedBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING,
      page: () => BookingView(),
      binding: BookingBinding(),
    ),
    GetPage(
      name: _Paths.REPORT,
      page: () => ReportView(),
      binding: ReportBinding(),
    ),
    GetPage(
      name: _Paths.COMPLETED_RIDE_DETAILS,
      page: () => CompletedRideDetailsView(),
      binding: CompletedRideDetailsBinding(),
    ),
    GetPage(
      name: _Paths.REPORT_AN_ISSUE,
      page: () => const ReportAnIssueView(),
      binding: ReportAnIssueBinding(),
    ),
    GetPage(
      name: _Paths.SAVED_CARDS,
      page: () => const SavedCardsView(),
      binding: SavedCardsBinding(),
    ),
    GetPage(
      name: _Paths.INPUT_CARD_DETAILS,
      page: () => InputCardDetailsView(),
      binding: InputCardDetailsBinding(),
    ),
    GetPage(
      name: _Paths.CAMERA_DESIGN,
      page: () => CameraDesignView(),
      binding: CameraDesignBinding(),
    ),
    GetPage(
      name: _Paths.ZONE,
      page: () => ZoneView(),
      binding: ZoneBinding(),
    ),
    GetPage(
      name: _Paths.TOTAL_PAYMENT,
      page: () => const TotalPaymentView(),
      binding: TotalPaymentBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_FINAL_DETAILS,
      page: () => const PaymentFinalDetailsView(),
      binding: PaymentFinalDetailsBinding(),
    ),
  ];
}
