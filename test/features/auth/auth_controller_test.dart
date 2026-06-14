import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hasanat/core/error/failure.dart';
import 'package:hasanat/core/utils/result.dart';
import 'package:hasanat/features/auth/application/auth_controller.dart';
import 'package:hasanat/features/auth/domain/auth_repository.dart';
import 'package:hasanat/features/auth/domain/auth_user.dart';

/// Test uchun soxta (fake) repozitoriy — backend talab qilmaydi.
class FakeAuthRepository implements AuthRepository {
  AuthUser? _user;
  bool failNext = false;
  final StreamController<AuthUser?> _events =
      StreamController<AuthUser?>.broadcast();

  @override
  AuthUser? get currentUser => _user;

  @override
  Stream<AuthUser?> authStateChanges() => _events.stream;

  @override
  Future<Result<AuthUser>> signInWithEmail({
    required String email,
    required String password,
  }) async {
    if (failNext) {
      return const Result.err(ServerFailure('Email yoki parol noto\'g\'ri.'));
    }
    final user = AuthUser(id: '1', email: email);
    _user = user;
    _events.add(user);
    return Result.ok(user);
  }

  @override
  Future<Result<AuthUser>> signUpWithEmail({
    required String email,
    required String password,
    String? name,
  }) async {
    final user = AuthUser(id: '2', email: email, name: name);
    _user = user;
    _events.add(user);
    return Result.ok(user);
  }

  @override
  Future<Result<void>> signOut() async {
    _user = null;
    _events.add(null);
    return const Result.ok(null);
  }
}

void main() {
  late FakeAuthRepository fake;
  late ProviderContainer container;

  setUp(() {
    fake = FakeAuthRepository();
    container = ProviderContainer(
      overrides: [authRepositoryProvider.overrideWithValue(fake)],
    );
    addTearDown(container.dispose);
  });

  test('boshlang\'ich holatda foydalanuvchi null', () {
    expect(container.read(authControllerProvider), isNull);
  });

  test('signIn muvaffaqiyatda holatni yangilaydi', () async {
    final controller = container.read(authControllerProvider.notifier);
    final result =
        await controller.signIn(email: 'a@b.com', password: '123456');

    expect(result.isOk, isTrue);
    expect(container.read(authControllerProvider)?.email, 'a@b.com');
  });

  test('signIn xato bo\'lsa holat o\'zgarmaydi', () async {
    fake.failNext = true;
    final controller = container.read(authControllerProvider.notifier);
    final result =
        await controller.signIn(email: 'a@b.com', password: 'bad');

    expect(result.isErr, isTrue);
    expect(container.read(authControllerProvider), isNull);
  });

  test('signOut holatni null ga qaytaradi', () async {
    final controller = container.read(authControllerProvider.notifier);
    await controller.signIn(email: 'a@b.com', password: '123456');
    expect(container.read(authControllerProvider), isNotNull);

    await controller.signOut();
    expect(container.read(authControllerProvider), isNull);
  });
}
