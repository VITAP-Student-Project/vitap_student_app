import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MyExamSchedule extends StatefulWidget {
  const MyExamSchedule({super.key});

  @override
  State<MyExamSchedule> createState() => _MyExamScheduleState();
}

class _MyExamScheduleState extends State<MyExamSchedule> {
  Map<String, dynamic> _examSchedule = {};

  @override
  void initState() {
    super.initState();
    _loadExamDetails();
  }

  Future<void> _loadExamDetails() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _examSchedule = jsonDecode(prefs.getString('exam_schedule') ?? '{}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exam Schedule'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildExamTable('CAT1'),
              SizedBox(height: 20),
              _buildExamTable('CAT2'),
              SizedBox(height: 20),
              _buildExamTable('FAT'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExamTable(String examType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$examType Schedule',
          style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blueAccent),
        ),
        SizedBox(height: 10),
        _examSchedule[examType] == null
            ? _buildNotFoundTable(examType)
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: DataTable(
                    border: TableBorder(
                      horizontalInside:
                          BorderSide(width: 1, color: Colors.grey.shade300),
                      verticalInside:
                          BorderSide(width: 1, color: Colors.grey.shade300),
                    ),
                    columns: const [
                      DataColumn(label: Text('Course Code')),
                      DataColumn(label: Text('Course Title')),
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Exam Time')),
                      DataColumn(label: Text('Class ID')),
                      DataColumn(label: Text('Reporting Time')),
                      DataColumn(label: Text('Seat Location')),
                      DataColumn(label: Text('Seat Number')),
                      DataColumn(label: Text('Session')),
                      DataColumn(label: Text('Slot')),
                      DataColumn(label: Text('Type')),
                      DataColumn(label: Text('Venue')),
                    ],
                    rows: (_examSchedule[examType] as Map<String, dynamic>)
                        .values
                        .map<DataRow>((exam) {
                      return DataRow(
                        cells: [
                          DataCell(Text(exam['course_code'])),
                          DataCell(Text(exam['course_title'])),
                          DataCell(Text(exam['date'])),
                          DataCell(Text(exam['exam_time'])),
                          DataCell(Text(exam['registration_number'])),
                          DataCell(Text(exam['reporting_time'])),
                          DataCell(Text(exam['seat_location'] ?? '-')),
                          DataCell(Text(exam['seat_number'])),
                          DataCell(Text(exam['session'])),
                          DataCell(Text(exam['slot'])),
                          DataCell(Text(exam['type'])),
                          DataCell(Text(exam['venue'])),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ),
      ],
    );
  }

  Widget _buildNotFoundTable(String examType) {
    return Text(
      'Data not found for $examType',
      style: TextStyle(fontSize: 16, color: Colors.red),
    );
  }
}
