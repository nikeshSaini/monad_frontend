import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../style/appStyle.dart';
import '../signInScreen.dart';

bool _obscureText = false;

class SignUpBody extends StatelessWidget {
  const SignUpBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.03),
            const Text(
              "Register Account",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: Text(
                "Complete your detail",
                style: TextStyle(
                  color: ktextColor,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: screenHeight * 0.04),
            SignUpForm(),
            SizedBox(
              height: screenHeight * 0.04,
            ),
            SizedBox(
              height: screenHeight * 0.03,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                "By continuing your confirm that you agree with our Team and Condition",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  const SignUpForm({Key? key}) : super(key: key);

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool _isSubmitting = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<void> _register(BuildContext context) async {

    final String name = _nameController.text;
    final String email = _emailController.text;
    final String password = _passwordController.text;
    print(name);
    try {
      final response = await http.post(
        Uri.parse('http://93.127.167.90:3000/api/users/signup'),
        headers: <String, String>{
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: {
          'fullName': name,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        // Handle successful registration, e.g., navigate to sign-in screen
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const SignInScreen()));
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Registered Successfully!!!'),
          ),
        );
      } else {
        // Handle registration failure
        if (kDebugMode) {
          print('Failed to register');
          print(response.statusCode);
        }
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to register'),
          ),
        );
      }
    } catch (e) {
      // Handle network or server errors
      print('Error: $e');
      // Handle exceptions, e.g., network errors
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred. Please try again later.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter your Name";
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Name",
              hintText: "Enter your Name",
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 20,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                child: Icon(Icons.person_2_outlined),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(color: ktextColor),
                gapPadding: 10,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(color:Colors.red ),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(
                  color: kPrimaryColor,
                ),
                gapPadding: 10,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _emailController,
            validator: (value){
              if(value!.isEmpty){
                return "Please Enter the email";
              }else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: "Email",
              hintText: "Enter your email",
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 20,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                child: Icon(Icons.email_outlined),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(color: ktextColor),
                gapPadding: 10,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(color:Colors.red ),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(
                  color: kPrimaryColor,
                ),

                gapPadding: 10,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter the password";
              }
              return null;
            },
            obscureText: true,
            decoration: InputDecoration(
              labelText: "Password",
              hintText: "Enter your password",
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 20,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                child: Icon(Icons.lock_outline),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(color: ktextColor),
                gapPadding: 10,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(color:Colors.red ),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(color: kPrimaryColor),
                gapPadding: 10,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                _register(context);
              }
            },
            borderRadius: BorderRadius.circular(20),
            child: Ink(
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                height: 56,
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 18,
                      color: CupertinoColors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }
}
