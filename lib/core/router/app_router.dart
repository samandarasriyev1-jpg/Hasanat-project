import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/application/auth_controller.dart';
import '../../features/auth/presentation/sign_in_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/onboarding/application/onboarding_controller.dart';
import '../../features/onboarding/splash_screen.dart';
import '../../features/onboarding/welcome_screen.dart';

/// Splash animatsiyasi tugaganini bildiradi. Splash ekrani buni `true` qiladi,
/// shundan keyin router foydalanuvchini kerakli ekranga yo'naltiradi.
final splashCompletedProvider = StateProvider<bool>((ref) => false);

/// Ilova routeri. Auth va onboarding holatiga qarab avtomatik yo'naltiradi.
final goRouterProvider = Provider<GoRouter>((ref) {
  final notifier = _RouterNotifier(ref);
  ref.onDispose(notifier.dispose);
  return GoRouter(
    initialLocation: '/',
    refreshListenable: notifier,
    redirect: notifier.redirect,
    routes: <RouteBase>[
      GoRoute(path: '/', builder: (_, __) => const SplashScreen()),
      GoRoute(path: '/welcome', builder: (_, __) => const WelcomeScreen()),
      GoRoute(path: '/sign-in', builder: (_, __) => const SignInScreen()),
      GoRoute(path: '/home', builder: (_, __) => const HomeScreen()),
    ],
  );
});

/// Auth/onboarding/splash holati o'zgarganda routerni qayta baholashga undaydi.
class _RouterNotifier extends ChangeNotifier {
  _RouterNotifier(this._ref) {
    _ref.listen(splashCompletedProvider, (_, __) => notifyListeners());
    _ref.listen(onboardingControllerProvider, (_, __) => notifyListeners());
    _ref.listen(authControllerProvider, (_, __) => notifyListeners());
  }

  final Ref _ref;

  String? redirect(BuildContext context, GoRouterState state) {
    final splashDone = _ref.read(splashCompletedProvider);
    final onboardingSeen = _ref.read(onboardingControllerProvider);
    final isLoggedIn = _ref.read(authControllerProvider) != null;
    final loc = state.matchedLocation;

    // 1) Splash animatsiyasi tugamaguncha splashda turamiz.
    if (!splashDone) {
      return loc == '/' ? null : '/';
    }

    // 2) Onboarding ko'rilmagan bo'lsa — welcome.
    if (!onboardingSeen) {
      return loc == '/welcome' ? null : '/welcome';
    }

    // 3) Kirilmagan bo'lsa — sign-in.
    if (!isLoggedIn) {
      return loc == '/sign-in' ? null : '/sign-in';
    }

    // 4) Kirilgan bo'lsa — kirish/splash/welcome ekranlaridan home ga.
    if (loc == '/' || loc == '/welcome' || loc == '/sign-in') {
      return '/home';
    }
    return null;
  }
}
