import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:vit_ap_student_app/objectbox.g.dart';

/// A real ObjectBox store in a throwaway directory.
///
/// These tests exist because the interesting bugs in this app's persistence
/// have all been in what a `put` does to *relations* — rows silently orphaned,
/// a relation dropped because it was missing from a hand-written copy, a
/// relation deleted and never written back. None of that is reachable without
/// a real store: it is ObjectBox's own behaviour being tested, not ours.
///
/// **Needs ObjectBox's native library.** It is not part of `flutter pub get`,
/// because the app itself gets it from Gradle and CocoaPods at build time.
/// Without it every test here fails to open a store. To install:
///
/// ```sh
/// gh release download v5.3.2 --repo objectbox/objectbox-c \
///   --pattern "objectbox-macos-universal.zip"
/// unzip objectbox-macos-universal.zip -d /tmp/obx
/// cp /tmp/obx/lib/libobjectbox.dylib lib/libobjectbox.dylib
/// ```
///
/// The version must be at least the `_obxCminMajor/Minor/Patch` the `objectbox`
/// package checks on load. `lib/libobjectbox.dylib` is where its loader looks
/// first, and it is gitignored. On Linux the asset is
/// `objectbox-linux-x64.tar.gz` and the file `lib/libobjectbox.so`.
/// Whether ObjectBox's native library is installed on this machine.
///
/// It is not part of `flutter pub get`, so a fresh checkout does not have it.
/// Tests that need a real store check this and skip rather than fail: an
/// uninstalled library is a missing tool, not a broken app.
bool get objectBoxAvailable {
  if (_available != null) return _available!;
  try {
    final directory = Directory.systemTemp.createTempSync('obx_probe');
    Store(getObjectBoxModel(), directory: directory.path).close();
    directory.deleteSync(recursive: true);
    _available = true;
  } catch (_) {
    _available = false;
  }
  return _available!;
}

bool? _available;

/// The message shown for a skipped store test, with the fix in it.
const String objectBoxMissingReason =
    'ObjectBox native library not installed — see '
    'test/helpers/object_box_test_store.dart for how to install it.';

class TestStore {
  final Store store;
  final Directory directory;

  TestStore._(this.store, this.directory);

  /// Opens a store in a fresh temporary directory, closed and deleted
  /// automatically when the test ends.
  factory TestStore.open() {
    final directory = Directory.systemTemp.createTempSync('vitap_obx_test');
    final store = Store(getObjectBoxModel(), directory: directory.path);

    addTearDown(() {
      store.close();
      if (directory.existsSync()) directory.deleteSync(recursive: true);
    });

    return TestStore._(store, directory);
  }

  Box<T> box<T>() => store.box<T>();

  /// How many rows a box holds. The whole point of most of these tests: a leak
  /// is invisible from the object graph and only shows up as a count that keeps
  /// climbing.
  int count<T>() => store.box<T>().count();
}
