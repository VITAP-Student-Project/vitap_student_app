import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:vit_ap_student_app/core/common/widget/empty_content_view.dart';
import 'package:vit_ap_student_app/core/common/widget/error_content_view.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';
import 'package:vit_ap_student_app/features/home/model/biometric.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/biometric/biometric_date_stepper.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/biometric/biometric_log_tile.dart';
import 'package:vit_ap_student_app/features/home/viewmodel/biometric_viewmodel.dart';

/// The day's biometric scans, for a date you choose.
///
/// Fetching stays an explicit action rather than firing on open: VTOP can demand
/// an OTP for this endpoint, and being asked to verify a login for a page you
/// only glanced at is worse than pressing a button. For the same reason there is
/// no pull-to-refresh — an accidental swipe should not cost an OTP.
class BiometricPage extends ConsumerStatefulWidget {
  const BiometricPage({super.key});

  @override
  ConsumerState<BiometricPage> createState() => _BiometricPageState();
}

class _BiometricPageState extends ConsumerState<BiometricPage> {
  static final DateTime _firstDate = DateTime(2024);

  DateTime _selectedDate = _dayOf(DateTime.now());

  /// The date the log currently in the view model belongs to.
  ///
  /// Without it, stepping the date left the previous day's rows on screen — and
  /// the old page compounded that by stamping every row with the *newly*
  /// selected date, so it showed one day's scans labelled as another's.
  DateTime? _loadedDate;

  @override
  void initState() {
    super.initState();
    ref.read(analyticsServiceProvider).logScreen('BiometricPage');
  }

  bool get _isShowingSelectedDate =>
      _loadedDate != null && _loadedDate == _selectedDate;

  void _fetch() {
    setState(() => _loadedDate = _selectedDate);
    ref
        .read(biometricViewModelProvider.notifier)
        .fetchBiometric(DateFormat('dd/MM/yyyy').format(_selectedDate));
  }

  @override
  Widget build(BuildContext context) {
    final AsyncValue<List<Biometric>>? biometric = ref.watch(
      biometricViewModelProvider,
    );
    final bool isLoading =
        _isShowingSelectedDate && biometric?.isLoading == true;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Biometric Log',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: BiometricDateStepper(
              selectedDate: _selectedDate,
              firstDate: _firstDate,
              onChanged: (DateTime date) =>
                  setState(() => _selectedDate = date),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: FilledButton(
              style: FilledButton.styleFrom(
                minimumSize: const Size.fromHeight(52),
                shape: const StadiumBorder(),
              ),
              onPressed: isLoading ? null : _fetch,
              child: isLoading
                  ? SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    )
                  : Text(_isShowingSelectedDate ? 'Refresh' : 'View log'),
            ),
          ),
          Expanded(child: _results(biometric)),
        ],
      ),
    );
  }

  Widget _results(AsyncValue<List<Biometric>>? biometric) {
    // Anything in the view model belongs to a different day than the one now
    // selected, so it would be a lie to show it.
    if (!_isShowingSelectedDate || biometric == null) {
      return _NotFetchedYet(date: _selectedDate);
    }

    return biometric.when(
      loading: () => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Lottie.asset(
            'assets/lottie/loading_files.json',
            frameRate: const FrameRate(60),
            height: 100,
          ),
          Text(
            'Fetching biometric log…',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      // The failure used to surface twice — a red snackbar from a `ref.listen`
      // as well as this view. One error, one place.
      error: (Object error, StackTrace _) =>
          ErrorContentView(error: error.toString()),
      data: (List<Biometric> entries) {
        if (entries.isEmpty) {
          return const EmptyContentView(
            primaryText: 'No scans found',
            secondaryText: 'There are no biometric scans logged for this date',
          );
        }

        return ListView.separated(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          itemCount: entries.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (BuildContext context, int index) {
            return BiometricLogTile(entry: entries[index]);
          },
        );
      },
    );
  }

  static DateTime _dayOf(DateTime date) =>
      DateTime(date.year, date.month, date.day);
}

/// Shown before anything has been fetched for the selected date.
///
/// The page used to render nothing at all here — a date picker, a "Go" button,
/// and then blank space, with no indication that pressing Go was the point.
/// It also names the OTP up front, so being asked to verify is expected rather
/// than a surprise from a page you just opened.
class _NotFetchedYet extends StatelessWidget {
  const _NotFetchedYet({required this.date});

  final DateTime date;

  @override
  Widget build(BuildContext context) {
    final ColorScheme cs = Theme.of(context).colorScheme;
    final TextTheme tt = Theme.of(context).textTheme;

    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.fingerprint_rounded, size: 56, color: cs.outline),
            const SizedBox(height: 16),
            Text(
              'Nothing loaded yet',
              style: tt.titleMedium?.copyWith(
                color: cs.onSurface,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 6),
            Text(
              'Tap View log to fetch your scans for '
              '${DateFormat('d MMM yyyy').format(date)}.',
              style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'VTOP may ask you to verify with an OTP.',
              style: tt.labelSmall?.copyWith(color: cs.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
