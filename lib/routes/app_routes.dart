
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/widget/global_snack_bar.dart';
import 'package:workpleis/features/account/screen/client_account.dart';
import 'package:workpleis/features/account/screen/profile_edit_screen.dart';
import 'package:workpleis/features/auth/screens/add_payment_method_screen.dart';
import 'package:workpleis/features/auth/screens/address_and_password.dart';
import 'package:workpleis/features/auth/screens/bisiness_password_screen.dart';
import 'package:workpleis/features/auth/screens/business_verification_screen.dart';
import 'package:workpleis/features/auth/screens/enter_your_phone_number.dart';
import 'package:workpleis/features/auth/screens/forget_verification_code_screen.dart';
import 'package:workpleis/features/auth/screens/get_started_screen.dart';
import 'package:workpleis/features/auth/screens/indentity_verification_screen.dart';
import 'package:workpleis/features/auth/screens/login_screen.dart';
import 'package:workpleis/features/auth/screens/phone_number_verification.dart';
import 'package:workpleis/features/auth/screens/register_screen.dart';
import 'package:workpleis/features/community_guidenlines/screen/community_guidenlines_screen.dart';
import 'package:workpleis/features/community_guidenlines/screen/privacy_policy_screen.dart';
import 'package:workpleis/features/community_guidenlines/screen/terms_and_conditions_screen.dart';
import 'package:workpleis/features/home/screen/Service_home_screen.dart';
import 'package:workpleis/features/home/screen/client_home_screen.dart';
import 'package:workpleis/features/home/screen/job_details_screen.dart';
import 'package:workpleis/features/home/screen/see_all_jobs_screen.dart';
import 'package:workpleis/features/jobs/screen/Service_jobs_details.dart';
import 'package:workpleis/features/jobs/screen/jobs_offers.dart';
import 'package:workpleis/features/jobs/screen/jobs_screen.dart';
import 'package:workpleis/features/jobs/screen/jobs_tracking.dart';
import 'package:workpleis/features/jobs/screen/service_jobs.dart';
import 'package:workpleis/features/message/screen/chat_screen.dart';
import 'package:workpleis/features/nav_bar/screen/service_bottom_nav_bar.dart';
import 'package:workpleis/features/onboarding/screen/onboarding_screen_01.dart';
import 'package:workpleis/features/onboarding/screen/onboarding_screen_02.dart';
import 'package:workpleis/features/onboarding/screen/onboarding_screen_001.dart';
import 'package:workpleis/features/onboarding/screen/onboarding_screen_04.dart';
import 'package:workpleis/features/projects/screen/special_request_screen3.dart';
import 'package:workpleis/features/projects/screen/view_proposal_screen.dart';
import 'package:workpleis/features/security/screen/settings_screen.dart';
import 'package:workpleis/features/verification/screen/verification_screen.dart';
import 'package:workpleis/features/wallet/screen/wallet_screen.dart';
import '../features/Payment/screen/payment_methods_screen.dart';
import '../features/account/screen/account_screen.dart';
import '../features/auth/screens/enter_your_email.dart';
import '../features/auth/screens/forget_password_screen.dart';
import '../features/auth/screens/new_password_screen.dart';
import '../features/auth/screens/email_verification.dart';
import '../features/home/screen/post_job_screen.dart';
import '../features/my_task/screen/applicants_screen.dart';
import '../features/my_task/screen/my_task_screen.dart';
import '../features/nav_bar/screen/bottom_nav_bar.dart';
import '../features/notification/screen/notificaition_screen.dart';
import '../features/notification/screen/notification_setting_screen.dart';
import '../features/projects/screen/project_screen.dart';
import '../features/projects/screen/recieved_request.dart';
import '../features/projects/screen/request_tracker.dart';
import '../features/projects/screen/spcial_request_screen1.dart';
import '../features/projects/screen/special_request_screen.dart';
import '../features/projects/screen/special_request_screen2.dart';
import '../features/security/screen/security_contact_screen.dart';
import '../features/security/screen/security_faq_screen.dart';
import '../features/security/screen/security_guide_screen.dart';
import '../features/security/screen/security_screen.dart';
import 'error_screen.dart';

class AppRouter {
  static final String initial = OnboardingScreen01.routeName;

