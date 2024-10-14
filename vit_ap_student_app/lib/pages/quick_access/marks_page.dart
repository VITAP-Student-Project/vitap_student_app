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
  late Future<List<Map<String, dynamic>>> marksData;
  DateTime? lastSynced;

  @override
  void initState() {
    super.initState();
    loadLastSynced();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      refreshMarksData();
    });
  }

  Future<void> loadLastSynced() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? lastSyncedString = prefs.getString('marksLastSynced');
    if (lastSyncedString == null) {}
    if (lastSyncedString != null) {
      setState(() {
        lastSynced = DateTime.parse(lastSyncedString);
      });
    }
  }

  Future<void> saveLastSynced() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('marksLastSynced', lastSynced!.toIso8601String());
  }

  Future<void> refreshMarksData() async {
    await ref.read(studentProvider.notifier).fetchAndUpdateMarks();
    setState(() {
      lastSynced = DateTime.now();
    });
    saveLastSynced();
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
      ),
      body: marksState.when(
          loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
          error: (error, _) => Text('Error: ${_}'),
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
            return Text("$marksState");
          }),
    );
  }
}
