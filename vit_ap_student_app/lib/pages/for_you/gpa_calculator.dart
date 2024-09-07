import 'package:flutter/material.dart';
import '../../utils/constants.dart';

class GPACalculatorPage extends StatefulWidget {
  @override
  _GPACalculatorPageState createState() => _GPACalculatorPageState();
}

class _GPACalculatorPageState extends State<GPACalculatorPage> {
  List<String> selectedGrades = ["Grade"];
  List<String> selectedCredits = ["Credits"];
  double? gpa;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GPA Calculator"),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.blue),
            onPressed: _addSubjectRow,
          ),
        ],
      ),
      body: Column(
        children: [
          // Display GPA result at the top
          if (gpa != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Your GPA: ${gpa!.toStringAsFixed(2)}",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),

          Expanded(
            child: ListView.builder(
              itemCount: selectedGrades.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Credits Dropdown
                      Expanded(
                        child: DropdownButton<String>(
                          value: selectedCredits[index],
                          onChanged: (newValue) {
                            setState(() {
                              selectedCredits[index] = newValue!;
                            });
                          },
                          items: CREDITS.keys.map((credit) {
                            return DropdownMenuItem<String>(
                              value: credit,
                              child: Text(credit),
                            );
                          }).toList(),
                        ),
                      ),

                      SizedBox(width: 20),

                      // Grades Dropdown
                      Expanded(
                        child: DropdownButton<String>(
                          value: selectedGrades[index],
                          onChanged: (newValue) {
                            setState(() {
                              selectedGrades[index] = newValue!;
                            });
                          },
                          items: GRADES.keys.map((grade) {
                            return DropdownMenuItem<String>(
                              value: grade,
                              child: Text(grade),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),

          // Centered Calculate GPA Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _calculateGPA,
              child: Text("Calculate GPA"),
            ),
          ),
        ],
      ),
    );
  }

  // Add a new row for another subject
  void _addSubjectRow() {
    setState(() {
      selectedGrades.add("Grade");
      selectedCredits.add("Credits");
    });
  }

  // Calculate GPA using the formula provided
  void _calculateGPA() {
    double totalCredits = 0;
    double weightedSum = 0;
    for (int i = 0; i < selectedGrades.length; i++) {
      double credit = CREDITS[selectedCredits[i]]!;
      int grade = GRADES[selectedGrades[i]]!;
      totalCredits += credit;
      weightedSum += credit * grade;
    }
    setState(() {
      gpa = weightedSum / totalCredits;
    });
  }
}
