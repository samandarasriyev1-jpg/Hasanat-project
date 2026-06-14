import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../../../core/error/failure.dart';
import '../../../core/services/supabase_service.dart';
import '../../../core/utils/app_logger.dart';
import '../../../core/utils/result.dart';
import '../domain/auth_repository.dart';
import '../domain/auth_user.dart';

/// `AuthRepository` ning Supabase implementatsiyasi.
///
/// Supabase sozlanmagan bo'lsa (offline rejim), barcha amallar xushmuomala
/// ravishda ishlaydi: `currentUser` null, oqim faqat null chiqaradi, kirish/
/// ro'yxatdan o'tish esa tushunarli `ServerFailure` qaytaradi.
class SupabaseAuthRepository implements AuthRepository {
  const SupabaseAuthRepository();

  bool get _ready => SupabaseService.isInitialized;
  sb.GoTrueClient get _auth => SupabaseService.client.auth;

  AuthUser? _mapUser(sb.User? user) {
    if (user == null) return null;
    final metadata = user.userMetadata;
    final name = metadata?['name'] as String?;
    return AuthUser(id: user.id, email: user.email, name: name);
  }

  @override
  AuthUser? get currentUser => _ready ? _mapUser(_auth.currentUser) : null;

  @override
  Stream<AuthUser?> authStateChanges() {
    if (!_ready) {
      return Stream<AuthUser?>.value(null);
    }
    return _auth.onAuthStateChange.map(
      (event) => _mapUser(event.session?.user),
    );
  }

  @override
  Future<Result<AuthUser>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    if (!_ready) {
      return const Result.err(
        ServerFailure('Supabase sozlanmagan. .env faylini tekshiring.'),
      );
    }
    try {
      final response = await _auth.signInWithPassword(
        email: email.trim(),
        password: password,
      );
      final user = _mapUser(response.user);
      if (user == null) {
        return const Result.err(ServerFailure('Kirish amalga oshmadi.'));
      }
      return Result.ok(user);
    } on sb.AuthException catch (e) {
      AppLogger.warning('Kirish xatosi: ${e.message}');
      return Result.err(ServerFailure(_friendly(e.message)));
    } catch (e, st) {
      AppLogger.error('Kirishda kutilmagan xato', error: e, stackTrace: st);
      return const Result.err(UnknownFailure());
    }
  }

  @override
  Future<Result<AuthUser>> signUpWithEmail({
    required String email,
    required String password,
    String? name,
  }) async {
    if (!_ready) {
      return const Result.err(
        ServerFailure('Supabase sozlanmagan. .env faylini tekshiring.'),
      );
    }
    try {
      final response = await _auth.signUp(
        email: email.trim(),
        password: password,
        data: name == null ? null : <String, dynamic>{'name': name.trim()},
      );
      final user = _mapUser(response.user);
      if (user == null) {
        return const Result.err(
          ServerFailure('Ro\'yxatdan o\'tish amalga oshmadi.'),
        );
      }
      return Result.ok(user);
    } on sb.AuthException catch (e) {
      AppLogger.warning('Ro\'yxatdan o\'tish xatosi: ${e.message}');
      return Result.err(ServerFailure(_friendly(e.message)));
    } catch (e, st) {
      AppLogger.error('Ro\'yxatda kutilmagan xato', error: e, stackTrace: st);
      return const Result.err(UnknownFailure());
    }
  }

  @override
  Future<Result<void>> signOut() async {
    if (!_ready) {
      return const Result.ok(null);
    }
    try {
      await _auth.signOut();
      return const Result.ok(null);
    } catch (e, st) {
      AppLogger.error('Chiqishda xato', error: e, stackTrace: st);
      return const Result.err(UnknownFailure());
    }
  }

  /// Supabase xato matnini foydalanuvchiga tushunarliroq qiladi.
  String _friendly(String raw) {
    final lower = raw.toLowerCase();
    if (lower.contains('invalid login')) {
      return 'Email yoki parol noto\'g\'ri.';
    }
    if (lower.contains('already registered') ||
        lower.contains('already exists')) {
      return 'Bu email allaqachon ro\'yxatdan o\'tgan.';
    }
    return raw;
  }
}
