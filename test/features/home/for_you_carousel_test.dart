import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:vit_ap_student_app/features/home/model/for_you_item.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/for_you_card.dart';
import 'package:vit_ap_student_app/features/home/view/widgets/for_you_carousel.dart';
import 'package:vit_ap_student_app/features/home/viewmodel/for_you_viewmodel.dart';

ForYouItem item({required String id, required String description}) {
  return ForYouItem(
    id: id,
    title: 'Tool $id',
    author: 'Someone',
    authorEmail: 'someone@vitapstudent.ac.in',
    // imageUrl left null so nothing reaches the network during the test.
    type: 'tools',
    description: description,
    url: 'https://example.com',
    isApproved: true,
    isFeatured: true,
    displayOrder: 0,
    likes: 0,
    createdAt: '2026-01-01T00:00:00Z',
  );
}

/// Serves a fixed list without the real notifier's fetch on build.
class _StubForYouViewModel extends ForYouViewModel {
  _StubForYouViewModel(this.items);

  final List<ForYouItem> items;

  @override
  AsyncValue<List<ForYouItem>> build() => AsyncValue.data(items);
}

Future<void> pumpCarousel(WidgetTester tester, List<ForYouItem> items) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [
        forYouViewModelProvider.overrideWith(() => _StubForYouViewModel(items)),
      ],
      child: const MaterialApp(
        home: Scaffold(
          body: CustomScrollView(
            slivers: [SliverToBoxAdapter(child: ForYouCarousel())],
          ),
        ),
      ),
    ),
  );
  await tester.pump();
}

void main() {
  testWidgets(
    // The carousel used to wrap its list in SizedBox(height: 350). A horizontal
    // ListView constrains children tightly, so every card was stretched to that
    // guess and left a strip of dead space under "Know more" — worse the
    // narrower the screen, because the card's height follows its width.
    'is exactly as tall as the cards it holds, with no fixed height',
    (tester) async {
      await pumpCarousel(tester, [
        item(id: 'a', description: 'Short one.'),
        item(id: 'b', description: 'Short one.'),
      ]);

      final cardHeight = tester.getSize(find.byType(ForYouCard).first).height;
      final sectionHeight = tester
          .getSize(find.byType(SingleChildScrollView))
          .height;

      expect(sectionHeight, cardHeight);
    },
  );

  testWidgets(
    // Cards size to their content now, so a one-line description would make its
    // card shorter than the others and leave the row ragged. The description
    // block is a fixed two lines to prevent that.
    'gives every card the same height regardless of description length',
    (tester) async {
      await pumpCarousel(tester, [
        item(id: 'a', description: 'Short.'),
        item(
          id: 'b',
          description:
              'A much longer description that will certainly wrap onto a '
              'second line and then run out of room entirely.',
        ),
      ]);

      final heights = tester
          .widgetList<ForYouCard>(find.byType(ForYouCard))
          .map((card) => tester.getSize(find.byWidget(card)).height)
          .toSet();

      expect(heights, hasLength(1));
    },
  );
}
