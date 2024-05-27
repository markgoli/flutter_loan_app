import 'package:lmloan/screens/authentication/forgot_password.dart';
import 'package:lmloan/screens/authentication/login.dart';
import 'package:lmloan/screens/authentication/register.dart';
import 'package:lmloan/screens/loan_dashboard/add_loan/add_loan.dart';
import 'package:lmloan/screens/loan_dashboard/loan_dashboard_screen.dart';
import 'package:lmloan/screens/loan_dashboard/search_loan.dart/search_loan.dart';
import 'package:lmloan/screens/loan_dashboard/view_loan/view_loan.dart';
import 'package:lmloan/screens/splash_screen.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
      // redirect: (context, state) {
      //   // FirebaseAuth auth = FirebaseAuth.instance;

      //   // if (auth.currentUser != null) {
      //     return '/dashboard';
      //   }
      //   // return "/";
      // },
    ),
    GoRoute(
      path: '/register_screen',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/login_screen',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/forgot_password',
      builder: (context, state) => const ForgotPasswordScreen(),
    ),
    GoRoute(
      path: '/loan_dashboard',
      builder: (context, state) => const LoanDashboardScreen(),
    ),
    GoRoute(
      path: '/add_loan',
      builder: (context, state) => const AddLoanScreen(),
    ),
    GoRoute(
      path: '/view_loan',
      builder: (context, state) {
        final loanId = state.uri.queryParameters['loan_id'];
        return ViewLoadScreen(
          loanId: loanId!,
        );
      },
    ),
    GoRoute(
      path: '/search_loan',
      builder: (context, state) => const SearchLoanScreen(),
    )
  ],
);
