import 'package:flutter_test/flutter_test.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/biometric/biometric_log_tile.dart';

void main() {
  group('isHostelLocation', () {
    test('matches hostel block codes', () {
      expect(isHostelLocation('MH-1'), isTrue);
      expect(isHostelLocation('LH-2'), isTrue);
      expect(isHostelLocation('mh-3'), isTrue);
      expect(isHostelLocation("Men's Hostel"), isTrue);
    });

    test('does not match academic blocks', () {
      expect(isHostelLocation('AB-1'), isFalse);
      expect(isHostelLocation('CB-2'), isFalse);
      expect(isHostelLocation('105-AB-2'), isFalse);
    });

    // Regression: the old `location.contains('MH')` fired on any code that
    // merely contained those letters, so academic blocks got the hostel icon.
    test('does not match letters embedded in a longer code', () {
      expect(isHostelLocation('AB1-MHZ'), isFalse);
      expect(isHostelLocation('ALHAMBRA'), isFalse);
    });
  });

  group('formatScanTime', () {
    test('formats a 24-hour scan time for reading', () {
      expect(formatScanTime('08:42'), '8:42 AM');
      expect(formatScanTime('18:05'), '6:05 PM');
      expect(formatScanTime('00:15'), '12:15 AM');
    });

    test('tolerates surrounding whitespace', () {
      expect(formatScanTime(' 09:00 '), '9:00 AM');
    });

    // Regression: this parse used to run unguarded inside an item builder, so a
    // single malformed row threw and took the whole list down with it.
    test('returns the raw value instead of throwing on bad input', () {
      expect(formatScanTime('-'), '-');
      expect(formatScanTime('not a time'), 'not a time');
      expect(formatScanTime('25:00'), '25:00');
      expect(formatScanTime(''), '');
    });
  });
}
