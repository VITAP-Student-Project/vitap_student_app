/// Resolving the saved avatar choice into something that can be drawn.
///
/// `UserPreferences.pfpPath` has always held an asset path, and the photo VTOP
/// keeps on the profile page is not a file — it is base64 in the student's own
/// record. Rather than add a second property (a schema migration on a shipping
/// app for a value that is one of a closed set), the photo is stored as the
/// sentinel [kVtopPfpPath] in the same field, and every render site asks this
/// module what to draw.
library;

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/widgets.dart';

/// The avatar shown before anyone chooses one, and the fallback whenever a
/// saved choice cannot be honoured.
const String kDefaultPfpPath = 'assets/images/pfp/default.png';

/// Stored in `pfpPath` to mean "the photo VTOP has of me".
///
/// Deliberately not a path: no asset can ever collide with it, so an existing
/// saved preference can never be mistaken for this.
const String kVtopPfpPath = 'vtop://profile-photo';

/// Decoded photos, keyed by the base64 they came from.
///
/// Two things depend on this cache. Decoding base64 on every `build` would be
/// wasteful on its own, but the real cost is downstream: [MemoryImage] compares
/// by byte-list identity, so a freshly decoded list is a *new* cache key every
/// frame, and Flutter's own `ImageCache` would miss and re-decode the JPEG each
/// time. Handing back the same [MemoryImage] instance makes both caches hit.
///
/// Bounded by construction — a student has one photo, and the map only turns
/// over if the account changes.
final Map<String, MemoryImage> _photoCache = <String, MemoryImage>{};

/// Forgets every decoded photo.
///
/// Called on logout: the cache holds a decoded photograph of the student, and
/// there is no reason to keep it in memory once they have signed out.
void clearPhotoCache() => _photoCache.clear();

/// Decodes [base64Pfp] into image bytes, or returns null when there is nothing
/// to draw.
///
/// Never throws. The value is scraped from VTOP's HTML, so an empty string
/// (no photo on file) and a truncated payload are both ordinary outcomes that
/// must degrade to the default avatar rather than take the page down.
Uint8List? decodeVtopPfp(String? base64Pfp) {
  final String value = (base64Pfp ?? '').trim();
  if (value.isEmpty) return null;

  try {
    final Uint8List bytes = base64Decode(value);
    return bytes.isEmpty ? null : bytes;
  } on FormatException {
    return null;
  }
}

/// Whether the VTOP photo can be offered as a choice at all.
///
/// False in demo mode and for accounts VTOP has no photo for, which is why the
/// picker builds its grid from [avatarChoices] instead of a fixed list.
bool hasVtopPfp(String? base64Pfp) => decodeVtopPfp(base64Pfp) != null;

/// The image for a saved [pfpPath], falling back to the default avatar.
///
/// The fallback matters more than it looks: someone can pick their VTOP photo,
/// then sign in to an account that has none, and the stale sentinel must resolve
/// to an avatar rather than a broken image.
ImageProvider avatarImageProvider(String pfpPath, String? base64Pfp) {
  if (pfpPath != kVtopPfpPath) return AssetImage(pfpPath);

  final Uint8List? bytes = decodeVtopPfp(base64Pfp);
  if (bytes == null) return const AssetImage(kDefaultPfpPath);

  return _photoCache.putIfAbsent(base64Pfp!.trim(), () => MemoryImage(bytes));
}

/// The avatars offered in the picker, in display order.
///
/// The student's own photo leads when there is one; the illustrated avatars
/// follow in their established order.
List<String> avatarChoices(String? base64Pfp) => <String>[
  if (hasVtopPfp(base64Pfp)) kVtopPfpPath,
  ...kAvatarAssetPaths,
];

/// The bundled avatars, in the order they are laid out.
const List<String> kAvatarAssetPaths = <String>[
  kDefaultPfpPath,
  'assets/images/pfp/astronaut.png',
  'assets/images/pfp/bear.png',
  'assets/images/pfp/cat.png',
  'assets/images/pfp/chicken.png',
  'assets/images/pfp/dog.png',
  'assets/images/pfp/duck.png',
  'assets/images/pfp/man.png',
  'assets/images/pfp/man_1.png',
  'assets/images/pfp/masked.png',
  'assets/images/pfp/ninja.png',
  'assets/images/pfp/panda.png',
  'assets/images/pfp/woman.png',
  'assets/images/pfp/woman_1.png',
];
