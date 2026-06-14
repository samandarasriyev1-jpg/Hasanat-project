/// Ilova bo'ylab xatolarni bir xil ko'rinishda ifodalovchi turlar.
///
/// Istisnolar (exceptions) o'rniga oqim (control flow) sifatida ishlatiladi:
/// repozitoriylar `Result<Failure, T>` qaytaradi.
sealed class Failure {
  const Failure(this.message);

  /// Foydalanuvchiga ko'rsatish mumkin bo'lgan qisqa xabar.
  final String message;

  @override
  String toString() => '$runtimeType($message)';
}

/// Tarmoq bilan bog'liq xatolik (internet yo'q, timeout, server xatosi).
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Tarmoq xatosi. Internetni tekshiring.']);
}

/// Lokal saqlash (cache/disk) bilan bog'liq xatolik.
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Ma\'lumotni saqlashda xatolik.']);
}

/// Backend (Supabase) bilan bog'liq xatolik.
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Server xatosi. Keyinroq urinib ko\'ring.']);
}

/// Aniqlanmagan / kutilmagan xatolik.
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Noma\'lum xatolik yuz berdi.']);
}
