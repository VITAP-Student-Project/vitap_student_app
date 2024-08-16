import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/provider/providers.dart';

class GeneralOutingHistoryPage extends ConsumerStatefulWidget {
  const GeneralOutingHistoryPage({super.key});

  @override
  ConsumerState<GeneralOutingHistoryPage> createState() =>
      _GeneralOutingHistoryPageState();
}

void _showDetails(BuildContext context, Map<String, dynamic> request) {
  showModalBottomSheet(
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
            ),
            Text('Booking ID: ${request['booking_id']}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 8),
            Text('Date: ${request['date']}'),
            Text('Place: ${request['place_of_visit']}'),
            Text('Purpose: ${request['purpose_of_visit']}'),
            Text('Status: ${request['status']}'),
            Text('Contact Number: ${request['contact_number']}'),
            Text('Parent Contact Number: ${request['parent_contact_number']}'),
            Text('Hostel Block: ${request['hostel_block']}'),
            Text('Registration Number: ${request['registration_number']}'),
            Text('Room Number: ${request['room_number']}'),
            Text('Time: ${request['time']}'),
          ],
        ),
      );
    },
  );
}

class _GeneralOutingHistoryPageState
    extends ConsumerState<GeneralOutingHistoryPage> {
  @override
  Widget build(BuildContext context) {
    final _generalOutingRequestsFuture =
        ref.watch(generalOutingRequestsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("Requests"),
        actions: [
          TextButton(
            onPressed: () {
              // Trigger a refresh
              ref.refresh(generalOutingRequestsProvider);
            },
            child: Text(
              "Refresh",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _generalOutingRequestsFuture.when(
            data: (data) {
              final bookingRequests =
                  data['booking_requests'] as Map<String, dynamic>;
              final requests = bookingRequests.values.toList();

              return ListView.builder(
                shrinkWrap: true,
                itemCount: requests.length,
                itemBuilder: (context, index) {
                  final request = requests[index] as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    child: Container(
                      height: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      child: ListTile(
                        title: Text(request['place_of_visit']),
                        subtitle: Text(
                            '${request['from_date'].toString().split(" ")[0]} - ${request['to_date'].toString().split(" ")[0]}'),
                        onTap: () => _showDetails(context, request),
                      ),
                    ),
                  );
                },
              );
            },
            error: (error, stackTrace) {
              return Text('Error: $error');
            },
            loading: () {
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
