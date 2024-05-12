import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screen/HomePage.dart';
import '../screen/forgot_screen.dart';
import '../screen/signInScreen.dart';
import '../screen/signup/signUp.dart';
import '../style/appStyle.dart';
import 'package:flutter_svg/svg.dart';

import 'adminlandingPage.dart';

bool _obscureText = false;

class AdminSignBody extends StatefulWidget {
  const AdminSignBody({Key? key}) : super(key: key);

  @override
  State<AdminSignBody> createState() => _AdminSignBodyState();
}

class _AdminSignBodyState extends State<AdminSignBody> {
  final _formKey = GlobalKey<FormState>();
  bool remember = false;
  bool changeButton = false;
  int time = 1;

  void moveToHome(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        changeButton = true;
      });
      await Future.delayed(Duration(seconds: time));
      await Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
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
            Text(
              "Welcome Admin",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "Sign in with your email and password \n ",
              style: TextStyle(
                color: ktextColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: screenHeight * 0.06),
            SignForm(key: _formKey),
            SizedBox(height: 20),
            SizedBox(height: screenHeight * 0.04),
            SizedBox(height: screenHeight * 0.03),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Are you a User? ",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => SignInScreen()));
                  },
                  child: Text(
                    "USER",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: kPrimaryColor,
                      fontSize: 16,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 10),
        ]),
      ),
    );
  }
}

Widget socialCard(icon) {
  return GestureDetector(
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      padding: EdgeInsets.all(20),
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(0xFFf5f6f9),
      ),
      child: SvgPicture.asset(icon),
    ),
  );
}

class SignForm extends StatefulWidget {
  const SignForm({Key? key}) : super(key: key);

  @override
  State<SignForm> createState() => _SignFormState();
}

class _SignFormState extends State<SignForm> {
  bool _isSubmitting = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            validator: (value){
              if(value!.isEmpty){
                return "Please Enter the email";
              }else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: "Admin Email",
              hintText: "Enter your email",
              contentPadding: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 20,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                child: Icon(Icons.email_outlined),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(color: ktextColor),
                gapPadding: 10,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(color: Colors.red),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(
                  color: kPrimaryColor,
                ),
                gapPadding: 10,
              ),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            validator: (value) {
              if (value!.isEmpty) {
                return "Please Enter the password";
              }
              return null;
            },
            obscureText: !_obscureText, // Use _obscureText to determine the visibility
            decoration: InputDecoration(
              labelText: "Admin Password",
              hintText: "Enter your password",
              contentPadding: EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 20,
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              suffixIcon: IconButton(
                icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText; // Toggle the visibility
                  });
                },
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(color: ktextColor),
                gapPadding: 10,
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(color: Colors.red),
                gapPadding: 10,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(40),
                borderSide: BorderSide(color: kPrimaryColor),
                gapPadding: 10,
              ),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                setState(() {
                  _isSubmitting = true;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Successfull')),
                  );
                  Future.delayed(Duration(seconds: 1), () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>AdminLandingPage()));
                  });
                });
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Failed')),
                );
              }
            },
            child: Container(
              height: 56,
              width: double.infinity,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  "Log-In",
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
