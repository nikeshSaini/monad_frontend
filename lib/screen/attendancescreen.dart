import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart'; // Import geolocator package
import 'package:shared_preferences/shared_preferences.dart'; // Import shared_preferences package
import '../style/appStyle.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  bool isWorking = false;
  late Position position;
  late DateTime startTime;
  late DateTime endTime;
  late Timer _timer;
  int _secondsElapsed = 0;

  String formatDuration(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$hours hour: $minutes mins: $remainingSeconds secs';
  }

  // Future<void> _fetchUserLocation() async {
  //   // Request location permission
  //   LocationPermission permission = await Geolocator.requestPermission();
  //   if (permission != LocationPermission.denied &&
  //       permission != LocationPermission.deniedForever) {
  //     // Get current location
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     // Print or store the user's location
  //     print('User Location: ${position.latitude}, ${position.longitude}');
  //     // setState(() {
  //     //   this.position = position;
  //     // });
  //   } else {
  //     // Handle permission denied case
  //     print('Location permission denied.');
  //   }
  // }
  Future<Position> _fetchUserLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    if (permission != LocationPermission.denied &&
        permission != LocationPermission.deniedForever) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      print('User Location: ${position.latitude}, ${position.longitude}');
      return position; // Return the position
    } else {
      print('Location permission denied.');
      throw Exception('Location permission denied.');
    }
  }

  Future<void> startWork() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      print(prefs.getString('token'));
      position = await _fetchUserLocation();
      setState(() {
        isWorking = true;
        startTime = DateTime.now();

        // Start timer
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            _secondsElapsed++;
          });
        });
      });

      // Store start time in SharedPreferences
      await prefs.setInt('start_time', startTime.millisecondsSinceEpoch);

      print("done api");
      // Make API call only after the user's location is fetched
      final response = await http.post(
        Uri.parse('http://93.127.167.90:3000/api/users/start'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'token': prefs.getString('token'),
          'latitude': position.latitude.toString(),
          'longitude': position.longitude.toString(),
        },
      );
      if (response.statusCode == 200) {
        print("done");
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User Saved'),
          ),
        );
      } else {
        print('failed');
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again later.'),
        ),
      );
    }
  }

  void endWork() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      setState(() {
        isWorking = false;
        endTime = DateTime.now();
        _timer.cancel();
        // Fetch user location when work ends
        _fetchUserLocation();
        // Here you can submit the attendance data with startTime, endTime, and location
        // For now, let's just print the duration
        print('Work Duration: ${formatDuration(_secondsElapsed)}');
      });
      final response = await http.post(
        Uri.parse('http://93.127.167.90:3000/api/users/end'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'token': prefs.getString('token'),
        },
      );
      if (response.statusCode == 200) {
        print("done");
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        print(response.body);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('User work ended'),
          ),
        );
      } else {
        print('failed');
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again later.'),
        ),
      );
    }
    // try {
    //   SharedPreferences prefs = await SharedPreferences.getInstance();
    //   print(prefs.getString('token'));
    //   final response = await http.post(
    //       Uri.parse('http://172.31.160.1:3000/api/users/view/attendance'),
    //       headers: {
    //         'Content-Type': 'application/x-www-form-urlencoded',
    //       },
    //       body: {
    //         'token': prefs.getString('token'),
    //       });
    //   if (response.statusCode == 200) {
    //     var jsonResponse = jsonDecode(response.body);
    //     print(jsonResponse);
    //     // final String token = jsonResponse['token'];
    //     // Navigator.pushReplacement(
    //     //   context,
    //     //   MaterialPageRoute(builder: (context) => const HomePage()),
    //     // )

    //     // Navigator.push(
    //     //     context,
    //     //     MaterialPageRoute(
    //     //         builder: (context) => HomePage(
    //     //               token: token,
    //     //             )));
    //     print("done");
    //     print(response.body);
    //   } else {
    //     print('failed');
    //     print(response.statusCode);
    //   }
    // } catch (e) {
    //   print(e);
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(
    //       content: Text('An error occurred. Please try again later.'),
    //     ),
    //   );
    // }
    // Clear start time from SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('start_time');
  }

  @override
  void initState() {
    super.initState();
    _resumeTimer();
  }

  Future<void> _resumeTimer() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? savedStartTime = prefs.getInt('start_time');
    if (savedStartTime != null) {
      setState(() {
        isWorking = true;
        startTime = DateTime.fromMillisecondsSinceEpoch(savedStartTime);
        _secondsElapsed = ((DateTime.now().millisecondsSinceEpoch -
                    startTime.millisecondsSinceEpoch) /
                1000)
            .floor();
        _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
          setState(() {
            _secondsElapsed++;
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attendance Page',
          style: TextStyle(color: kthirdColor, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 60),
            Text(
              isWorking ? 'Tap to end the work' : 'Tap to start working:',
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: isWorking ? endWork : startWork,
              child: Text(isWorking ? 'End Work' : 'Start Work'),
            ),
            if (isWorking) const SizedBox(height: 20),
            if (isWorking)
              Text(
                'Working Duration: ${formatDuration(_secondsElapsed)}',
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

void main() {
  runApp(const MaterialApp(
    home: AttendanceScreen(),
  ));
}
