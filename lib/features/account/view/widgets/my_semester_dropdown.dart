import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vit_ap_student_app/core/common/widget/loader.dart';
import 'package:vit_ap_student_app/core/models/credentials.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/core/utils/show_snackbar.dart';
import 'package:vit_ap_student_app/features/auth/viewmodel/semester_viewmodel.dart';
import 'package:vit_ap_student_app/src/rust/api/vtop/types/semester.dart';

class MySemesterDropDownWidget extends ConsumerStatefulWidget {
  final void Function(String?) onSelected;
  final String? initialValue;
  final Credentials credentials;

  const MySemesterDropDownWidget(
      {super.key,
      required this.onSelected,
      this.initialValue,
      required this.credentials});

  @override
  ConsumerState<MySemesterDropDownWidget> createState() =>
      _MySemesterDropDownWidgetState();
}

class _MySemesterDropDownWidgetState
    extends ConsumerState<MySemesterDropDownWidget> {
  SemesterInfo? _selectedSemester;
  List<SemesterInfo> _semesters = [];
  bool _hasInitialized = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchSemesters();
    });
  }

  void _fetchSemesters() {
    if (!_hasInitialized) {
      ref.read(semesterViewModelProvider.notifier).fetchSemesters(
            registrationNumber: widget.credentials.registrationNumber,
            password: widget.credentials.password,
          );
      _hasInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final semesterState = ref.watch(semesterViewModelProvider);

    ref.listen(
      semesterViewModelProvider,
      (_, next) {
        next?.when(
          data: (semesters) {
            AnalyticsService.logEvent('semester_fetch_success', {
              'semester_count': semesters.length,
            });
          },
          error: (error, st) {
            AnalyticsService.logEvent('semester_fetch_failed', {
              'error_message': error.toString(),
            });
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

    return semesterState?.when(
          data: (semesters) {
            _semesters = semesters;

            // Set initial value if provided
            if (widget.initialValue != null && _selectedSemester == null) {
              _selectedSemester = _semesters.firstWhere(
                (semester) => semester.id == widget.initialValue,
                orElse: () => _semesters.first,
              );
            }

            return DropdownButtonFormField<SemesterInfo>(
              style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
              ),
              icon: const Icon(Icons.keyboard_arrow_down_rounded),
              decoration: InputDecoration(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width - 80,
                  maxHeight: 100,
                ),
                labelText: "Semester",
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(9),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              validator: (value) {
                if (value == null) {
                  return "Please select a semester";
                }
                return null;
              },
              value: _selectedSemester,
              hint: Text(
                "Select Semester",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              items: _semesters
                  .map(
                    (semester) => DropdownMenuItem<SemesterInfo>(
                      value: semester,
                      child: Text(
                        semester.name,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ),
                  )
                  .toList(),
              onChanged: (selectedSemester) {
                setState(() {
                  _selectedSemester = selectedSemester;
                });
                widget.onSelected(selectedSemester?.id);
              },
            );
          },
          loading: () => Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.primary,
              ),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Center(
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: Loader(),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    "Loading semesters...",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),
          error: (error, stackTrace) => Container(
            height: 60,
            width: MediaQuery.sizeOf(context).width - 80,
            decoration: BoxDecoration(
              border: Border.all(
                color: Theme.of(context).colorScheme.error,
              ),
              borderRadius: BorderRadius.circular(9),
            ),
            child: Center(
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Icon(
                    Icons.error_outline,
                    color: Theme.of(context).colorScheme.error,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Failed to load semesters",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      await ref
                          .read(semesterViewModelProvider.notifier)
                          .fetchSemesters(
                            registrationNumber:
                                widget.credentials.registrationNumber,
                            password: widget.credentials.password,
                          );
                    },
                    child: Text(
                      "Retry",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ) ??
        Container(
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outline,
            ),
            borderRadius: BorderRadius.circular(9),
          ),
          child: Center(
            child: Text(
              "Initializing...",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
          ),
        );
  }
}
