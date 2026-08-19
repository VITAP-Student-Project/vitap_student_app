import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:vit_ap_student_app/features/home/model/for_you_item.dart';
import 'package:vit_ap_student_app/features/home/repository/for_you_feed.dart';

/// One well-formed entry; individual tests override single keys.
Map<String, dynamic> entry({
  String id = '1',
  String createdAt = '2026-01-01T00:00:00Z',
  bool isApproved = true,
  Map<String, dynamic> extra = const {},
}) {
  return <String, dynamic>{
    'id': id,
    'title': 'Tool $id',
    'author': 'Someone',
    'author_email': 'someone@vitapstudent.ac.in',
    'type': 'tools',
    'description': 'Does a thing',
    'url': 'https://example.com',
    'is_approved': isApproved,
    'is_featured': false,
    'display_order': 0,
    'likes': 0,
    'created_at': createdAt,
    ...extra,
  };
}

void main() {
  group('parseForYouFeed', () {
    test('reads a well-formed feed newest first', () {
      final items = parseForYouFeed(
        json.encode([
          entry(id: 'old', createdAt: '2026-01-01T00:00:00Z'),
          entry(id: 'new', createdAt: '2026-06-01T00:00:00Z'),
        ]),
      );

      expect(items!.map((i) => i.id), ['new', 'old']);
    });

    // The feed is hand-edited through a dashboard with no schema validation,
    // so one bad row must not blank the whole section.
    test('skips a malformed entry instead of dropping the feed', () {
      final items = parseForYouFeed(
        json.encode([
          entry(id: 'good'),
          {'id': 'bad', 'title': 'Missing everything else'},
          'not even an object',
        ]),
      );

      expect(items!.map((i) => i.id), ['good']);
    });

    test('drops unapproved and inactive items', () {
      final items = parseForYouFeed(
        json.encode([
          entry(id: 'visible'),
          entry(id: 'unapproved', isApproved: false),
          entry(id: 'retired', extra: {'is_active': false}),
        ]),
      );

      expect(items!.map((i) => i.id), ['visible']);
    });

    test('returns null only when the payload is not a list', () {
      expect(parseForYouFeed('{"items": []}'), isNull);
      expect(parseForYouFeed('not json at all'), isNull);
      expect(parseForYouFeed('[]'), isEmpty);
    });

    // Old rows predate these fields; new builds must still read them.
    test('defaults the fields added after launch', () {
      final item = parseForYouFeed(json.encode([entry()]))!.single;

      expect(item.note, isNull);
      expect(item.requires, isNull);
      expect(item.requirement, isNull);
      expect(item.tags, isEmpty);
      expect(item.isActive, isTrue);
      expect(item.verified, isFalse);
      expect(item.updatedAt, isNull);
    });

    test('reads the fields added after launch when present', () {
      final item = parseForYouFeed(
        json.encode([
          entry(
            extra: {
              'note': 'Results appear after the term ends',
              'requires': 'campus_wifi',
              'tags': ['attendance', 'marks'],
              'verified': true,
              'updated_at': '2026-07-01T00:00:00Z',
            },
          ),
        ]),
      )!.single;

      expect(item.note, 'Results appear after the term ends');
      expect(item.requirement, ForYouRequirement.campusWifi);
      expect(item.tags, ['attendance', 'marks']);
      expect(item.verified, isTrue);
      expect(item.updatedAt, '2026-07-01T00:00:00Z');
    });

    // A requirement this build doesn't know must not throw or render as some
    // other requirement — it simply isn't shown.
    test('an unknown requirement reads as no requirement', () {
      final item = parseForYouFeed(
        json.encode([
          entry(extra: {'requires': 'eduroam'}),
        ]),
      )!.single;

      expect(item.requires, 'eduroam');
      expect(item.requirement, isNull);
    });

    test('a null tags value reads as no tags', () {
      final item = parseForYouFeed(
        json.encode([
          entry(extra: {'tags': null}),
        ]),
      )!.single;

      expect(item.tags, isEmpty);
    });
  });

  group('isForYouCacheFresh', () {
    final now = DateTime.utc(2026, 8, 19, 12);

    test('nothing cached is never fresh', () {
      expect(isForYouCacheFresh(fetchedAt: null, now: now), isFalse);
    });

    test('inside the TTL is fresh, outside is not', () {
      expect(
        isForYouCacheFresh(
          fetchedAt: now.subtract(forYouCacheTtl - const Duration(minutes: 1)),
          now: now,
        ),
        isTrue,
      );
      expect(
        isForYouCacheFresh(
          fetchedAt: now.subtract(forYouCacheTtl + const Duration(minutes: 1)),
          now: now,
        ),
        isFalse,
      );
    });

    // A device clock that jumped forward and back used to leave a timestamp in
    // the future, and `.abs()` on the difference made that cache fresh forever.
    test('a future timestamp is stale, not fresh forever', () {
      expect(
        isForYouCacheFresh(
          fetchedAt: now.add(const Duration(days: 30)),
          now: now,
        ),
        isFalse,
      );
    });
  });
}
