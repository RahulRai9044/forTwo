import 'package:for_two/modules/auth/binding/login_binding.dart';
import 'package:for_two/modules/auth/binding/register_binding.dart';
import 'package:for_two/modules/auth/view/login_screen.dart';
import 'package:for_two/modules/auth/view/register_screen.dart';
import 'package:for_two/modules/dashboard/binding/dashboard_binding.dart';
import 'package:for_two/modules/wishlists/view/add_new_wish.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoute {
  AppRoute._();
  static final routes = [
    GetPage(
      name: '/login',
      page: () => const LoginScreen(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: "/register",
      page: () => const RegisterScreen(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: "/addNewWish",
      page: () => const AddNewWish(),
      binding: DashboardBinding(),
    ),
   /* GetPage(
      name: "/account",
      page: () => const AccountPage(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: "/consent",
      page: () => const DoctorConsultationConsent(),
      binding: ConsentBinding(),
    ),
    GetPage(
      name: "/faq",
      page: () => const HelpView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: "/edit-basic-detail",
      page: () => const EditBasicDetails(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: "/add-bp",
      page: () => const AddBPView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: "/dashboard",
      page: () => const DashBoardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: "/view-all",
      page: () => const ViewAllRecord(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: "/forgot-password",
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: "/health-detail",
      page: () => const HealthDetailView(),
      binding: AccountBinding(),
    ),
    GetPage(
      name: "/doctor-selection",
      page: () => const DoctorSelectionScreen(),
      binding: DoctorBinding(),
    ),
    GetPage(
      name: "/contact-page",
      page: () => const ChatView(),
      binding: ChatBinding(),
    ),*/
  ];
}