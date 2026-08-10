import 'package:flutter/material.dart';

/// The app's one input treatment: filled, rounded, label inside.
///
/// Defined once so the auth pages and the outing forms don't drift into separate
/// idioms — the forms used to be bare underlines with `EdgeInsets.zero` padding
/// under hand-styled labels twice their weight, which made the label louder than
/// the thing you were typing into.
InputDecoration appInputDecoration(
  BuildContext context, {
  String? labelText,
  String? hintText,
  Widget? prefixIcon,
  Widget? suffixIcon,
}) {
  final ColorScheme cs = Theme.of(context).colorScheme;

  OutlineInputBorder border(Color color, double width) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(appInputRadius),
    borderSide: width == 0
        ? BorderSide.none
        : BorderSide(color: color, width: width),
  );

  return InputDecoration(
    labelText: labelText,
    hintText: hintText,
    filled: true,
    fillColor: cs.surfaceContainerHigh,
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    border: border(cs.outline, 0),
    enabledBorder: border(cs.outline, 0),
    focusedBorder: border(cs.primary, 2),
    errorBorder: border(cs.error, 1),
    focusedErrorBorder: border(cs.error, 2),
  );
}

/// Corner radius shared by inputs and the tappable fields that mimic them, so an
/// ink splash on a picker lands inside the same shape.
const double appInputRadius = 16;
