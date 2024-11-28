import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class Splash extends StatefulWidget{
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SvgPicture.asset('assets/pic/splash.svg'),
    );
  }
}