  static final GoRouter appRouter = GoRouter(
    initialLocation: initial,
    errorBuilder: (context, state) {
      final String badPath = state.uri.toString();
      return CustomGoErrorPage(
        location: badPath,
        error: state.error,
        onRetry: () => context.go(initial),
        onReport: () {
          GlobalSnackBar.show(
            context,
            title: "We're sorry",
            message: "'Thanks, we'll look into this.'",
          );
        },
      );
    },
    routes: [
      /// 🚀 No BottomNavBar Routes
      GoRoute(
        path: PrivacyPolicyScreen.routeName,
        name: PrivacyPolicyScreen.routeName,
        builder: (context, state) => const PrivacyPolicyScreen(),
      ),GoRoute(
        path: ForgetVerificationCodeScreen.routeName,
        name: ForgetVerificationCodeScreen.routeName,
        builder: (context, state) => const ForgetVerificationCodeScreen(),
      ), GoRoute(
        path: ForgetPasswordScreen.routeName,
        name: ForgetPasswordScreen.routeName,
        builder: (context, state) => const ForgetPasswordScreen(),
      ),GoRoute(
        path: CommunityGuidenlinesScreen.routeName,
        name: CommunityGuidenlinesScreen.routeName,
        builder: (context, state) => const CommunityGuidenlinesScreen(),
      ),GoRoute(
        path: TermsAndConditionsScreen.routeName,
        name: TermsAndConditionsScreen.routeName,
        builder: (context, state) => const TermsAndConditionsScreen(),
      ),GoRoute(
        path: AddPaymentMethodScreen.routeName,
        name: AddPaymentMethodScreen.routeName,
        builder: (context, state) => const AddPaymentMethodScreen(),
      ),GoRoute(
        path: BusinessPasswordScreen.routeName,
        name: BusinessPasswordScreen.routeName,
        builder: (context, state) => const BusinessPasswordScreen(),
      ), GoRoute(
        path: BusinessVerificationScreen.routeName,
        name: BusinessVerificationScreen.routeName,
        builder: (context, state) => const BusinessVerificationScreen(),
      ),  GoRoute(
        path: IndentityVerificationScreen.routeName,
        name: IndentityVerificationScreen.routeName,
        builder: (context, state) => const IndentityVerificationScreen(),
      ),  GoRoute(
        path: GetStartedScreen.routeName, // 👈 no :param in path
        name: GetStartedScreen.routeName,
        builder: (context, state) {
          // 👇 safely read optional value
          final title = state.extra is String ? state.extra as String : null;
          return GetStartedScreen(title: title);
        },
      ),

      GoRoute(
        path: AddressAndPassword.routeName,
        name: AddressAndPassword.routeName,
        builder: (context, state) => const AddressAndPassword(),
      ), GoRoute(
        path: EnterYourPhoneNumber.routeName,
        name: EnterYourPhoneNumber.routeName,
        builder: (context, state) => const EnterYourPhoneNumber(),
      ), GoRoute(
        path: PhoneNumberVerification.routeName,
        name: PhoneNumberVerification.routeName,
        builder: (context, state) => const PhoneNumberVerification(),
      ), GoRoute(
        path: OnboardingScreen02.routeName,
        name: OnboardingScreen02.routeName,
        builder: (context, state) {
          final screenName = state.extra is String ? state.extra as String : null;
          return OnboardingScreen02(screenName: screenName);
        },
      ),
      GoRoute(
        path: OnboardingScreen01.routeName,
        name: OnboardingScreen01.routeName,
        builder: (context, state) => const OnboardingScreen01(),
      ), GoRoute(
        path: OnboardingScreen03.routeName,
        name: OnboardingScreen03.routeName,
        builder: (context, state) => const OnboardingScreen03(),
      ),GoRoute(
        path: OnboardingScreen04.routeName,
        name: OnboardingScreen04.routeName,
        builder: (context, state) => const OnboardingScreen04(),
      ),
      GoRoute(
        path: LoginScreen.routeName,
        name: LoginScreen.routeName,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RegisterScreen.routeName,
        name: RegisterScreen.routeName,
        builder: (context, state) =>  RegisterScreen(),
      ),
    GoRoute(
        path: ReceivedRequest.routeName,
        name: ReceivedRequest.routeName,
        builder: (context, state) => const ReceivedRequest(),
      ),GoRoute(
        path: RequestTrackerScreen.routeName,
        name: RequestTrackerScreen.routeName,
        builder: (context, state) => const RequestTrackerScreen(),
      ),
       GoRoute(
        path: PostJobScreen.routeName,
        name: PostJobScreen.routeName,
        builder: (context, state) => const PostJobScreen(),
      ),GoRoute(
        path: SecurityScreen.routeName,
        name: SecurityScreen.routeName,
        builder: (context, state) => const SecurityScreen(),
      ),GoRoute(
        path: SecurityFAQScreen.routeName,
        name: SecurityFAQScreen.routeName,
        builder: (context, state) => const SecurityFAQScreen(),
      ),GoRoute(
        path: EnterYourEmail.routeName,
        name: EnterYourEmail.routeName,
        builder: (context, state) => const EnterYourEmail(),
      ),GoRoute(
        path: EmailVerification.routeName,
        name: EmailVerification.routeName,
        builder: (context, state) => const EmailVerification(),
      ),
      GoRoute(
        path: NewPasswordScreen.routeName,
        name: NewPasswordScreen.routeName,
        builder: (context, state) => const NewPasswordScreen(),
      ),


      /// 🚀 ShellRoute with BottomNavBar
      ShellRoute(
        builder: (context, state, child) {
          return BottomNavBar(child: child); // ✅ pass child
        },

        routes: [
          GoRoute(
            path: HomeScreen.routeName,
            name: HomeScreen.routeName,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: SeeAllJobsScreen.routeName,
            name: SeeAllJobsScreen.routeName,
            builder: (context, state) => const SeeAllJobsScreen(),
          ),
          GoRoute(
            path: VerificationScreen.routeName,
            name: VerificationScreen.routeName,
            builder: (context, state) => const VerificationScreen(),
          ),

          /// 👇 Detail screens (still inside Shell but BottomNavBar will stay)
          GoRoute(
            path: JobDetailScreen.routeName,
            name: JobDetailScreen.routeName,
            builder: (context, state) => const JobDetailScreen(),
          ),

          GoRoute(
            path: ServiceJobDetails.routeName,
            name: ServiceJobDetails.routeName,
            builder: (context, state) =>  ServiceJobDetails(),
          ),
          
          GoRoute(
            path: ChatScreen.routeName,
            name: ChatScreen.routeName,
            builder: (context, state) => const ChatScreen(),
          ),
          GoRoute(
            path: AccountOverviewScreen.routeName,
            name: AccountOverviewScreen.routeName,
            builder: (context, state) => const AccountOverviewScreen(),
          ),
          GoRoute(
            path: AccountOverviewClientScreen.routeName,
            name: AccountOverviewClientScreen.routeName,
            builder: (context, state) => const AccountOverviewClientScreen(),
          ),

          GoRoute(
            path: EditProfileScreen.routeName,
            name: EditProfileScreen.routeName,
            builder: (context, state) => const EditProfileScreen(),
          ),
          GoRoute(
            path: ProjectScreen.routeName,
            name: ProjectScreen.routeName,
            builder: (context, state) => const ProjectScreen(),
          ), GoRoute(
            path: NotificationSettingScreen.routeName,
            name: NotificationSettingScreen.routeName,
            builder: (context, state) => const NotificationSettingScreen(),
          ), GoRoute(
            path: SecurityContactScreen.routeName,
            name: SecurityContactScreen.routeName,
            builder: (context, state) => const SecurityContactScreen(),
          ),
          GoRoute(
            path: SettingsScreen.routeName,
            name: SettingsScreen.routeName,
            builder: (context, state) => const SettingsScreen(),
          ),

          GoRoute(
            path: JobsScreen.routeName,
            name: JobsScreen.routeName,
            builder: (context, state) => const JobsScreen(),
          ),

          GoRoute(
            path: JobsOffers.routeName,
            name: JobsOffers.routeName,
            builder: (context, state) => const JobsOffers(),
          ),


          GoRoute(
            path: WalletScreen.routeName,
            name: WalletScreen.routeName,
            builder: (context, state) => const WalletScreen(),
          ),


          GoRoute(
            path: JobsTracking.routeName,
            name: JobsTracking.routeName,
            builder: (context, state) =>  const JobsTracking(status: " "),
          ),

          GoRoute(
            path: ServiceJobs.routeName,
            name: ServiceJobs.routeName,
            builder: (context, state) =>  const ServiceJobs(),
         ),
    
          GoRoute(
            path: SecurityGuideScreen.routeName,
            name: SecurityGuideScreen.routeName,
            builder: (context, state) => const SecurityGuideScreen(),
          ), GoRoute(
            path: PaymentMethodsScreen.routeName,
            name: PaymentMethodsScreen.routeName,
            builder: (context, state) => const PaymentMethodsScreen(),
          ),GoRoute(
            path: NotificationsScreen.routeName,
            name: NotificationsScreen.routeName,
            builder: (context, state) =>  NotificationsScreen(),
          ),GoRoute(
            path: MyTaskScreen.routeName,
            name: MyTaskScreen.routeName,
            builder: (context, state) =>  MyTaskScreen(),
          ),GoRoute(
            path: ApplicantsScreen.routeName,
            name: ApplicantsScreen.routeName,
            builder: (context, state) =>  ApplicantsScreen(),
          ),
          GoRoute(
            path: ProjectSetupScreen.routeName,
            name: ProjectSetupScreen.routeName,
            builder: (context, state) => const ProjectSetupScreen(),
          ),
          GoRoute(
            path: SpecialRequestScreen3.routeName,
            name: SpecialRequestScreen3.routeName,
            builder: (context, state) => const SpecialRequestScreen3(),
          ),
          GoRoute(
            path: SpecialRequestScreen1.routeName,
            name: SpecialRequestScreen1.routeName,
            builder: (context, state) => const SpecialRequestScreen1(),
          ),
          GoRoute(
            path: SpecialRequestScreen2.routeName,
            name: SpecialRequestScreen2.routeName,
            builder: (context, state) => const SpecialRequestScreen2(),
          ), GoRoute(
            path: ViewProposalScreen.routeName,
            name: ViewProposalScreen.routeName,
            builder: (context, state) => const ViewProposalScreen(),
          ),
          GoRoute(
            path: ServiceHomeScreen.routeName,
            name: ServiceHomeScreen.routeName,
            builder: (context, state) =>  ServiceHomeScreen(),
          ),
        ],
      ),
    ],
  );
  
}
