import 'package:flutter_test/flutter_test.dart';
import 'package:vit_ap_student_app/core/providers/user_persistence.dart';

void main() {
  group('orphanedIds', () {
    /// The leak this fixes: ObjectBox unlinks on clear() but never deletes, so
    /// every refresh left the whole previous list in the database.
    test('a refresh with all new rows orphans everything it replaces', () {
      // Rows parsed from VTOP have no id until they are put.
      expect(orphanedIds([1, 2, 3], [null, null, null]), [1, 2, 3]);
    });

    /// The reason this cannot just delete whatever was there. Refreshing one
    /// page passes every other relation through untouched, still carrying its
    /// stored ids. ObjectBox will not re-insert an object that already has an
    /// id, so deleting those rows leaves the user pointing at nothing.
    test('rows passed straight through are kept', () {
      expect(orphanedIds([1, 2, 3], [1, 2, 3]), isEmpty);
    });

    test('keeps what survives and drops only what does not', () {
      expect(orphanedIds([1, 2, 3], [2, null]), [1, 3]);
    });

    test('an empty replacement orphans everything', () {
      expect(orphanedIds([1, 2], []), [1, 2]);
    });

    test('nothing stored means nothing to orphan', () {
      expect(orphanedIds([], [1, 2]), isEmpty);
      expect(orphanedIds([null, null], [null]), isEmpty);
    });

    test('treats a zero id as unstored, the same as null', () {
      // ObjectBox uses 0 for "not put yet"; json_serializable leaves it null.
      // Neither is a row that can be deleted.
      expect(orphanedIds([0, 1], [0]), [1]);
      expect(orphanedIds([0], []), isEmpty);
    });

    test('ignores ordering', () {
      expect(orphanedIds([1, 2, 3], [3, 1]), [2]);
    });

    test('a repointed relation orphans the row it left', () {
      // A ToOne is read as a one-element list, so it goes through the same rule.
      expect(orphanedIds([4], [null]), [4]);
      expect(orphanedIds([4], [4]), isEmpty);
      expect(orphanedIds([4], []), [4]);
    });
  });
}
