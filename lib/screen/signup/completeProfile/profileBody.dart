
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../style/appStyle.dart';
import '../../HomePage.dart';
import '../otp/otp.dart';

class profileBody extends StatefulWidget {
  const profileBody({Key? key}) : super(key: key);

  @override
  State<profileBody> createState() => _profileBodyState();
}

class _profileBodyState extends State<profileBody> {
  @override
  Widget build(BuildContext context) {
  final screenHeight = MediaQuery.of(context).size.height;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: screenHeight*0.04),
            Text(
              "Complete Profile",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              textAlign: TextAlign.center,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Text(
                "Completer your profile or continue with social media",
                style: TextStyle(
                  color: ktextColor,

                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: screenHeight*0.06),
            ProfileForm(),
            SizedBox(height:screenHeight*0.04,),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal: 10.0),
             child: Text("By continuing you confirm that you agree with our Term and Condition",
             textAlign: TextAlign.center,),
           ),
            SizedBox(height: 10,),

          ],
        ),
      ),
    );
  }
}


class ProfileForm extends StatefulWidget {
  const ProfileForm({Key? key}) : super(key: key);

  @override
  State<ProfileForm> createState() => _ProfileFormState();
}

class _ProfileFormState extends State<ProfileForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
        child:Column(
          children: [
            TextFormField(
              validator: (value){
                if(value!.isEmpty){
                  return "Please enter your First Name";
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "First Name",
                  hintText: "Enter your First Name",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                    child: Icon(Icons.person_outline  ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: ktextColor),
                    gapPadding: 10,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: kPrimaryColor,),
                    gapPadding: 10,

                  )
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value){
                if(value!.isEmpty){
                  return "Please enter your First Name";
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "Last Name",
                  hintText: "Enter your Last Name",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                    child: Icon(Icons.person_outline ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: ktextColor),
                    gapPadding: 10,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: kPrimaryColor,),
                    gapPadding: 10,

                  )
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value){
                if(value!.isEmpty){
                  return "Please enter your First Name";
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "Phone Number",
                  hintText: "Enter your Phone Number",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                    child: Icon(Icons.phone_outlined ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: ktextColor),
                    gapPadding: 10,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: kPrimaryColor,),
                    gapPadding: 10,

                  )
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextFormField(
              validator: (value){
                if(value!.isEmpty){
                  return "Please enter your First Name";
                }
                return null;
              },
              decoration: InputDecoration(
                  labelText: "Address",
                  hintText: "Enter your Address",
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  suffixIcon: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 20, 20, 20),
                    child: Icon(Icons.location_on_outlined ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: ktextColor),
                    gapPadding: 10,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(40),
                    borderSide: BorderSide(color: kPrimaryColor,),
                    gapPadding: 10,

                  )
              ),
            ),
            SizedBox(
              height: 20,
            ),

            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> otp()));
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
          ],
        )
    );
  }
}

