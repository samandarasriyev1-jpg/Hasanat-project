import 'package:flutter_test/flutter_test.dart';
import 'package:hasanat/core/error/failure.dart';
import 'package:hasanat/core/utils/result.dart';

void main() {
  group('Result', () {
    test('Ok holatida isOk true va valueOrNull qiymat qaytaradi', () {
      const Result<int> r = Result<int>.ok(42);
      expect(r.isOk, isTrue);
      expect(r.isErr, isFalse);
      expect(r.valueOrNull, 42);
    });

    test('Err holatida isErr true va valueOrNull null bo\'ladi', () {
      const Result<int> r = Result<int>.err(CacheFailure());
      expect(r.isErr, isTrue);
      expect(r.valueOrNull, isNull);
    });

    test('when ikkala holatni ham to\'g\'ri ko\'rib chiqadi', () {
      const Result<int> ok = Result<int>.ok(5);
      const Result<int> err = Result<int>.err(NetworkFailure());

      expect(ok.when(ok: (v) => 'ok:$v', err: (f) => 'err'), 'ok:5');
      expect(err.when(ok: (v) => 'ok', err: (f) => f.message),
          const NetworkFailure().message);
    });

    test('map faqat Ok qiymatini o\'zgartiradi', () {
      const Result<int> ok = Result<int>.ok(2);
      expect(ok.map((v) => v * 10).valueOrNull, 20);

      const Result<int> err = Result<int>.err(ServerFailure());
      expect(err.map((v) => v * 10).isErr, isTrue);
    });
  });
}
