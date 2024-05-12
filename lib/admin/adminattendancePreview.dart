import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

import '../style/appStyle.dart';




class AttendanceData {
  final DateTime startDate;
  final DateTime endDate;

  AttendanceData({required this.startDate, required this.endDate});
}

// Simulated method to fetch attendance data (replace with actual database logic)
Future<List<AttendanceData>> fetchAttendanceDataList() async {
  // Simulate fetching data from the database
  // You can replace this with your actual database logic in the future
  await Future.delayed(Duration(seconds: 1)); // Simulate delay

  // Dummy data for testing (replace with actual data in the future)
  List<AttendanceData> dummyData = [
    AttendanceData(
      startDate: DateTime(2024, 3, 30, 9, 0), // Example start date
      endDate: DateTime(2024, 3, 30, 17, 0), // Example end date
    ),
    AttendanceData(
      startDate: DateTime(2024, 3, 31, 9, 30), // Example start date
      endDate: DateTime(2024, 3, 31, 16, 30), // Example end date
    ),
    // Add more dummy data as needed
  ];

  return dummyData;
}

class AdminAttendancePreview extends StatefulWidget {
  @override
  _AdminAttendancePreviewState createState() => _AdminAttendancePreviewState();
}

class _AdminAttendancePreviewState extends State<AdminAttendancePreview> {
  late Future<List<AttendanceData>> _attendanceDataFuture;

  @override
  void initState() {
    super.initState();
    // Fetch attendance data when the widget is initialized
    _attendanceDataFuture = fetchAttendanceDataList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Preview',style: TextStyle(color: kthirdColor,fontWeight: FontWeight.bold)),
      ),
      body: FutureBuilder(
        future: _attendanceDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(), // Show loading indicator while fetching data
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'), // Show error message if fetching data fails
            );
          } else {
            // Data fetched successfully, display it
            List<AttendanceData> attendanceDataList = snapshot.data as List<AttendanceData>;

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Text(
                      'Attandance Record:',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  DataTable(
                    columns: <DataColumn>[
                      DataColumn(label: Text('S.No.')),
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Starting Time')),
                      DataColumn(label: Text('Ending Time')),
                      DataColumn(label: Text('Total Time')),
                    ],
                    rows: attendanceDataList.mapIndexed((index, attendanceData) {
                      Duration durationWorked = attendanceData.endDate.difference(attendanceData.startDate);
                      return DataRow(cells: [
                        DataCell(Text((index + 1).toString())),
                        DataCell(Text(DateFormat.yMMMd().format(attendanceData.startDate))),
                        DataCell(Text(DateFormat.Hm().format(attendanceData.startDate))),
                        DataCell(Text(DateFormat.Hm().format(attendanceData.endDate))),
                        DataCell(Text(_formatDuration(durationWorked))),
                      ]);
                    }).toList(),

                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  String _formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    return '$hours:$minutes:$seconds';
  }
}


