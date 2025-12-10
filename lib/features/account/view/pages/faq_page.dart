import 'package:flutter/material.dart';
import 'package:vit_ap_student_app/core/services/analytics_service.dart';

class FAQPage extends StatefulWidget {
  final int? expandedIndex;

  const FAQPage({super.key, this.expandedIndex});

  @override
  State<FAQPage> createState() => _FAQPageState();
}

class _FAQPageState extends State<FAQPage> {
  @override
  void initState() {
    super.initState();
    AnalyticsService.logScreen('FAQPage');

    // Auto-expand the specified FAQ item if provided
    if (widget.expandedIndex != null &&
        widget.expandedIndex! >= 0 &&
        widget.expandedIndex! < _faqItems.length) {
      _faqItems[widget.expandedIndex!].isExpanded = true;
    }
  }

  final List<FAQItem> _faqItems = [
    FAQItem(
      question: 'From where do you get my data?',
      answer:
          'Academic data is retrieved directly from VIT-AP University\'s official '
          'VTOP portal using secure scraping methods.',
    ),
    FAQItem(
      question: 'How do you get my data from VTOP?',
      answer:
          'We use a specialized Rust library that securely connects to VTOP and retrieves your academic information. This Rust code runs efficiently in the background and communicates with the app through a bridge system. Think of it as a secure translator that fetches your data from VTOP and presents it in a user-friendly format within the app. This method ensures fast, reliable, and secure data retrieval while maintaining the integrity of your academic information.',
    ),
    FAQItem(
      question: 'Where is all my data stored?',
      answer:
          'Your privacy and data security are our top priorities. All your academic data including grades, attendance records, timetables, and course information is stored locally on your device and never uploaded to external servers. Your VTOP login credentials are protected using your device\'s most secure storage systems - the iOS Keychain on iPhones and Android KeyStore on Android devices. This means only you have access to your data, and it remains completely private and secure on your personal device.',
    ),
    FAQItem(
      question: 'What data do you collect?',
      answer:
          'We respect your privacy and do not collect any of your personal academic data such as grades, attendance records, or course details. The only information we collect is completely anonymous usage data to help us improve the app. This includes general user interactions like which features are used most often, and basic demographic information such as your year of joining and academic branch. This anonymized data helps us understand our user base better and make improvements to enhance your experience. None of this data can be traced back to you personally.',
    ),
    FAQItem(
      question: 'How to change semester?',
      answer:
          'Changing your semester is simple and can be done in just a few steps. First, navigate to the Account Page. Then, tap on "Manage Credentials" to access your account settings. You\'ll see a semester dropdown menu where you can select your desired semester. After making your selection, make sure to press the "Save" button to confirm your changes. Once saved, return to the main screen and the app will automatically begin updating with data from your selected semester. If the data doesn\'t update immediately, you can manually refresh it by going back to the Account Page and tapping the "Sync" button to fetch the latest information from VTOP.',
    ),
    FAQItem(
      question: 'How to update VTOP credentials?',
      answer:
          'If you need to update your VTOP username or password, the process is straightforward. Start by going to the Account Page from the app\'s main navigation. Next, tap on "Manage Credentials" to access your login settings. Here you can update either your username or password fields with your new VTOP credentials. After making the necessary changes, be sure to press the "Save" button to store your updated information securely. Once saved, return to the Account Page and tap the "Sync" button to manually synchronize your data with VTOP using your new credentials. This ensures that the app can continue to fetch your latest academic information without any interruption.',
    ),
    FAQItem(
      question: 'How to bypass university Wi-Fi login limit?',
      answer:
          'In your registration number, replace the digit 2 or 3 with a 2️⃣ or 3️⃣ emoji respectively. This will authenticate you as a new user, effectively bypassing the login limit. For example: If your registration number is 23BCEXXXX, it should become 2️⃣3BCEXXXX or 23️⃣BCEXXXX.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        'FAQs',
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(fontWeight: FontWeight.w500),
      )),
      body: ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: _faqItems.length,
        itemBuilder: (context, index) {
          final item = _faqItems[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 4.0, top: 4),
            child: ExpansionTile(
              backgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerLow,
              collapsedBackgroundColor:
                  Theme.of(context).colorScheme.surfaceContainerLow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              collapsedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              initiallyExpanded: item.isExpanded,
              onExpansionChanged: (bool expanded) {
                setState(() {
                  _faqItems[index].isExpanded = expanded;
                });
              },
              title: Text(
                item.question,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    item.answer,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
          );
        },
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
