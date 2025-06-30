import 'package:go_router/go_router.dart';
import 'package:news_app/core/router/app_routes.dart';
import 'package:news_app/features/auth/presentation/screens/confirm_email_screen.dart';
import 'package:news_app/features/auth/presentation/screens/create_account_screen.dart';
import 'package:news_app/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:news_app/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:news_app/features/home/pages.dart';
import 'package:news_app/features/home/presentation/screens/home_screen.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppRoutes.pages,
    routes: [
      GoRoute(
        path: AppRoutes.signUp,
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: AppRoutes.confirmEmail,
        builder: (context, state) => ConfirmEmailScreen(),
      ),
      GoRoute(
        path: AppRoutes.createPassword,
        builder: (context, state) => CreateAccountScreen(),
      ),
      GoRoute(
        path: AppRoutes.signIn,
        builder: (context, state) => SignInScreen(),
      ),
      GoRoute(
        path: AppRoutes.homeTopNews,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(path: AppRoutes.pages, builder: (context, state) => Pages()),
    ],
  );
}
