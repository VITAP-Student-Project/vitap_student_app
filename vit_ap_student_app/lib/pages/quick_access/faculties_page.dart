import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vit_ap_student_app/utils/constants.dart';
import '../../widgets/custom/leading_icon.dart';

class FacultiesPage extends StatefulWidget {
  @override
  _FacultiesPageState createState() => _FacultiesPageState();
}

class _FacultiesPageState extends State<FacultiesPage> {
  List<Map<String, dynamic>> filteredFacultyData = FACULTY_DATA;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchController.addListener(_filterFacultyList);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterFacultyList);
    searchController.dispose();
    super.dispose();
  }

  void _filterFacultyList() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredFacultyData = FACULTY_DATA
          .where((faculty) => faculty['name'].toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    //filteredFacultyData.sort((a, b) => a['name'].toString().compareTo(b['name'].toString()));
    return Scaffold(
      appBar: AppBar(
        title: Text('Faculties'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Search faculty name...',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredFacultyData.length,
              itemBuilder: (context, index) {
                final faculty = filteredFacultyData[index];
                return ListTile(
                  tileColor: Theme.of(context).colorScheme.secondary,
                  title: Text(
                    faculty['name'],
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    faculty['cabin_number'] == ""
                        ? "N/A"
                        : faculty['cabin_number'],
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                    ),
                  ),
                  leading: LeadingIcon(
                    name: faculty['name'],
                  ),
                  onTap: () {
                    _showFacultyDetails(context, faculty);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFacultyDetails(BuildContext context, Map<String, dynamic> faculty) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
              ),
              Text(
                faculty['name'],
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Designation',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                "${faculty['designation']}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Department',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                "${faculty['department']}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'School',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                "${faculty['school']}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Email',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              GestureDetector(
                onTap: () async {
                  if (!await launchUrl(Uri(
                    scheme: 'mailto',
                    path: faculty['email'],
                  ))) {
                    throw Exception('Could not mail to ${faculty['email']}');
                  }
                },
                child: Text(
                  "${faculty['email']}",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Cabin Number',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              Text(
                faculty['cabin_number'] == ""
                    ? "N/A"
                    : "${faculty['cabin_number']}",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.tertiary,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Open Hours:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(
                height: 2,
              ),
              if (faculty['open_hours'].isNotEmpty) ...[
                Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Weekday'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Hours'),
                        ),
                      ],
                    ),
                    ...faculty['open_hours'].map<TableRow>((hour) {
                      return TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(hour['weekday']),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(hour['hours']),
                          ),
                        ],
                      );
                    }).toList(),
                  ],
                ),
              ] else
                Text(
                  'N/A',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.tertiary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
