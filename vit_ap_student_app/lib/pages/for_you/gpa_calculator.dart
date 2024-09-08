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
        title: Text(
          "GPA Calculator",
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.blue),
            onPressed: _addSubjectRow,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Display GPA result at the top
          if (gpa != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: MediaQuery.sizeOf(context).width,
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(
                      9,
                    ),
                  ),
                  child: Text(
                    "Your GPA : ${gpa!.toStringAsFixed(2)}",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.green.shade400,
                    ),
                  ),
                ),
              ),
            ),

          Expanded(
            child: ListView.builder(
              itemCount: selectedGrades.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Credits Dropdown
                      Expanded(
                          child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.tertiary,
                            width: 2.0,
                          ), // Outline border
                          borderRadius: BorderRadius.circular(9),
                        ),
                        child: DropdownButton<String>(
                          isExpanded:
                              true, // Makes the dropdown take full width of the container
                          value: selectedCredits[index],
                          borderRadius: BorderRadius.circular(9),
                          onChanged: (newValue) {
                            setState(() {
                              selectedCredits[index] = newValue!;
                            });
                          },
                          items: CREDITS.keys.map((credit) {
                            return DropdownMenuItem<String>(
                              value: credit,
                              child: Center(
                                child: Text(credit,
                                    textAlign:
                                        TextAlign.center), // Center the text
                              ),
                            );
                          }).toList(),
                          underline:
                              SizedBox(), // Removes the default underline
                        ),
                      )),

                      SizedBox(width: 12),

                      // Grades Dropdown
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.tertiary,
                                width: 2.0), // Outline border
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: DropdownButton<String>(
                            borderRadius: BorderRadius.circular(9),
                            isExpanded: true,
                            value: selectedGrades[index],
                            onChanged: (newValue) {
                              setState(() {
                                selectedGrades[index] = newValue!;
                              });
                            },
                            items: GRADES.keys.map((grade) {
                              return DropdownMenuItem<String>(
                                value: grade,
                                child: Center(
                                  child:
                                      Text(grade, textAlign: TextAlign.center),
                                ),
                              );
                            }).toList(),
                            underline:
                                SizedBox(), // Remove the default underline
                          ),
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
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.inversePrimary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
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

  // Calculating GPA
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
