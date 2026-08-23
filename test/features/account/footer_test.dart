import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:vit_ap_student_app/features/account/view/widgets/footer.dart';

Future<void> pumpFooter(WidgetTester tester, {bool hideVersion = false}) async {
  await tester.pumpWidget(
    MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(child: Footer(hideVersion: hideVersion)),
      ),
    ),
  );
  // The footer waits on the package version before it renders anything.
  await tester.pumpAndSettle();
}

void main() {
  setUp(() {
    PackageInfo.setMockInitialValues(
      appName: 'VITAP Student',
      packageName: 'com.udhay.vitapstudentapp',
      version: '2.3.4',
      buildNumber: '27',
      buildSignature: '',
    );
  });

  group('AppIndependenceNotice', () {
    test('says both what the app is and what it is not', () {
      // The disclaimer is the point of the widget; a reword that drops either
      // half should be a deliberate act, not a silent edit.
      expect(AppIndependenceNotice.text, contains('independent app'));
      expect(AppIndependenceNotice.text, contains('built by a student'));
      expect(AppIndependenceNotice.text, contains('Not affiliated with'));
      expect(AppIndependenceNotice.text, contains('VIT-AP University'));
    });

    testWidgets('shows in the footer beside the version', (tester) async {
      await pumpFooter(tester);

      expect(find.byType(AppIndependenceNotice), findsOneWidget);
      expect(find.text('v2.3.4'), findsOneWidget);
    });

    testWidgets(
      // The About page hides the version but still needs the disclaimer — it is
      // not part of the version line.
      'still shows where the version is hidden',
      (tester) async {
        await pumpFooter(tester, hideVersion: true);

        expect(find.byType(AppIndependenceNotice), findsOneWidget);
        expect(find.text('v2.3.4'), findsNothing);
      },
    );

    testWidgets('carries no way to dismiss it', (tester) async {
      await pumpFooter(tester);

      expect(
        find.descendant(
          of: find.byType(AppIndependenceNotice),
          matching: find.byType(InkWell),
        ),
        findsNothing,
      );
      expect(
        find.descendant(
          of: find.byType(AppIndependenceNotice),
          matching: find.byType(GestureDetector),
        ),
        findsNothing,
      );
    });
  });
}
