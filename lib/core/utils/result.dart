import '../error/failure.dart';

/// Muvaffaqiyat yoki xatolikni ifodalovchi natija turi (Either pattern).
///
/// Istisnolarni "tashqariga otish" o'rniga, funksiyalar `Result` qaytaradi —
/// bu xatoni e'tiborsiz qoldirishni qiyinlashtiradi va kodni xavfsizroq qiladi.
///
/// Misol:
/// ```dart
/// final Result<int> r = await repo.increment();
/// final String msg = r.when(
///   ok: (value) => 'Yangi qiymat: $value',
///   err: (failure) => failure.message,
/// );
/// ```
sealed class Result<T> {
  const Result();

  const factory Result.ok(T value) = Ok<T>;
  const factory Result.err(Failure failure) = Err<T>;

  bool get isOk => this is Ok<T>;
  bool get isErr => this is Err<T>;

  /// Muvaffaqiyat qiymati yoki `null`.
  T? get valueOrNull => switch (this) {
        Ok<T>(:final value) => value,
        Err<T>() => null,
      };

  /// Ikkala holatni ham majburan ko'rib chiqadi (exhaustive).
  R when<R>({
    required R Function(T value) ok,
    required R Function(Failure failure) err,
  }) {
    return switch (this) {
      Ok<T>(:final value) => ok(value),
      Err<T>(:final failure) => err(failure),
    };
  }

  /// Muvaffaqiyat qiymatini boshqa turga o'zgartiradi.
  Result<R> map<R>(R Function(T value) transform) {
    return switch (this) {
      Ok<T>(:final value) => Result<R>.ok(transform(value)),
      Err<T>(:final failure) => Result<R>.err(failure),
    };
  }
}

class Ok<T> extends Result<T> {
  const Ok(this.value);
  final T value;
}

class Err<T> extends Result<T> {
  const Err(this.failure);
  final Failure failure;
}
