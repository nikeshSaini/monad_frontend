import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'adminLoginBody.dart';

class AdminSignInScreen extends StatefulWidget {
  const AdminSignInScreen({Key? key}) : super(key: key);

  @override
  State<AdminSignInScreen> createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Icon(Icons.arrow_back_ios, color: Colors.white),
            SizedBox(width: 30),
          ],
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Center(
            child: Text(
              "Admin Sign-In",
              style: TextStyle(
                color: Color(0xFF888888),
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: const AdminSignBody(), // You might have admin-specific content here
      ),
    );
  }
}
