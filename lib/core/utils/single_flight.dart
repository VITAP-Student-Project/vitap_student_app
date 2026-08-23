import 'dart:async';

/// Runs at most one operation at a time for a given key, handing every caller
/// that arrives while it is running the *same* future instead of starting a
/// second one.
///
/// This exists for VTOP login. VTOP sends a fresh OTP email for every
/// credentials POST it sees from an IP it has not verified yet, and each POST
/// opens its own server session with its own pending code — so two concurrent
/// logins are two emails, of which only one can be the session the OTP sheet
/// ends up validating. That is how a correctly typed code came back as
/// "Invalid OTP". See
/// https://github.com/Udhay-Adithya/vitap_student_app/issues/18
///
/// The key is what makes two calls "the same operation". Callers with a
/// different key never join an in-flight one — they are asking for something
/// else.
class SingleFlight<K, T> {
  Future<T>? _pending;
  K? _pendingKey;

  /// The in-flight operation for [key], or null if nothing is running for it.
  Future<T>? pendingFor(K key) =>
      _pending != null && _pendingKey == key ? _pending : null;

  /// Whether any operation is in flight, for any key.
  bool get isRunning => _pending != null;

  /// Start [operation] as the single in-flight operation for [key].
  ///
  /// Callers are expected to have checked [pendingFor] first; calling this
  /// while another operation is in flight replaces it as the one that
  /// subsequent callers will join. The replaced future still completes and
  /// still delivers its result to whoever was already awaiting it — releasing
  /// the slot is guarded by identity so a straggler cannot clear a newer
  /// operation's claim.
  Future<T> run(K key, Future<T> Function() operation) {
    final Future<T> future = operation();
    _pending = future;
    _pendingKey = key;

    return future.whenComplete(() {
      if (identical(_pending, future)) {
        _pending = null;
        _pendingKey = null;
      }
    });
  }

  /// Forget the in-flight operation without cancelling it.
  ///
  /// Anyone already awaiting it still gets its result; it simply stops being
  /// the operation that new callers join. Used when the session is torn down
  /// underneath a login that is still running.
  void clear() {
    _pending = null;
    _pendingKey = null;
  }
}
