import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class sizeConfig{
  static MediaQueryData? _mediaQueryData;
  static double? screenWidth;
  static double? screenHeight;
  static double? defaultSize;
  static Orientation? orientation;


  void init(BuildContext context){
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData!.size.width;
    screenHeight = _mediaQueryData!.size.height;
    orientation = _mediaQueryData!.orientation;

    defaultSize = orientation == Orientation.landscape
        ? screenHeight! * 0.024
        : screenWidth! * 0.024;
  }
}

double getProptionalScreenHeight(double inputHeight){
  double? screenHeight = sizeConfig.screenHeight;
  return (inputHeight/812.0) * screenHeight!;

}

double getProptionalScreenWidth(double inputHeight){
  double? screenWidth = sizeConfig.screenWidth;
  return (inputHeight/375.0) *screenWidth!;

}