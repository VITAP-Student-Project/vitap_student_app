import 'package:flutter_test/flutter_test.dart';
import 'package:vit_ap_student_app/core/utils/semantic_version.dart';

void main() {
  group('SemanticVersion.tryParse', () {
    test('parses full, partial and build-tagged versions', () {
      expect(SemanticVersion.tryParse('2.3.4'), const SemanticVersion(2, 3, 4));
      expect(SemanticVersion.tryParse('2.3'), const SemanticVersion(2, 3, 0));
      expect(SemanticVersion.tryParse('2'), const SemanticVersion(2, 0, 0));
      // pubspec.yaml ships `2.3.4+27`.
      expect(
        SemanticVersion.tryParse('2.3.4+27'),
        const SemanticVersion(2, 3, 4),
      );
      expect(
        SemanticVersion.tryParse('2.3.4-beta.1'),
        const SemanticVersion(2, 3, 4),
      );
      expect(
        SemanticVersion.tryParse(' 2.3.4 '),
        const SemanticVersion(2, 3, 4),
      );
    });

    test('returns null rather than throwing on junk', () {
      expect(SemanticVersion.tryParse(null), isNull);
      expect(SemanticVersion.tryParse(''), isNull);
      expect(SemanticVersion.tryParse('latest'), isNull);
      expect(SemanticVersion.tryParse('2.x.4'), isNull);
      expect(SemanticVersion.tryParse('1.2.3.4'), isNull);
      expect(SemanticVersion.tryParse('-1.0.0'), isNull);
    });
  });

  group('ordering', () {
    // The whole reason this class exists: as strings, '2.10.0' < '2.9.0'.
    test('compares numerically, not lexically', () {
      final SemanticVersion tenth = SemanticVersion.tryParse('2.10.0')!;
      final SemanticVersion ninth = SemanticVersion.tryParse('2.9.0')!;
      expect(tenth > ninth, isTrue);
      expect(ninth < tenth, isTrue);
    });

    test('orders across each component', () {
      expect(
        SemanticVersion.tryParse('3.0.0')! >
            SemanticVersion.tryParse('2.99.99')!,
        isTrue,
      );
      expect(
        SemanticVersion.tryParse('2.3.4')! > SemanticVersion.tryParse('2.3.3')!,
        isTrue,
      );
    });

    test('treats missing components as zero', () {
      expect(
        SemanticVersion.tryParse('2.3') == SemanticVersion.tryParse('2.3.0'),
        isTrue,
      );
      expect(
        SemanticVersion.tryParse('2.3')! <= SemanticVersion.tryParse('2.3.1')!,
        isTrue,
      );
    });

    test('is equal to itself inclusively', () {
      final SemanticVersion a = SemanticVersion.tryParse('2.3.4')!;
      final SemanticVersion b = SemanticVersion.tryParse('2.3.4')!;
      expect(a >= b, isTrue);
      expect(a <= b, isTrue);
      expect(a > b, isFalse);
    });
  });
}
