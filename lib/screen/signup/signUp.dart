import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'SignUpBody.dart';

class signUpScreen extends StatefulWidget {
  const signUpScreen({Key? key}) : super(key: key);

  @override
  State<signUpScreen> createState() => _signUpScreenState();
}

class _signUpScreenState extends State<signUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Icon(Icons.arrow_back_ios, color: Colors.white,),
          SizedBox(width: 30,),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Center(
          child: Text("SignUp",style: TextStyle(
              color: Color(0xFF888888),
              fontSize: 18
          ),textAlign: TextAlign.center,),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: const  SignUpBody(),
    );
  }
}


