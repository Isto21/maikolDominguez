import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:maikol_tesis/presentation/pages/auth/activation_page.dart';
import 'package:maikol_tesis/presentation/pages/auth/login_page.dart';
import 'package:maikol_tesis/presentation/pages/auth/register_page.dart';
import 'package:maikol_tesis/presentation/pages/incidents_page.dart';
import 'package:maikol_tesis/presentation/pages/map_page.dart';
import 'package:maikol_tesis/presentation/pages/profile_page.dart';
import 'package:maikol_tesis/presentation/pages/reports_page.dart';
import 'package:maikol_tesis/presentation/pages/splash_screen.dart';
import 'package:maikol_tesis/presentation/views/create_guardia_page.dart';
import 'package:maikol_tesis/presentation/views/guardias_list_page.dart';
import 'package:maikol_tesis/presentation/views/home_page.dart';
import 'package:maikol_tesis/presentation/widgets/shared/main_layout.dart';

class AppRouter {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String activation = '/activation';
  static const String home = '/home';
  static const String guardias = '/guardias';
  static const String createGuardia = '/guardias/create';
  static const String map = '/map';
  static const String incidents = '/incidents';
  static const String profile = '/profile';
  static const String reports = '/reports';
}

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRouter.splash,
    routes: [
      GoRoute(
        path: AppRouter.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRouter.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRouter.register,
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: AppRouter.activation,
        builder: (context, state) {
          final email = state.extra as String;
          return ActivationPage(email: email);
        },
      ),
      ShellRoute(
        builder: (context, state, child) => MainLayout(child: child),
        routes: [
          GoRoute(
            path: AppRouter.home,
            builder: (context, state) => const HomePage(),
          ),
          GoRoute(
            path: AppRouter.guardias,
            builder: (context, state) => const GuardiasListPage(),
          ),
          GoRoute(
            path: AppRouter.createGuardia,
            builder: (context, state) => const CreateGuardiaPage(),
          ),
          GoRoute(
            path: AppRouter.map,
            builder: (context, state) => const MapPage(),
          ),
          GoRoute(
            path: AppRouter.incidents,
            builder: (context, state) => const IncidentsPage(),
          ),
          GoRoute(
            path: AppRouter.profile,
            builder: (context, state) => const ProfilePage(),
          ),
          GoRoute(
            path: AppRouter.reports,
            builder: (context, state) => const ReportsPage(),
          ),
        ],
      ),
    ],
  );
});
