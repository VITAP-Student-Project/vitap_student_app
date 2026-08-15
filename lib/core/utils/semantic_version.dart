/// Comparing app versions the way humans mean them.
///
/// Exists because the obvious approach is wrong: as strings, `"2.10.0"` sorts
/// *below* `"2.9.0"`, so a version gate written with `<` silently stops working
/// the first time a minor number reaches double digits.
library;

/// A `major.minor.patch` version, tolerant of what `pubspec.yaml` and the stores
/// actually produce.
///
/// Accepts `2.3.4`, `2.3`, `2`, and strips a `+build` suffix or a `-preview`
/// tag, since [PackageInfo.version] and hand-written JSON both turn up in
/// slightly different shapes.
class SemanticVersion implements Comparable<SemanticVersion> {
  const SemanticVersion(this.major, this.minor, this.patch);

  final int major;
  final int minor;
  final int patch;

  /// Parses [value], or returns `null` when it is not a version at all.
  ///
  /// Never throws — announcement targets come from a hand-edited file, and a
  /// typo there must not be able to take anything down.
  static SemanticVersion? tryParse(String? value) {
    final String trimmed = (value ?? '').trim();
    if (trimmed.isEmpty) return null;

    // Drop `+27` build metadata and any `-beta.1` pre-release tag.
    final String core = trimmed.split('+').first.split('-').first;
    final List<String> parts = core.split('.');
    if (parts.isEmpty || parts.length > 3) return null;

    final List<int> numbers = <int>[];
    for (final String part in parts) {
      final int? parsed = int.tryParse(part.trim());
      if (parsed == null || parsed < 0) return null;
      numbers.add(parsed);
    }

    return SemanticVersion(
      numbers[0],
      numbers.length > 1 ? numbers[1] : 0,
      numbers.length > 2 ? numbers[2] : 0,
    );
  }

  @override
  int compareTo(SemanticVersion other) {
    if (major != other.major) return major.compareTo(other.major);
    if (minor != other.minor) return minor.compareTo(other.minor);
    return patch.compareTo(other.patch);
  }

  bool operator <(SemanticVersion other) => compareTo(other) < 0;
  bool operator <=(SemanticVersion other) => compareTo(other) <= 0;
  bool operator >(SemanticVersion other) => compareTo(other) > 0;
  bool operator >=(SemanticVersion other) => compareTo(other) >= 0;

  @override
  bool operator ==(Object other) =>
      other is SemanticVersion &&
      other.major == major &&
      other.minor == minor &&
      other.patch == patch;

  @override
  int get hashCode => Object.hash(major, minor, patch);

  @override
  String toString() => '$major.$minor.$patch';
}
