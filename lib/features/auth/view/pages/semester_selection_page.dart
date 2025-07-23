import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/common/widget/bottom_navigation_bar.dart';
import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop/types/semester.dart';

class SemesterSelectionPage extends ConsumerStatefulWidget {
  final List<SemesterInfo> semesters;

  const SemesterSelectionPage({
    super.key,
    required this.semesters,
  });

  @override
  ConsumerState<SemesterSelectionPage> createState() =>
      _SemesterSelectionPageState();
}

class _SemesterSelectionPageState extends ConsumerState<SemesterSelectionPage> {
  SemesterInfo? selectedSemester;
  String? inlineError;

  Future<void> _loginUser() async {
    setState(() => inlineError = null);

    if (selectedSemester == null) {
      setState(() {
        inlineError = 'Please select a semester to continue.';
      });
      return;
    }

    await ref.read(authViewModelProvider.notifier).loginUser(
          semSubId: selectedSemester!.id,
        );
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref
        .watch(authViewModelProvider.select((val) => val?.isLoading == true));

    ref.listen(
      authViewModelProvider,
      (_, next) {
        next?.when(
          data: (_) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const BottomNavBar(),
              ),
              (_) => false,
            );
          },
          error: (error, _) {
            showSnackBar(
              context,
              error.toString(),
              SnackBarType.error,
            );
          },
          loading: () {},
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Semester Selection',
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: widget.semesters.isEmpty
          ? const Center(
              child: Text('No semesters available. Please try again later.'),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select your semester',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This helps us fetch your academic data correctly. You can also change this anytime in the app.',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey[700],
                        ),
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: ListView.builder(
                      itemCount: widget.semesters.length,
                      itemBuilder: (context, index) {
                        final semester = widget.semesters[index];
                        final isSelected = selectedSemester == semester;

                        return Card(
                          margin: const EdgeInsets.only(bottom: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: BorderSide(
                              color: isSelected
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                          child: RadioListTile<SemesterInfo>(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            title: Text(
                              semester.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(
                                    fontWeight:
                                        isSelected ? FontWeight.bold : null,
                                  ),
                            ),
                            value: semester,
                            groupValue: selectedSemester,
                            onChanged: (value) {
                              setState(() {
                                selectedSemester = value;
                                inlineError = null;
                              });
                            },
                            activeColor: Theme.of(context).colorScheme.primary,
                          ),
                        );
                      },
                    ),
                  ),
                  if (inlineError != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      inlineError!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                        fontSize: 14,
                      ),
                    ),
                  ],
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 60),
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: isLoading ? null : _loginUser,
                      child: isLoading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: Loader(),
                            )
                          : const Text(
                              'Continue',
                              style: TextStyle(fontSize: 16),
                            ),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
    );
  }
}
