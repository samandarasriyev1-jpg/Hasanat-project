/// Autentifikatsiya qilingan foydalanuvchini ifodalovchi o'zgarmas model.
///
/// Bu model backend'ga (Supabase) bog'liq emas — `data` qatlami uni
/// Supabase `User` obyektidan yasaydi. Shu tufayli domain toza qoladi.
class AuthUser {
  const AuthUser({
    required this.id,
    this.email,
    this.name,
  });

  final String id;
  final String? email;
  final String? name;

  /// Ko'rsatish uchun qulay nom: ism bo'lsa ism, bo'lmasa email yoki "Mehmon".
  String get displayName {
    if (name != null && name!.trim().isNotEmpty) {
      return name!.trim();
    }
    if (email != null && email!.isNotEmpty) {
      return email!.split('@').first;
    }
    return 'Foydalanuvchi';
  }

  AuthUser copyWith({String? id, String? email, String? name}) {
    return AuthUser(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
    );
  }

  @override
  bool operator ==(Object other) =>
      other is AuthUser &&
      other.id == id &&
      other.email == email &&
      other.name == name;

  @override
  int get hashCode => Object.hash(id, email, name);

  @override
  String toString() => 'AuthUser(id: $id, email: $email, name: $name)';
}
