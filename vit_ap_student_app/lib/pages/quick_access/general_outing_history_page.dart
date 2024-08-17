import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import '../../utils/provider/providers.dart';

class GeneralOutingHistoryPage extends ConsumerStatefulWidget {
  const GeneralOutingHistoryPage({super.key});

  @override
  ConsumerState<GeneralOutingHistoryPage> createState() =>
      _GeneralOutingHistoryPageState();
}

void _showDetails(BuildContext context, Map<String, dynamic> request) {
  // Define private variables for the request parameters
  String _status = request['status']?.toString() ?? 'N/A';
  String _leaveId = request['leave_id']?.toString() ?? 'N/A';
  String _placeOfVisit = request['place_of_visit']?.toString() ?? 'N/A';
  String _purposeOfVisit = request['purpose_of_visit']?.toString() ?? 'N/A';
  String _fromDate = request['from_date'] != null
      ? DateFormat("dd-MM-yyyy").format(DateTime.parse(request['from_date']))
      : 'N/A';
  String _fromTime = request['from_time']?.toString() ?? 'N/A';
  String _toDate = request['to_date'] != null
      ? DateFormat("dd-MM-yyyy").format(DateTime.parse(request['to_date']))
      : 'N/A';
  String _toTime = request['to_time']?.toString() ?? 'N/A';

  showModalBottomSheet(
    isScrollControlled: true,
    context: context,
    builder: (BuildContext context) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 325,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _status.contains("Accepted")
                    ? Colors.greenAccent.shade200.withOpacity(0.25)
                    : _status.contains("Waiting")
                        ? Colors.blue.shade400.withOpacity(0.1)
                        : Colors.red.shade400.withOpacity(0.25),
              ),
              child: Padding(
                padding: EdgeInsets.all(25.0),
                child: CircleAvatar(
                  radius: 15,
                  backgroundColor: _status.contains("Accepted")
                      ? Colors.greenAccent
                      : _status.contains("Waiting")
                          ? Colors.blueAccent
                          : Colors.redAccent,
                  child: Icon(
                    _status.contains("Accepted")
                        ? Icons.check
                        : _status.contains("Waiting")
                            ? Icons.hourglass_empty_rounded
                            : Icons.close_rounded,
                    size: 20,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.sizeOf(context).width,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                _status.contains("Accepted")
                    ? "Request Accepted"
                    : _status.contains("Waiting")
                        ? "Request Applied"
                        : "Request Rejected",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            Text(
              _status.contains("Accepted")
                  ? "Your request has been successfully accepted."
                  : _status.contains("Waiting")
                      ? "Waiting for approval from mentor"
                      : "Your request has been rejected",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Place",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        Text(
                          _placeOfVisit,
                          style: const TextStyle(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Purpose",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        Text(
                          _purposeOfVisit,
                          style: const TextStyle(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "From date",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        Text(
                          _fromDate,
                          style: const TextStyle(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "From time",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        Text(
                          _fromTime,
                          style: const TextStyle(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "To date",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        Text(
                          _toDate,
                          style: const TextStyle(),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "To time",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        Text(
                          _toTime,
                          style: const TextStyle(),
                        ),
                      ],
                    ),
                    const Text(
                      '- - - - - - - - - - - - - - - - - - - - - - - - - - - -',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w200),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Booking ID",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        Text(
                          _leaveId,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Status",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 1, horizontal: 5),
                          decoration: BoxDecoration(
                            color: _status.contains("Accepted")
                                ? Colors.greenAccent.shade400.withOpacity(0.1)
                                : _status.contains("Waiting")
                                    ? Colors.blue.shade400.withOpacity(0.25)
                                    : Colors.red.shade400.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: Text(
                            _status.contains("Accepted")
                                ? "Accepted"
                                : _status.contains("Rejected")
                                    ? "Rejected"
                                    : "Waiting",
                            style: TextStyle(
                              color: _status.contains("Accepted")
                                  ? Colors.green
                                  : _status.contains("Waiting")
                                      ? Colors.blue
                                      : Colors.red,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            if (_status.contains("Accepted"))
              MaterialButton(
                onPressed: () {},
                height: 60,
                minWidth: 325,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                color: Colors.greenAccent.shade400,
                textColor: Theme.of(context).colorScheme.secondary,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.file_download_outlined),
                    SizedBox(
                      width: 7,
                    ),
                    Text('Download PDF'),
                  ],
                ),
              ),
            if (_status.contains("Rejected"))
              MaterialButton(
                onPressed: null,
                height: 60,
                minWidth: 325,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                disabledColor: Colors.grey,
                disabledTextColor: Theme.of(context).colorScheme.secondary,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.file_download_outlined),
                    SizedBox(
                      width: 7,
                    ),
                    Text('Download PDF'),
                  ],
                ),
              ),
            if (_status.contains("Waiting"))
              MaterialButton(
                enableFeedback: false,
                onPressed: null,
                height: 60,
                minWidth: 325,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
                disabledColor: Colors.grey,
                disabledTextColor: Theme.of(context).colorScheme.secondary,
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.file_download_outlined),
                    SizedBox(
                      width: 7,
                    ),
                    Text('Download PDF'),
                  ],
                ),
              ),
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
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                        tileColor: Theme.of(context).colorScheme.secondary,
                        title: Text(request['place_of_visit']),
                        subtitle: Text(
                            '${request['from_date'].toString().split(" ")[0]} - ${request['to_date'].toString().split(" ")[0]}'),
                        trailing: Icon(Icons.arrow_forward_ios_rounded),
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
              return Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      "assets/images/lottie/loading_files.json",
                      frameRate: const FrameRate(60),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "Hang tight!",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      "🚪 Fetching your ‘Get Out of Campus’ card... ",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
