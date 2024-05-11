import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
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
  await Future.delayed(const Duration(seconds: 1)); // Simulate delay

  // Dummy data for testing (replace with actual data in the future)
  List<AttendanceData> dummyData = [
    AttendanceData(startDate: DateTime.now(), endDate: DateTime.now())
  ];

  try {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('token'));

    final response = await http.post(
      Uri.parse('http://93.127.167.90:3000/api/users/view/attendance'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'token': prefs.getString('token'),
      },
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      print('Response: $jsonResponse');
      if (jsonResponse.containsKey('attendanceRecords')) {
        List<dynamic> attendanceRecords = jsonResponse['attendanceRecords'];
        print('Attendance Records: $attendanceRecords');
        List<AttendanceData> attendanceDataList =
            attendanceRecords.map((record) {
          print(record['startTime']);
          DateTime startDate = DateTime.parse(record['startTime']);
          DateTime istTime = startDate.toLocal();
          String formattedIST =
              DateFormat('yyyy-MM-dd HH:mm:ss').format(istTime);
          DateTime formattedISTDateTime =
              DateFormat('yyyy-MM-dd HH:mm:ss').parse(formattedIST);
          print(formattedIST);

// format date end
          // DateTime endDateTime = DateTime.parse(record['endTimme']);
          // DateTime istTimeEnd = endDateTime.toLocal();
          // String formattedISTEnd =
          //     DateFormat('yyyy-MM-dd HH:mm:ss').format(istTimeEnd);
          // DateTime formattedISTDateTimeValue = DateFormat('yyyy-MM-dd HH:mm:ss').parse(formattedISTEnd);
          // print(formattedISTDateTimeValue);

          DateTime endDate = record.containsKey('endTime')
              ? DateTime.parse(record['endTime']).toLocal()
              : DateTime.now();

          return AttendanceData(
            startDate: formattedISTDateTime,
            endDate: endDate,
          ); 
        }).toList();

        // Now you have a list of AttendanceData objects
        print("Attendance Records:");
        attendanceDataList.forEach((attendanceData) {
          print(
              "Start Date: ${attendanceData.startDate}, End Date: ${attendanceData.endDate}");
        });

        return attendanceDataList;
      } else {
        print("No attendance records found in the response.");
      }

      print("done");
      print(response.body);
    } else {
      print('failed');
      print(response.statusCode);
    }
  } catch (e) {
    print(e);
    print('Something went wrong');
  }
  return dummyData;
}

class AttendancePreview extends StatefulWidget {
  @override
  _AttendancePreviewState createState() => _AttendancePreviewState();
}

class _AttendancePreviewState extends State<AttendancePreview> {
  late final Future<List<AttendanceData>> _attendanceDataFuture;

  @override
  void initState() {
    super.initState();
    // Fetch attendance data when the widget is initialized
    _attendanceDataFuture = fetchAttendanceDataList();
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Preview',
            style: TextStyle(color: kthirdColor, fontWeight: FontWeight.bold)),
      ),
      body: FutureBuilder(
        future: _attendanceDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child:
                  CircularProgressIndicator(), // Show loading indicator while fetching data
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                  'Error: ${snapshot.error}'), // Show error message if fetching data fails
            );
          } else {
            // Data fetched successfully, display it
            List<AttendanceData> attendanceDataList =
                snapshot.data as List<AttendanceData>;
            print(attendanceDataList);

            return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    columns: const <DataColumn>[
                      DataColumn(label: Text('S.No.')),
                      DataColumn(label: Text('Date')),
                      DataColumn(label: Text('Starting Time')),
                      DataColumn(label: Text('Ending Time')),
                      DataColumn(label: Text('Total Time')),
                    ],
                    rows:
                        attendanceDataList.mapIndexed((index, attendanceData) {
                      Duration durationWorked = attendanceData.endDate
                          .difference(attendanceData.startDate);
                      return DataRow(cells: [
                        DataCell(Text((index + 1).toString())),
                        DataCell(Text(DateFormat.yMMMd()
                            .format(attendanceData.startDate))),
                        DataCell(Text(
                            DateFormat.Hm().format(attendanceData.startDate))),
                        DataCell(Text(
                            DateFormat.Hm().format(attendanceData.endDate))),
                        DataCell(Text(_formatDuration(durationWorked))),
                      ]);
                    }).toList(),
                  ),
                ));
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
