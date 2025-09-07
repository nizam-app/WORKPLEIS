
import 'package:go_router/go_router.dart';
import 'package:workpleis/core/widget/global_snack_bar.dart';
import 'package:workpleis/features/auth/screens/login_screen.dart';
import 'package:workpleis/features/auth/screens/register_screen.dart';
import 'package:workpleis/features/auth/screens/splash_screen.dart';
import 'package:workpleis/features/home/screen/home_screen.dart';
import 'package:workpleis/features/home/screen/job_details_screen.dart';
import 'package:workpleis/features/home/screen/tasks_screen.dart';
import 'package:workpleis/features/message/screen/chat_screen.dart';
import 'package:workpleis/features/message/screen/message_screen.dart';
import 'package:workpleis/features/projects/screen/special_request_screen3.dart';
import 'package:workpleis/features/verification/screen/verification_screen.dart';
import '../features/Payment/screen/payment_methods_screen.dart';
import '../features/account/screen/account_screen.dart';
import '../features/auth/screens/forgot_screen.dart';
import '../features/auth/screens/new_password_screen.dart';
import '../features/auth/screens/otp_screen.dart';
import '../features/home/screen/post_a_job.dart';
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
  static final String initial = SplashScreen.routeName;

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
        path: SplashScreen.routeName,
        name: SplashScreen.routeName,
        builder: (context, state) => const SplashScreen(),
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
        path: ProjectSetupScreen.routeName,
        name: ProjectSetupScreen.routeName,
        builder: (context, state) => const ProjectSetupScreen(),
      ),GoRoute(
        path: SpecialRequestScreen1.routeName,
        name: SpecialRequestScreen1.routeName,
        builder: (context, state) => const SpecialRequestScreen1(),
      ),GoRoute(
        path: SpecialRequestScreen2.routeName,
        name: SpecialRequestScreen2.routeName,
        builder: (context, state) => const SpecialRequestScreen2(),
      ),GoRoute(
        path: SpecialRequestScreen3.routeName,
        name: SpecialRequestScreen3.routeName,
        builder: (context, state) => const SpecialRequestScreen3(),
      ),GoRoute(
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
        path: ForgotScreen.routeName,
        name: ForgotScreen.routeName,
        builder: (context, state) => const ForgotScreen(),
      ),GoRoute(
        path: OtpScreen.routeName,
        name: OtpScreen.routeName,
        builder: (context, state) => const OtpScreen(),
      ),GoRoute(
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
            path: TasksScreen.routeName,
            name: TasksScreen.routeName,
            builder: (context, state) => const TasksScreen(),
          ),
          GoRoute(
            path: MessageScreen.routeName,
            name: MessageScreen.routeName,
            builder: (context, state) => const MessageScreen(),
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
            path: ChatScreen.routeName,
            name: ChatScreen.routeName,
            builder: (context, state) => const ChatScreen(),
          ), GoRoute(
            path: AccountOverviewScreen.routeName,
            name: AccountOverviewScreen.routeName,
            builder: (context, state) => const AccountOverviewScreen(),
          ), GoRoute(
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
          ),  GoRoute(
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
        ],
      ),
    ],
  );
}