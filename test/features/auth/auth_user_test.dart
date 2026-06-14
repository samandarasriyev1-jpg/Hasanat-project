import 'package:flutter_test/flutter_test.dart';
import 'package:hasanat/features/auth/domain/auth_user.dart';

void main() {
  group('AuthUser', () {
    test('displayName ism bo\'lsa ismni qaytaradi', () {
      const user = AuthUser(id: '1', email: 'a@b.com', name: 'Ali');
      expect(user.displayName, 'Ali');
    });

    test('displayName ism yo\'q bo\'lsa email boshini qaytaradi', () {
      const user = AuthUser(id: '1', email: 'ali@b.com');
      expect(user.displayName, 'ali');
    });

    test('displayName hech narsa yo\'q bo\'lsa fallback qaytaradi', () {
      const user = AuthUser(id: '1');
      expect(user.displayName, 'Foydalanuvchi');
    });

    test('teng obyektlar == va hashCode bo\'yicha teng', () {
      const a = AuthUser(id: '1', email: 'a@b.com', name: 'Ali');
      const b = AuthUser(id: '1', email: 'a@b.com', name: 'Ali');
      expect(a, b);
      expect(a.hashCode, b.hashCode);
    });
  });
}
