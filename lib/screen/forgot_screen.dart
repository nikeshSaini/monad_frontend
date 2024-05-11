
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:monad/screen/signup/signUp.dart';

import '../style/appStyle.dart';

class forgotPassword extends StatelessWidget {

  const forgotPassword({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
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
          child: Text("Forgot Password",style: TextStyle(
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
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 38),
          child: SingleChildScrollView(

            child: Column(
              children: [
                SizedBox(height: screenHeight*0.04,),
                Text(
                  "Forgot Password",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  "Please enter your email and we'll send you a link to return to your account",
                  style: TextStyle(
                    color: ktextColor,

                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: screenHeight*0.08),
                Form(
                 child:Column(
                   children: [
                    TextField(
                      decoration: InputDecoration(
                          labelText: "Email",
                          hintText: "Enter your email",
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 20,
                          ),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                            child: Icon(Icons.email_outlined ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: BorderSide(color: ktextColor),
                            gapPadding: 10,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40),
                            borderSide: BorderSide(color: ktextColor,),
                            gapPadding: 10,

                          )
                      ),
                    ),
                     SizedBox(height:screenHeight*0.06 ,),
                    Container(
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
                  ],
                ) ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: screenHeight*0.1,),
                    Text("Dont't have an account? ",style: TextStyle(
                      fontSize: 16,
                    ),),
                    GestureDetector(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> signUpScreen()));
                      },
                      child: Text("Sign Up", style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                        fontSize: 16,
                      ),),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
