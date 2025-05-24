import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../utils/model/timetable_model.dart';
import '../../utils/provider/student_provider.dart';

class CurriculumPage extends ConsumerStatefulWidget {
  const CurriculumPage({super.key});

  @override
  ConsumerState<CurriculumPage> createState() => _CurriculumPageState();
}

class _CurriculumPageState extends ConsumerState<CurriculumPage> {
  @override
  Widget build(BuildContext context) {
    final studentState = ref.watch(studentProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Curriculum"),
      ),
      body: studentState.when(
        data: (student) {
          final Timetable timetable = student.timetable;
          final uniqueClasses = timetable.getUniqueClasses();
          return ListView.builder(
            itemCount: uniqueClasses.length,
            itemBuilder: (context, index) {
              final day = uniqueClasses[index];
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                child: ListTile(
                  isThreeLine: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9)),
                  tileColor: Theme.of(context).colorScheme.secondary,
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        day.courseName,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      day.courseType.contains("Theory")
                          ? Image.asset(
                              "assets/images/icons/theory.png",
                              height: 24,
                            )
                          : Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Image.asset(
                                "assets/images/icons/lab.png",
                                height: 24,
                              ),
                            ),
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        day.faculty,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    '${day.courseCode}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                ),
              );
            },
          );
        },
        loading: () {
          return Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stackTrace) {
          return Center(
            child: Text("Error: $error"),
          );
        },
      ),
    );
  }
}
