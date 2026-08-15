/// VTOP sends faculty as `"Shaik Subhani - SCOPE"` — name, then school.
///
/// The detail page stripped the school and the list card printed it in full, so
/// the same field read two different ways depending on which screen you were on.
/// One rule, used by both.
String facultyDisplayName(String? faculty) {
  final String value = (faculty ?? '').trim();
  if (value.isEmpty) return '';
  final int separator = value.indexOf(' - ');
  return separator == -1 ? value : value.substring(0, separator).trim();
}
