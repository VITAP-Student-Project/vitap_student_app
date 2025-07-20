import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class AuthField extends StatefulWidget {
  final String? title;
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;

  const AuthField({
    super.key,
    this.title,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
  });

  @override
  State<AuthField> createState() => _AuthFieldState();
}

class _AuthFieldState extends State<AuthField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isObscureText;
  }

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title ?? widget.hintText,
            style: Theme.of(context).textTheme.labelMedium,
          ),
          const SizedBox(height: 6),
          TextFormField(
            controller: widget.controller,
            style: Theme.of(context).textTheme.bodySmall,
            decoration: InputDecoration(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width - 80),
              contentPadding: const EdgeInsets.all(18),
              hintText: widget.hintText,
              hintStyle: Theme.of(context).textTheme.bodySmall,
              prefixIcon: widget.isObscureText
                  ? const Icon(Iconsax.lock_1)
                  : const Icon(Iconsax.user),
              suffixIcon: widget.isObscureText
                  ? IconButton(
                      icon: Icon(
                        _obscureText ? Iconsax.eye_slash : Iconsax.eye,
                      ),
                      onPressed: _toggleVisibility,
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            autofillHints: widget.isObscureText
                ? const [AutofillHints.password]
                : const [AutofillHints.username],
            validator: (value) {
              if (widget.isObscureText) {
                if (value!.isEmpty) {
                  return "Password cannot be empty!";
                }
                if (value.length < 8) {
                  return "${widget.hintText} must be at least 8 characters!";
                }
                return null;
              } else {
                if (value!.isEmpty) {
                  return "Username cannot be empty!";
                }
                if (!RegExp(r'^[a-zA-Z0-9]+$').hasMatch(value)) {
                  return 'Username cannot contain special characters';
                }
                return null;
              }
            },
            obscureText: _obscureText,
          ),
        ],
      ),
    );
  }
}
