import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'otpBody.dart';

class otp extends StatefulWidget {
  const otp({Key? key}) : super(key: key);

  @override
  State<otp> createState() => _otpState();
}

class _otpState extends State<otp> {
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
          child: Text("OTP Verification",style: TextStyle(
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
      body: otpBody(),
    );
  }
}
