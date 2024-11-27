import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
void JossToast({required String msg,required double mdw,required bool isbad})
{
  Fluttertoast.showToast(
    msg: msg,
    fontSize: mdw*0.0418,
    toastLength: Toast.LENGTH_SHORT,
    backgroundColor: isbad?Color(0xFF6EC207):Color(0xFFFA4032),
    textColor: Color(0xFFF0F0F0)
  );
}