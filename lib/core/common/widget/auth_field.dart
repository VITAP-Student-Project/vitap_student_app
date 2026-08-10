import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/core/common/widget/app_input_decoration.dart';

/// A credentials input, shared by the login and manage-credentials pages.
///
/// Filled rather than outlined, with the label floating inside the field. The
/// previous version stacked an external label above a bordered box whose hint
/// repeated it — "Username" over "VTOP Username" — which cost a line per field
/// and read as a stutter.
///
/// Deliberately does **not** wrap itself in an [AutofillGroup]. A group is meant
/// to enclose a whole credential set; one group per field meant iOS and Android
/// never saw a username and password as a pair, so the "save this password?"
/// prompt never fired properly. Callers put a single [AutofillGroup] around the
/// form, and call [TextInput.finishAutofillContext] once the credentials are
/// known good.
class AuthField extends StatefulWidget {
  const AuthField({
    super.key,
    required this.hintText,
    required this.controller,
    this.title,
    this.isObscureText = false,
    this.textInputAction,
    this.onFieldSubmitted,
    this.textCapitalization = TextCapitalization.none,
  });

  /// Floating label. Falls back to [hintText] when absent.
  final String? title;

  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;
  final TextCapitalization textCapitalization;

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  late bool _obscureText = widget.isObscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscureText,
      textInputAction: widget.textInputAction,
      onFieldSubmitted: widget.onFieldSubmitted,
      textCapitalization: widget.textCapitalization,
      style: Theme.of(context).textTheme.bodyLarge,
      autofillHints: widget.isObscureText
          ? const <String>[AutofillHints.password]
          : const <String>[AutofillHints.username],
      decoration: appInputDecoration(
        context,
        labelText: widget.title ?? widget.hintText,
        // Only a hint when it says something the label doesn't.
        hintText: widget.title == null ? null : widget.hintText,
        prefixIcon: Icon(
          widget.isObscureText ? Iconsax.lock_1 : Iconsax.user,
          size: 20,
        ),
        suffixIcon: widget.isObscureText
            ? IconButton(
                onPressed: () => setState(() => _obscureText = !_obscureText),
                icon: Icon(
                  _obscureText ? Iconsax.eye_slash : Iconsax.eye,
                  size: 20,
                ),
                tooltip: _obscureText ? 'Show password' : 'Hide password',
              )
            : null,
      ),
      validator: (String? value) {
        final String text = value ?? '';
        if (widget.isObscureText) {
          if (text.isEmpty) return 'Password cannot be empty';
          // VTOP's own minimum — catching it here saves a round trip.
          if (text.length < 8) {
            return 'Password must be at least 8 characters';
          }
          return null;
        }
        if (text.isEmpty) return 'Username cannot be empty';
        if (!RegExp(r'^[a-zA-Z0-9 ]+$').hasMatch(text)) {
          return 'Username cannot contain special characters';
        }
        return null;
      },
    );
  }
}
