import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/result.dart';
import '../data/supabase_auth_repository.dart';
import '../domain/auth_repository.dart';
import '../domain/auth_user.dart';

/// Auth repozitoriysi provideri.
final authRepositoryProvider = Provider<AuthRepository>(
  (ref) => const SupabaseAuthRepository(),
);

/// Joriy auth holatini (kirgan foydalanuvchi yoki null) boshqaradi.
///
/// `build()` sinxron boshlang'ich qiymat qaytaradi (currentUser), so'ng
/// auth oqimini (stream) tinglab, holatni avtomatik yangilaydi. Bu router
/// uchun qulay — splash/redirect darhol to'g'ri qaror qabul qila oladi.
class AuthController extends Notifier<AuthUser?> {
  AuthRepository get _repo => ref.read(authRepositoryProvider);

  @override
  AuthUser? build() {
    final repo = ref.watch(authRepositoryProvider);
    final sub = repo.authStateChanges().listen((user) => state = user);
    ref.onDispose(sub.cancel);
    return repo.currentUser;
  }

  Future<Result<AuthUser>> signIn({
    required String email,
    required String password,
  }) async {
    final result = await _repo.signInWithEmail(email: email, password: password);
    if (result case Ok<AuthUser>(:final value)) {
      state = value;
    }
    return result;
  }

  Future<Result<AuthUser>> signUp({
    required String email,
    required String password,
    String? name,
  }) async {
    final result = await _repo.signUpWithEmail(
      email: email,
      password: password,
      name: name,
    );
    if (result case Ok<AuthUser>(:final value)) {
      state = value;
    }
    return result;
  }

  Future<void> signOut() async {
    await _repo.signOut();
    state = null;
  }
}

final authControllerProvider =
    NotifierProvider<AuthController, AuthUser?>(AuthController.new);
