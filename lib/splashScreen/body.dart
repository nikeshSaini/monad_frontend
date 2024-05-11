
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screen/signInScreen.dart';
import '../style/appStyle.dart';
import '../style/size_config.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage =0;
  int time = 1;
  List<Map<String, String>> splashData =[
    {
      "image" : "assets/images/splash_1.png",
      "text" : "Electronics!"
    },
    {
      "image" : "assets/images/splash_2.png",
      "text" : "We help people to connect with store \n in India"
    },
  ];


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            flex: 3,
              child: PageView.builder(
                onPageChanged: (value){
                  setState(() {
                    currentPage = value;
                  });
                },
                itemCount: splashData.length,
                itemBuilder: (context,index) =>
                SplashContent(
                  image: splashData[index]["image"],
                  text: splashData[index]["text"],
                ),
              )
          ),
          Expanded(
            flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      splashData.length,
                          (index) => buildDot(index),
                    ),
                  ),
                  Spacer(flex: 2,),
                  InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> SignInScreen() )),
                    splashColor: Colors.grey,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:20 ),
                      child: Container(
                        height: getProptionalScreenHeight(56),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: Center(child: Text("Continue", style: TextStyle(
                          fontSize: getProptionalScreenWidth(18),
                          color: CupertinoColors.white,
                        ),)),
                      ),
                    ),
                  ),
                  Spacer()
                ],
              )
          )

        ],
      ),
    );
  }

  Widget buildDot(int ?index) {
    return Container(
                  margin: EdgeInsets.only(right: 5),
                  height: 6,
                  width: currentPage == index ? 20 : 6,
                  decoration: BoxDecoration(
                    color: currentPage == index
                        ? kPrimaryColor
                        :Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
  }
}


class SplashContent extends StatelessWidget {
  const SplashContent({
    Key? key,
    required this.text,
    required this.image
  }) : super(key: key);
  final String? text, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Spacer(),
        Text("MONAD", style: TextStyle(
          fontSize: getProptionalScreenWidth(36),
          color: kPrimaryColor,
          fontWeight: FontWeight.bold,

        ),),
        Text(
            text!,
        textAlign: TextAlign.center,),
        Spacer(),
        Image.asset(
          image!,
          height: getProptionalScreenHeight(265),
          width: getProptionalScreenWidth(235),),
      ],
    );
  }
}

