

import 'package:flutter/material.dart';
import 'package:monad/splashScreen/body.dart';

import '../style/size_config.dart';

class splashScreen extends StatelessWidget {

  const splashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    sizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Body(),
      ),
    );
  }
}
