import 'package:get/get.dart';

import '../modules/admin/admin_admin/bindings/admin_admin_binding.dart';
import '../modules/admin/admin_admin/views/admin_admin_view.dart';
import '../modules/admin/article_admin/bindings/article_admin_binding.dart';
import '../modules/admin/article_admin/views/article_admin_view.dart';
import '../modules/admin/dashboard_admin/bindings/dashboard_admin_binding.dart';
import '../modules/admin/dashboard_admin/views/dashboard_admin_view.dart';
import '../modules/admin/dpt_admin/bindings/dpt_admin_binding.dart';
import '../modules/admin/dpt_admin/views/dpt_admin_view.dart';
import '../modules/admin/home_admin/bindings/home_admin_binding.dart';
import '../modules/admin/home_admin/views/home_admin_view.dart';
import '../modules/admin/imported_admin/bindings/imported_admin_binding.dart';
import '../modules/admin/imported_admin/views/imported_admin_view.dart';
import '../modules/admin/profile_admin/bindings/profile_admin_binding.dart';
import '../modules/admin/profile_admin/views/profile_admin_view.dart';
import '../modules/admin/users_admin/bindings/users_admin_binding.dart';
import '../modules/admin/users_admin/views/users_admin_view.dart';
import '../modules/admin/wilayah_admin/bindings/wilayah_admin_binding.dart';
import '../modules/admin/wilayah_admin/views/wilayah_admin_view.dart';
import '../modules/continue_register/bindings/continue_register_binding.dart';
import '../modules/continue_register/views/continue_register_view.dart';
import '../modules/dpt/bindings/dpt_binding.dart';
import '../modules/dpt/views/dpt_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/new_password/bindings/new_password_binding.dart';
import '../modules/new_password/views/new_password_view.dart';
import '../modules/offline/bindings/offline_binding.dart';
import '../modules/offline/views/offline_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/reset_password/bindings/reset_password_binding.dart';
import '../modules/reset_password/views/reset_password_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/user/article_user/bindings/article_user_binding.dart';
import '../modules/user/article_user/views/article_user_view.dart';
import '../modules/user/dashboard_user/bindings/dashboard_user_binding.dart';
import '../modules/user/dashboard_user/views/dashboard_user_view.dart';
import '../modules/user/home_user/bindings/home_user_binding.dart';
import '../modules/user/home_user/views/home_user_view.dart';
import '../modules/user/profile_user/bindings/profile_user_binding.dart';
import '../modules/user/profile_user/views/profile_user_view.dart';
import '../modules/user/recruit_user/bindings/recruit_user_binding.dart';
import '../modules/user/recruit_user/views/recruit_user_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD_ADMIN,
      page: () => const DashboardAdminView(),
      binding: DashboardAdminBinding(),
      transition: Transition.leftToRight,
      transitionDuration: const Duration(milliseconds: 100),
    ),
    GetPage(
      name: _Paths.DASHBOARD_USER,
      page: () => const DashboardUserView(),
      binding: DashboardUserBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_USER,
      page: () => const ProfileUserView(),
      binding: ProfileUserBinding(),
    ),
    GetPage(
      name: _Paths.RECRUIT_USER,
      page: () => const RecruitUserView(),
      binding: RecruitUserBinding(),
    ),
    GetPage(
      name: _Paths.HOME_USER,
      page: () => const HomeUserView(),
      binding: HomeUserBinding(),
    ),
    GetPage(
      name: _Paths.ARTICLE_USER,
      page: () => const ArticleUserView(),
      binding: ArticleUserBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.NEW_PASSWORD,
      page: () => const NewPasswordView(),
      binding: NewPasswordBinding(),
    ),
    GetPage(
      name: _Paths.HOME_ADMIN,
      page: () => const HomeAdminView(),
      binding: HomeAdminBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE_ADMIN,
      page: () => const ProfileAdminView(),
      binding: ProfileAdminBinding(),
    ),
    GetPage(
      name: _Paths.USERS_ADMIN,
      page: () => const UsersAdminView(),
      binding: UsersAdminBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 100),
    ),
    GetPage(
      name: _Paths.ADMIN_ADMIN,
      page: () => const AdminAdminView(),
      binding: AdminAdminBinding(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 100),
    ),
    GetPage(
      name: _Paths.IMPORTED_ADMIN,
      page: () => const ImportedAdminView(),
      binding: ImportedAdminBinding(),
    ),
    GetPage(
      name: _Paths.ARTICLE_ADMIN,
      page: () => const ArticleAdminView(),
      binding: ArticleAdminBinding(),
    ),
    GetPage(
      name: _Paths.CONTINUE_REGISTER,
      page: () => const ContinueRegisterView(),
      binding: ContinueRegisterBinding(),
    ),
    GetPage(
      name: _Paths.DPT_ADMIN,
      page: () => const DptAdminView(),
      binding: DptAdminBinding(),
    ),
    GetPage(
      name: _Paths.DPT,
      page: () => const DptView(),
      binding: DptBinding(),
    ),
    GetPage(
      name: _Paths.WILAYAH_ADMIN,
      page: () => WilayahAdminView(),
      binding: WilayahAdminBinding(),
    ),
    GetPage(
      name: _Paths.OFFLINE,
      page: () => const OfflineView(),
      binding: OfflineBinding(),
    ),
  ];
}
