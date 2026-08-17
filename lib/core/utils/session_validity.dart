import 'package:vit_ap_student_app/core/models/credentials.dart';

/// Whether stored credentials can actually be used to reach VTOP.
///
/// Every VTOP call re-authenticates with the registration number and password,
/// so a session missing either is dead on arrival: the app opens on the home
/// page and fails on the first fetch, with no route back to login.
///
/// Blank strings count as missing. A restored or partially written entry can
/// deserialize into a [Credentials] whose fields are empty, which is not the
/// same thing as having credentials.
bool areCredentialsUsable(Credentials? credentials) {
  if (credentials == null) return false;

  return credentials.registrationNumber.trim().isNotEmpty &&
      credentials.password.trim().isNotEmpty;
}
