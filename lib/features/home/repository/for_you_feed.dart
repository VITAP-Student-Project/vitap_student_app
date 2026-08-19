import 'dart:convert';
import 'dart:developer';

import 'package:vit_ap_student_app/features/home/model/for_you_item.dart';

/// How long a cached For You feed is served without touching the network.
const Duration forYouCacheTtl = Duration(hours: 6);

/// Whether a feed cached at [fetchedAt] may still be served without a request.
///
/// [now] is injected so the rule is testable, and a null [fetchedAt] means
/// nothing has ever been cached. A timestamp in the future is treated as stale
/// rather than fresh-forever: the device clock can move backwards, and a cache
/// that never revalidates again is a worse failure than one extra request.
bool isForYouCacheFresh({
  required DateTime? fetchedAt,
  required DateTime now,
  Duration ttl = forYouCacheTtl,
}) {
  if (fetchedAt == null) return false;
  if (fetchedAt.isAfter(now)) return false;
  return now.difference(fetchedAt) < ttl;
}

/// Parses a For You feed body into the items worth showing.
///
/// Lenient by design, the same way `announcements.json` is: the feed is
/// hand-curated through an admin dashboard with no schema validation, so one
/// malformed entry is skipped rather than blanking the whole section. Returns
/// null only when the payload isn't a JSON list at all, which is the one case
/// the caller should treat as a failed fetch.
///
/// Unapproved and inactive items are dropped here so no caller can forget to.
/// Result is newest first.
List<ForYouItem>? parseForYouFeed(String body) {
  final Object? decoded;
  try {
    decoded = json.decode(body);
  } catch (e) {
    log('Failed to decode For You feed: $e');
    return null;
  }

  if (decoded is! List) return null;

  final items = <ForYouItem>[];
  for (final entry in decoded) {
    if (entry is! Map<String, dynamic>) continue;
    try {
      final item = ForYouItem.fromJson(entry);
      if (item.isApproved && item.isActive) items.add(item);
    } catch (e) {
      log('Skipped malformed For You item: $e');
    }
  }

  items.sort((a, b) => b.createdAt.compareTo(a.createdAt));
  return items;
}
