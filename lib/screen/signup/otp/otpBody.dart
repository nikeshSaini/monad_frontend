
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../style/appStyle.dart';
import '../../HomePage.dart';

class otpBody extends StatefulWidget {
  const otpBody({Key? key}) : super(key: key);

  @override
  State<otpBody> createState() => _otpBodyState();
}

class _otpBodyState extends State<otpBody> {
  @override
  Widget build(BuildContext context) {
  var screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        child: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Column(
              children: [
                SizedBox(height: screenHeight*0.04),
                Text(
                  "OTP Verification",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "We sent your code to  +91 911***",
                  style: TextStyle(
                    color: ktextColor,

                  ),
                  textAlign: TextAlign.center,
                ),
                BuildTimer(),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: OtpForm(),
                ),
                SizedBox(height: screenHeight *0.1 ,),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
                  },
                  child: Container(
                    height: (56),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: kPrimaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(child: Text("Continue", style: TextStyle(
                      fontSize: (18),
                      color: CupertinoColors.white,
                    ),)),
                  ),
                ),
                SizedBox(height: screenHeight * 0.1,),
                GestureDetector(
                  onTap: (){

                  },
                  child: Text(
                    "Resent the Otp",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget BuildTimer(){
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(
        "This code will expire in ",
        style: TextStyle(
          color: ktextColor,

        ),
        textAlign: TextAlign.center,
      ),
      TweenAnimationBuilder(tween: Tween(begin :30.0, end: 0.0),
          duration: (Duration(seconds: 30)),
          builder: (context , value, child)=>Text(
            "00:${value.toInt()}",
            style: TextStyle(
              color: Colors.red,
            ),
          )
      )
    ],
  );
}

class OtpForm extends StatefulWidget {
  const OtpForm({Key? key}) : super(key: key);

  @override
  State<OtpForm> createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
    FocusNode? pin2FocusNode;
    FocusNode? pin3FocusNode;
    FocusNode? pin4FocusNode;
  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  @override
  void dispose() {
    pin2FocusNode?.dispose();
    pin3FocusNode?.dispose();
    pin4FocusNode?.dispose();
    super.dispose();

  }

  void nextField({required String value, required FocusNode focusenode}){
    if(value.length ==1 ){
      focusenode.requestFocus();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Form(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 60,
            child: TextFormField(
              onChanged: (value){

              },
              autofocus: true,
              obscureText: true,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 20),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: ktextColor,
                  )
                ),
                focusedBorder:  OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: kPrimaryColor,
                    )
                )
              ),
            ),
          ),
          SizedBox(
            width: 60,
            child: TextFormField(
              focusNode: pin2FocusNode,
              obscureText: true,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: ktextColor,
                      )
                  ),
                  focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                      )
                  )
              ),
            ),
          ),
          SizedBox(
            width: 60,
            child: TextFormField(
              focusNode: pin3FocusNode,
              obscureText: true,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: ktextColor,
                      )
                  ),
                  focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                      )
                  )
              ),
            ),
          ),
          SizedBox(
            width: 60,
            child: TextFormField(
              focusNode: pin4FocusNode,
              obscureText: true,
              keyboardType: TextInputType.number,
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 20),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: ktextColor,
                      )
                  ),
                  focusedBorder:  OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide(
                        color: kPrimaryColor,
                      )
                  )
              ),
            ),
          ),


        ],
      ),
    );
  }
}

