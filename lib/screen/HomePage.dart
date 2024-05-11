import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:monad/screen/signInScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../style/appStyle.dart';
import 'attendancePreview.dart';
import 'attendancescreen.dart';
import 'expenseForm.dart';
import 'expensesPreview.dart';

class HomePage extends StatefulWidget {
  final token;
  const HomePage({@required this.token, Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Expense> expenses = [];

  @override
  void initState() {
    super.initState();
    WidgetsFlutterBinding.ensureInitialized();

    if (widget.token != null) {
      if (kDebugMode) {
        print('tokensec');
      }
      if (kDebugMode) {
        print(widget.token);
      }
      Map<String, dynamic> payload = Jwt.parseJwt(widget.token);
      if (kDebugMode) {
        print(payload['user']['fullName']);
      }
      _expensapi();
    } else {
      // Handle the case where widget.token is null
    }
  }

  Future<void> _expensapi() async {
    try {
      final decodedUserid = Jwt.parseJwt(widget.token)['user']['_id'];
      print(decodedUserid);
      final response = await http.post(
        Uri.parse(
          'http://172.21.192.1:3000/api/admin/view/expenseForm/$decodedUserid',
        ),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(response.body);

        // Extract expenses data from the response and set it
        List<dynamic> expenseRecords = jsonResponse['feedbacks'];
        setState(() {
          expenses = expenseRecords.map((record) {
            return Expense(
              date: DateTime.now(), // Set your date accordingly
              location: record['location'],
              lodgingAmount: record['lodging'].toDouble(),
              mealAmount: record['meal'].toDouble(),
              othersAmount: record['others'].toDouble(),
              description: record['description'],
            );
          }).toList();
        });
      } else {
        print('failed');
        print(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu),
            onPressed: () {
              Scaffold.of(context).openDrawer(); // Open the drawer
            },
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Image.asset(
              'assets/images/logo.png',
              width: 80,
              height: 40,
            ),
          ),
        ],
        elevation: 0,
      ),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 80),
            CustomButton("Attendance", const AttendanceScreen()),
            const SizedBox(height: 20),
            CustomButton("Expenses Form", const ExpenseForm()),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: Image.asset(
                'assets/images/logo.png',
                width: 80,
                height: 40,
              ),
            ),
            ListTile(
              title: const Text('Attendance '),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AttendancePreview(),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Expenses'),
              onTap: () async {
                await _expensapi();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExpensePreview(expenses: expenses),
                  ),
                );
              },
            ),
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SignInScreen()),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        color: Colors.black,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '© Monad Electronics.',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'All Rights Reserved',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    'Developed and managed by:Nikesh & Navneet',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget CustomButton(label, navigation) {
  return Builder(
    builder: (context) => InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => navigation),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: kthirdColor,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 100,
        width: 200,
        child: Center(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ),
  );
}
