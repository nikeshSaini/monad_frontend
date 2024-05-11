
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monad/screen/signup/completeProfile/profileBody.dart';

class profileScreen extends StatelessWidget {
  const profileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          Icon(Icons.arrow_back_ios, color: Colors.white,),
          SizedBox(width: 30,),
        ],
        systemOverlayStyle: SystemUiOverlayStyle.light,
        title: Center(
          child: Text("Sign Up",style: TextStyle(
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
      body: profileBody(),
    );
  }
}
