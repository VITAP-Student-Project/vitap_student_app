import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/provider/student_provider.dart';

class MarksPage extends ConsumerStatefulWidget {
  const MarksPage({super.key});

  @override
  ConsumerState<MarksPage> createState() => _MarksPageState();
}

class _MarksPageState extends ConsumerState<MarksPage> {
  DateTime? lastSynced;

  @override
  void initState() {
    super.initState();
    loadLastSynced();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(studentProvider.notifier).loadLocalMarks();
    });
  }

  Future<void> loadLastSynced() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastSyncedString = prefs.getString('marksLastSynced');
    if (lastSyncedString != null) {
      setState(() {
        lastSynced = DateTime.parse(lastSyncedString);
      });
    }
  }

  Future<void> saveLastSynced() async {
    if (lastSynced != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('marksLastSynced', lastSynced!.toIso8601String());
    }
  }

  Future<void> refreshMarksData() async {
    await ref.read(studentProvider.notifier).fetchAndUpdateMarks();
    setState(() {
      lastSynced = DateTime.now();
    });
    saveLastSynced();
  }

  void showDetailsBottomSheet(Map<String, dynamic> course) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course['course_title'],
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                'Faculty: ${course['faculty']}',
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 16),
              const Text(
                'Marks Details:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              // Display details
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: course['details'].length,
                itemBuilder: (context, index) {
                  final detail = course['details'][index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      '${detail['mark_title']}: ${detail['scored_mark']} / ${detail['max_mark']} (Weightage: ${detail['weightage']})',
                      style: const TextStyle(fontSize: 16),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final marksState = ref.watch(studentProvider.notifier).marksState;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Marks",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.more_vert_rounded,
              color: Theme.of(context).colorScheme.primary,
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 0,
                child: Text(
                  "Refresh",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 0) {
                refreshMarksData();
              }
            },
          ),
        ],
      ),
      body: marksState.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, _) => Text('Error: $error'),
        data: (data) {
          if (data.isEmpty) {
            return Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Lottie.asset(
                      'assets/images/lottie/404_astronaut.json',
                      frameRate: const FrameRate(60),
                      width: 250,
                    ),
                  ),
                  const Text(
                    'Oops!',
                    style: TextStyle(fontSize: 32),
                  ),
                  const Text(
                    'Page not found',
                    style: TextStyle(fontSize: 32),
                  ),
                  const Text(
                    'The page you are looking for does not exist or some other error occurred',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final course = data[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                child: ListTile(
                  title: Text(course['course_title']),
                  subtitle: Text('Faculty: ${course['faculty']}'),
                  trailing: Icon(Icons.arrow_forward),
                  onTap: () {
                    showDetailsBottomSheet(course);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
