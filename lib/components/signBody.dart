import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:monad/screen/HomePage.dart';
import 'package:monad/screen/forgot_screen.dart';
import 'package:monad/screen/signup/signUp.dart';
import 'dart:convert';

import 'package:monad/style/appStyle.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool _obsureText = false;

class signBody extends StatefulWidget {
  const signBody({Key? key}) : super(key: key);

  @override
  State<signBody> createState() => _signBodyState();
}

// ignore: camel_case_types
class _signBodyState extends State<signBody> {
  late SharedPreferences prefs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool remember = false;
  bool changeButton = false;
  int time = 1;

  Future<void> _login(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });

      final String email = _emailController.text;
      final String password = _passwordController.text;

      // Your API endpoint URL
      // final response = await http.get(uriWithParams);

      try {
        final response = await http.post(
            Uri.parse('http://172.21.192.1:3000/api/users/login'),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: {
              'email': email,
              'password': password,
            });
        if (response.statusCode == 200) {
          var jsonResponse = jsonDecode(response.body);
          final String token = jsonResponse['token'];
          prefs.setString('token', token);
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(builder: (context) => const HomePage()),
          // );
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => HomePage(
                        token: token,
                      )));
          print("done");
          print(response.body);
        } else {
          print('failed');
          print(response.statusCode);
        }
      } catch (e) {
        print(e);
        // Handle exceptions, e.g., network errors
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('An error occurred. Please try again later.'),
          ),
        );
      }

      setState(() {
        changeButton = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight * 0.04),
            const Text(
              "Welcome Back",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
            const Text(
              "Sign in with your email and password \n continue with social media",
              style: TextStyle(
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.06),
            SignForm(
              formKey: _formKey,
              emailController: _emailController,
              passwordController: _passwordController,
              login: () => _login(context),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Checkbox(
                  value: remember,
                  onChanged: (value) {
                    setState(() {
                      remember = value!;
                    });
                  },
                ),
                const Text("Remember Me"),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const forgotPassword()),
                    );
                  },
                  child: const Text(
                    "Forgot password",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: screenHeight * 0.04),
            SizedBox(height: screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const signUpScreen()),
                    );
                  },
                  child: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget SocialCard(icon) {
  return GestureDetector(
    child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(20),
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFf5f6f9),
      ),
      child: SvgPicture.asset(icon),
    ),
  );
}

class SignForm extends StatelessWidget {
  const SignForm({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required this.login,
  })  : _formKey = formKey,
        _emailController = emailController,
        _passwordController = passwordController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final VoidCallback login;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _emailController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter the email";
              }
              return null;
            },
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
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(
                  color: kPrimaryColor,
                ),
                gapPadding: 10,
              ),
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter the password";
              }
              return null;
            },
            obscureText: !_obsureText,
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
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: const BorderSide(color: kPrimaryColor),
                gapPadding: 10,
              ), //used to when its not in used or tapped
            ),
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: login,
            child: Container(
              height: 56,
              width: double.infinity,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
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
        ],
      ),
    );
  }
}

// void forgotPassword() {
//   // Functionality for forgot password screen
// }

// void signUpScreen() {
//   // Functionality for sign up screen
// }

// class HomePage extends StatelessWidget {
//   final String token;

//   const HomePage({super.key, required this.token});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Home Page'),
//       ),
//       body: Center(
//         child: Text('Welcome! Your token is: $token'),
//       ),
//     );
//   }
// }

void main() {
  runApp(MaterialApp(
    title: 'Sign In Example',
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Sign In'),
      ),
      body: const signBody(),
    ),
  ));
}
