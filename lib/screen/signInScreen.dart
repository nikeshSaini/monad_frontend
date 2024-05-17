import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../components/signBody.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          actions: [
            Icon(Icons.arrow_back_ios, color: Colors.white,),
            SizedBox(width: 30,),
          ],
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Center(
            child: Text("SignIn",style: TextStyle(
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
        body: SafeArea(child: const signBody()),
      ),
    );
  }
}
