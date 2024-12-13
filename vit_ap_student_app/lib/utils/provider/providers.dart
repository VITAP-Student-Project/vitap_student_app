import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../api/apis.dart';

// Payment Provider
final paymentProvider = FutureProvider<Map<String, dynamic>>((ref) async {
  await fetchPaymentDetails();
  final prefs = await SharedPreferences.getInstance();
  final paymentString = prefs.getString('payments') ?? '';
  if (paymentString.isNotEmpty) {
    return json.decode(paymentString);
  }
  return {};
});

//Privacy Mode Provider
class PrivacyModeNotifier extends StateNotifier<bool> {
  PrivacyModeNotifier() : super(false) {
    _togglePrivacyModeState();
  }

  Future<void> _togglePrivacyModeState() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('isPrivacyModeEnabled') ?? true; // Default to true
  }

  void togglePrivacyMode(bool value) async {
    state = value;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isPrivacyModeEnabled', value);
  }
}

final privacyModeProvider = StateNotifierProvider<PrivacyModeNotifier, bool>(
    (ref) => PrivacyModeNotifier());

// General Outing Provider
final generalOutingProvider = Provider.autoDispose<
    void Function(
        BuildContext, String, String, String, String, String, String)>(
  (ref) {
    return (context, placeOfVisit, purposeOfVisit, outingDate, outTime, inDate,
        inTime) async {
      try {
        dynamic res = await postGeneralOutingForm(
            placeOfVisit, purposeOfVisit, outingDate, outTime, inDate, inTime);

        final snackBar = SnackBar(
          content: AwesomeSnackbarContent(
            title: 'Success!',
            message: '$res',
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } catch (e) {
        final snackBar = SnackBar(
          content: AwesomeSnackbarContent(
            title: 'Error!',
            message: 'Failed to submit outing form: $e',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    };
  },
);

// Weekend Outing Provider
final weekendOutingProvider = Provider.autoDispose<
    void Function(BuildContext, String, String, String, String, String)>(
  (ref) {
    return (
      context,
      placeOfVisit,
      purposeOfVisit,
      outingDate,
      outTime,
      contactNumber,
    ) async {
      try {
        dynamic res = await postWeekendOutingForm(
            placeOfVisit, purposeOfVisit, outingDate, outTime, contactNumber);

        final snackBar = SnackBar(
          content: AwesomeSnackbarContent(
            title: 'Success!',
            message: '$res',
            contentType: ContentType.success,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      } catch (e) {
        final snackBar = SnackBar(
          content: AwesomeSnackbarContent(
            title: 'Error!',
            message: 'Failed to submit outing form: $e',
            contentType: ContentType.failure,
          ),
        );
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(snackBar);
      }
    };
  },
);

// Weekend outing requests history provider
final weekendOutingRequestsProvider = FutureProvider<dynamic>((ref) async {
  return fetchWeekendOutingRequests();
});

// General outing requests history provider
final generalOutingRequestsProvider = FutureProvider<dynamic>((ref) async {
  return fetchGeneralOutingRequests();
});
