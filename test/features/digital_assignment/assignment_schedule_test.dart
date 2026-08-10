import 'package:flutter_test/flutter_test.dart';
import 'package:vit_ap_student_app/features/digital_assignment/model/digital_assignment_model.dart';
import 'package:vit_ap_student_app/features/digital_assignment/utils/assignment_schedule.dart';

final DateTime today = DateTime(2026, 7, 20);

AssignmentDetail detail({
  required String dueDate,
  String submissionStatus = '',
  String title = 'DA-1',
}) => AssignmentDetail(
  serialNumber: '1',
  assignmentTitle: title,
  maxAssignmentMark: '10',
  assignmentWeightageMark: '10',
  dueDate: dueDate,
  canQpDownload: false,
  qpDownloadUrl: '',
  submissionStatus: submissionStatus,
  canUpdate: false,
  mcode: 'm1',
  canDaDownload: false,
  daDownloadUrl: '',
);

void main() {
  group('parseAssignmentDueDate', () {
    test('reads the format VTOP sends', () {
      expect(parseAssignmentDueDate('25-Jul-2026'), DateTime(2026, 7, 25));
      expect(parseAssignmentDueDate(' 01-Jan-2026 '), DateTime(2026, 1, 1));
    });

    // Read inside list builders, so a bad row must degrade rather than throw.
    test('returns null for anything unparseable', () {
      expect(parseAssignmentDueDate(null), isNull);
      expect(parseAssignmentDueDate(''), isNull);
      expect(parseAssignmentDueDate('-'), isNull);
      expect(parseAssignmentDueDate('2026-07-25'), isNull);
      expect(parseAssignmentDueDate('32-Jul-2026'), isNull);
    });
  });

  group('dueLabel', () {
    test('names the near dates in words', () {
      expect(dueLabel('20-Jul-2026', now: today), 'Due today');
      expect(dueLabel('21-Jul-2026', now: today), 'Due tomorrow');
      expect(dueLabel('25-Jul-2026', now: today), 'Due in 5 days');
    });

    test('counts overdue days, singular and plural', () {
      expect(dueLabel('19-Jul-2026', now: today), 'Overdue by 1 day');
      expect(dueLabel('17-Jul-2026', now: today), 'Overdue by 3 days');
    });

    test('falls back to a plain date beyond a week', () {
      expect(dueLabel('05-Aug-2026', now: today), 'Due 5 Aug');
      expect(dueLabel('05-Aug-2027', now: today), 'Due 5 Aug 2027');
    });

    test('degrades to the raw string it cannot parse', () {
      expect(dueLabel('sometime', now: today), 'Due sometime');
      expect(dueLabel('', now: today), 'No due date');
    });

    test('ignores the time of day when counting', () {
      expect(
        dueLabel('21-Jul-2026', now: DateTime(2026, 7, 20, 23, 59)),
        'Due tomorrow',
      );
    });
  });

  group('assignmentUrgency', () {
    test('submitted and missed outrank the date', () {
      expect(
        assignmentUrgency(
          detail(dueDate: '01-Jan-2026', submissionStatus: '24 Jan 2026'),
          now: today,
        ),
        DueUrgency.done,
      );
      expect(
        assignmentUrgency(
          detail(dueDate: '01-Jan-2026', submissionStatus: 'File Not Uploaded'),
          now: today,
        ),
        DueUrgency.missed,
      );
    });

    test('grades an open assignment by how close the deadline is', () {
      expect(
        assignmentUrgency(detail(dueDate: '19-Jul-2026'), now: today),
        DueUrgency.overdue,
      );
      expect(
        assignmentUrgency(detail(dueDate: '21-Jul-2026'), now: today),
        DueUrgency.imminent,
      );
      expect(
        assignmentUrgency(detail(dueDate: '24-Jul-2026'), now: today),
        DueUrgency.soon,
      );
      expect(
        assignmentUrgency(detail(dueDate: '30-Aug-2026'), now: today),
        DueUrgency.later,
      );
    });
  });

  group('sortedForDisplay', () {
    test('puts outstanding work first, by deadline', () {
      final List<AssignmentDetail> sorted = sortedForDisplay(<AssignmentDetail>[
        detail(dueDate: '30-Jul-2026', title: 'later'),
        detail(dueDate: '01-Jan-2026', title: 'done', submissionStatus: 'done'),
        detail(dueDate: '21-Jul-2026', title: 'sooner'),
      ]);

      expect(
        sorted.map((AssignmentDetail d) => d.assignmentTitle).toList(),
        <String>['sooner', 'later', 'done'],
      );
    });

    test('sorts unparseable dates last rather than first', () {
      final List<AssignmentDetail> sorted = sortedForDisplay(<AssignmentDetail>[
        detail(dueDate: 'unknown', title: 'no date'),
        detail(dueDate: '30-Jul-2026', title: 'dated'),
      ]);

      expect(sorted.first.assignmentTitle, 'dated');
    });
  });

  group('nextActionable', () {
    test('finds the soonest still-open assignment', () {
      final AssignmentDetail? next = nextActionable(<AssignmentDetail>[
        detail(dueDate: '30-Jul-2026', title: 'later'),
        detail(dueDate: '21-Jul-2026', title: 'sooner'),
        detail(dueDate: '19-Jul-2026', title: 'gone', submissionStatus: 'x'),
      ]);
      expect(next?.assignmentTitle, 'sooner');
    });

    test('is null when nothing is left to do', () {
      expect(
        nextActionable(<AssignmentDetail>[
          detail(dueDate: '21-Jul-2026', submissionStatus: 'done'),
          detail(dueDate: '22-Jul-2026', submissionStatus: 'File Not Uploaded'),
        ]),
        isNull,
      );
    });
  });
}
