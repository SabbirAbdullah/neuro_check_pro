
import 'package:get/get.dart';
import 'package:neuro_check_pro/app/modules/assessment/bindings/assessment_bindings.dart';
import 'package:neuro_check_pro/app/modules/authentication/signin/bindings/signing_bindings.dart';
import 'package:neuro_check_pro/app/modules/primary_assessment/bindngs/primary_assessment_binding.dart';
import 'package:neuro_check_pro/app/modules/profile/bindings/profile_binding.dart';
import 'package:neuro_check_pro/app/modules/profile/views/profile_view.dart';
import 'package:neuro_check_pro/app/modules/resume_diagnosis/bindings/diagnosis_binding.dart';
import 'package:neuro_check_pro/app/modules/resume_diagnosis/views/diagnosis_view.dart';

import '../modules/assessment/views/assessment_view.dart';
import '../modules/authentication/signin/widgets/email_signin.dart';
import '../modules/authentication/signup/bindings/signup_binding.dart';
import '../modules/authentication/signup/views/signup_form.dart';
import '../modules/authentication/signup/views/signup_view.dart';
import '../modules/bottom_navigation/bindings/bottom_navigation_binding.dart';
import '../modules/bottom_navigation/views/bottom_navigation_view.dart';
import '../modules/dashboard/bindings/dashboard_bindings.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/onboardings/bindings/onboarding_binding.dart';
import '../modules/onboardings/views/onboarding_view.dart';
import '../modules/primary_assessment/widgets/hero_page.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.ON_BOARDINGS;
  // static const INITIAL = Routes.BOTTOM_NAVIGATION;
  static final routes = [

    GetPage(
      name: _Paths.ON_BOARDINGS,
      page: () => OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => SignupView(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.SIGNIN,
      page: () => EmailSignIn(),
      binding: SignInBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP_FORM,
      page: () => SignupForm(),
      binding: SignupBinding(),
    ),

    GetPage(
      name: _Paths.DASHBOARD,
      page: () => DashboardView(),
      binding: DashboardBindings(),
    ),
    GetPage(
      name: _Paths.PRIMARY_ASSESSMENT,
      page: () => HeroPage(),
      binding: PrimaryAssessmentBinding(),
    ),
    GetPage(
      name: _Paths.BOTTOM_NAVIGATION,
      page: () => BottomNavigationView(),
      binding: BottomNavigationBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),

    GetPage(
      name: _Paths.ASSESSMENT,
      page: () => AssessmentView(),
      binding: AssessmentBindings(),
    ),

    GetPage(
      name: _Paths.DIAGNOSIS,
      page: () => DiagnosisView(),
      binding: DiagnosisBinding(),
    ),

  ];
}