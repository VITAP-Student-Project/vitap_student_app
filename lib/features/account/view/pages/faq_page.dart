import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';

class FAQPage extends StatefulWidget {
  const FAQPage({super.key});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreen('FAQPage');
  }

  final List<FAQItem> _faqItems = [
    FAQItem(
        question: 'How does this app work?',
        answer:
            'The app fetches your academic data from VIT-AP\'s VTOP portal using '
            'your credentials. It displays this information locally on your device.'
            'All academic data remains stored only on your device.'),
    FAQItem(
      question: 'From where do you get my data?',
      answer:
          'Academic data is retrieved directly from VIT-AP University\'s official '
          'VTOP portal using secure scraping methods.',
    ),
    FAQItem(
      question: 'Where is all my data stored?',
      answer: '• Academic data: Locally on your device\n'
          '• VTOP credentials: Encrypted storage (Keychain/iOS, Android KeyStore)\n'
          '• Usage analytics: Firebase Analytics (anonymized)',
    ),
    FAQItem(
      question: 'What data do you collect?',
      answer: '• VTOP login credentials (stored encrypted)\n'
          '• Anonymized usage analytics (screen views, interactions)\n'
          '• No academic data is collected or stored externally',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('FAQs')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ExpansionPanelList(
            dividerColor: Theme.of(context).colorScheme.surfaceContainerLow,
            elevation: 0,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _faqItems[index].isExpanded = isExpanded;
              });
            },
            children: _faqItems.map<ExpansionPanel>((FAQItem item) {
              return ExpansionPanel(
                backgroundColor:
                    Theme.of(context).colorScheme.surfaceContainerLowest,
                canTapOnHeader: true,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return ListTile(
                    tileColor:
                        Theme.of(context).colorScheme.surfaceContainerLowest,
                    title: Text(
                      item.question,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  );
                },
                body: ListTile(
                  tileColor:
                      Theme.of(context).colorScheme.surfaceContainerLowest,
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Text(item.answer),
                  ),
                ),
                isExpanded: item.isExpanded,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class FAQItem {
  String question;
  String answer;
  bool isExpanded;

  FAQItem({
    required this.question,
    required this.answer,
    this.isExpanded = false,
  });
}
