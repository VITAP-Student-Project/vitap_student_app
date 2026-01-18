import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:vit_ap_student_app/core/constants/app_constants.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/core/utils/launch_web.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/home/model/for_you_item.dart';
import 'package:vit_ap_student_app/features/home/viewmodel/for_you_viewmodel.dart';

class ForYouAddPage extends ConsumerStatefulWidget {
  const ForYouAddPage({super.key});

  @override
  ConsumerState<ForYouAddPage> createState() => _ForYouAddPageState();
}

class _ForYouAddPageState extends ConsumerState<ForYouAddPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _authorController = TextEditingController();
  final _emailController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _urlController = TextEditingController();
  final _imageUrlController = TextEditingController();

  String _selectedType = AppConstants.forYouItemTypes.first;
  bool _hasAcceptedTerms = false;

  late TapGestureRecognizer _policyTapRecognizer;

  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreen('ForYouAddPage');
    _policyTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        directToWeb(
            'https://github.com/VITAP-Student-Project/vitap_student_app/blob/main/docs/community_tools_policy.md');
      };
  }

  @override
  void dispose() {
    _titleController.dispose();
    _authorController.dispose();
    _emailController.dispose();
    _descriptionController.dispose();
    _urlController.dispose();
    _imageUrlController.dispose();
    _policyTapRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final submitState = ref.watch(forYouSubmitProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Submit Your Tool',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Title",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  hintText: 'Title',
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a title';
                  }
                  if (value.length > 50) {
                    return 'Title must be 50 characters or less';
                  }
                  return null;
                },
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),
              Text(
                "Author Name",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _authorController,
                decoration: InputDecoration(
                  hintText: 'Author name',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),

              Text(
                "Email",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  hintText: 'Author email',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!AppConstants.emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),

              Text(
                "Type",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: InputDecoration(
                  hintText: 'Type',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                items: AppConstants.forYouItemTypes.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      _selectedType = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              Text(
                "URL",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _urlController,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  hintText: 'URL',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the URL';
                  }

                  final uri = Uri.tryParse(value.trim());

                  if (uri == null || !uri.hasScheme || !uri.hasAuthority) {
                    return 'Please enter a valid URL';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),

              Text(
                "Image URL",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _imageUrlController,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  hintText: 'Image URL',
                  hintStyle: Theme.of(context).textTheme.bodyMedium,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    final uri = Uri.tryParse(value);
                    if (uri == null || !uri.hasAbsolutePath) {
                      return 'Please enter a valid URL';
                    }
                  }
                  return null;
                },
                onChanged: (_) => setState(() {}),
              ),
              const SizedBox(height: 16),

              Text(
                "Description",
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 16,
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(
                height: 8,
              ),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                maxLength: 500,
                decoration: InputDecoration(
                  labelText: 'Description',
                  hintText:
                      'Describe what your tool does and how it helps students...',
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a description';
                  }
                  if (value.length < 50) {
                    return 'Description must be at least 50 characters';
                  }
                  return null;
                },
                onChanged: (_) => setState(() {}),
              ),

              const SizedBox(height: 24),

              // Preview Section
              Text(
                'Preview',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 12),
              _buildPreviewCard(),

              const SizedBox(height: 24),

              // Terms Checkbox with hyperlink
              CheckboxListTile(
                value: _hasAcceptedTerms,
                onChanged: (value) {
                  setState(() {
                    _hasAcceptedTerms = value ?? false;
                  });
                },
                title: RichText(
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                    children: [
                      const TextSpan(text: 'I have read and agree to the '),
                      TextSpan(
                        text: 'Community Tools Policy',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor:
                              Theme.of(context).colorScheme.primary,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        recognizer: _policyTapRecognizer,
                      ),
                    ],
                  ),
                ),
                controlAffinity: ListTileControlAffinity.leading,
                contentPadding: EdgeInsets.zero,
              ),

              const SizedBox(height: 8),

              // Note about approval
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  'All submissions require approval before appearing in the app.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Submit Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submitState.isLoading || !_hasAcceptedTerms
                      ? null
                      : _submitForm,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: submitState.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text(
                          'Submit for Approval',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreviewCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Theme.of(context).colorScheme.surfaceContainerLow,
      ),
      width: 225,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(9),
            child: Container(
              height: 200,
              width: 200,
              color: Colors.green.shade100,
              child: _imageUrlController.text.isNotEmpty
                  ? Image.network(
                      _imageUrlController.text,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Center(
                        child: Icon(
                          Iconsax.image,
                          size: 48,
                          color: Colors.green.shade300,
                        ),
                      ),
                    )
                  : Center(
                      child: Icon(
                        Iconsax.image,
                        size: 48,
                        color: Colors.green.shade300,
                      ),
                    ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  decoration: BoxDecoration(
                    color: _selectedType == 'event'
                        ? Colors.yellowAccent.shade700.withOpacity(0.20)
                        : _selectedType == 'resource'
                            ? Colors.greenAccent.shade200.withOpacity(0.20)
                            : Colors.blueAccent.shade200.withOpacity(0.20),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Text(
                      _selectedType,
                      style: TextStyle(
                        fontSize: 12,
                        color: _selectedType == 'event'
                            ? Colors.yellow.shade700
                            : _selectedType == 'resource'
                                ? Colors.green.shade700
                                : Colors.blue.shade700,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  _titleController.text.isEmpty
                      ? 'Tool Title'
                      : _titleController.text,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurface,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  "by ${_authorController.text.isEmpty ? 'Your Name' : _authorController.text}",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  _descriptionController.text.isEmpty
                      ? 'Your description will appear here...'
                      : _descriptionController.text,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Know more',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_hasAcceptedTerms) {
      showSnackBar(
          context,
          "Please accept the Community Tools Policy to continue",
          SnackBarType.warning);
      return;
    }

    final submission = ForYouItemSubmission(
      title: _titleController.text.trim(),
      author: _authorController.text.trim(),
      authorEmail: _emailController.text.trim(),
      imageUrl: _imageUrlController.text.trim().isEmpty
          ? null
          : _imageUrlController.text.trim(),
      type: _selectedType,
      description: _descriptionController.text.trim(),
      url: _urlController.text.trim(),
    );

    final success =
        await ref.read(forYouSubmitProvider.notifier).submitItem(submission);

    if (success && mounted) {
      await AnalyticsService.logEvent('for_you_item_submitted', {
        'title': submission.title,
        'type': submission.type,
      });

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Submitted Successfully!'),
          content: const Text(
            'Your tool has been submitted for approval. You will see it in the app once it\'s approved.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Go back to previous page
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    } else if (mounted) {
      showSnackBar(
          context,
          ref.read(forYouSubmitProvider).error?.toString() ??
              'Failed to submit. Please try again.',
          SnackBarType.error);
    }
  }
}
