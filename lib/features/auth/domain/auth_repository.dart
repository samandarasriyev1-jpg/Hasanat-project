import '../../../core/utils/result.dart';
import 'auth_user.dart';

/// Autentifikatsiya manbai abstraksiyasi.
///
/// Implementatsiya (Supabase) `data` qatlamida. UI/controller faqat shu
/// interfeysga tayanadi — bu test va backend almashtirishni osonlashtiradi.
abstract interface class AuthRepository {
  /// Joriy (kirgan) foydalanuvchi yoki `null`.
  AuthUser? get currentUser;

  /// Auth holati o'zgarganda (kirish/chiqish) yangi qiymat chiqaradi.
  Stream<AuthUser?> authStateChanges();

  /// Email va parol orqali tizimga kirish.
  Future<Result<AuthUser>> signInWithEmail({
    required String email,
    required String password,
  });

  /// Email va parol orqali ro'yxatdan o'tish.
  Future<Result<AuthUser>> signUpWithEmail({
    required String email,
    required String password,
    String? name,
  });

  /// Tizimdan chiqish.
  Future<Result<void>> signOut();
}
