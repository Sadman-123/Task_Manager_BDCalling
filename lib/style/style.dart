import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
Color input_fillcolor=Color(0xFFF0F0F0);
ThemeData GlobalTheme()
{
  return ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF020203),
      foregroundColor: Color(0xFFF0F0F0)
    ),
      scaffoldBackgroundColor: Color(0xFFfefffe),
  );
}
TextStyle Title_Text(double mdw)
{
  return TextStyle(fontSize: mdw*0.089,color: Color(0xFF020203),fontWeight: FontWeight.w800);
}
OutlineInputBorder Input_Box_Border()
{
  return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(24)
  );
}
BoxDecoration sButtonStyle()
{
  return BoxDecoration(
      color: Color(0xFF020203),
      borderRadius: BorderRadius.circular(14)
  );
}
TextStyle sButtonTextStyle(double mdw)
{
  return TextStyle(color: Color(0xFFfefffe),fontSize: mdw*0.05,fontWeight: FontWeight.bold,letterSpacing: 0.5);
}
CircularProgressIndicator Button_Loading()
{
  return CircularProgressIndicator(color: Color(0xFFfefffe),strokeWidth: 2,strokeAlign: -4,);
}
TextStyle Rich_Text_1(double mdw)
{
  return TextStyle(
      fontSize: mdw*0.05,
      color: Color(0xFF020203)
  );
}
TextStyle Rich_Text_2()
{
  return TextStyle(fontWeight: FontWeight.bold);
}
TextStyle Home_Title_Txt(double mdw)
{
  return TextStyle(fontSize: mdw*0.077,fontWeight: FontWeight.bold);
}
Color card_color= Color(0xFFfefffe);
Color card_shadow_color=Color(0xFFfefffe);
TextStyle Card_style_1(double mdw)
{
  return TextStyle(fontSize: mdw*0.065,overflow: TextOverflow.ellipsis,fontWeight: FontWeight.w500);
}
TextStyle Card_style_2(double mdw)
{
  return TextStyle(fontSize: mdw*0.039);
}
TextStyle Card_style_3(double mdw)
{
  return TextStyle(color: Color(0xFF747475));
}
TextStyle Add_Task_Title(double mdw)
{
  return TextStyle(fontSize: mdw*0.075,fontWeight: FontWeight.bold);
}
PinTheme pin_code_theme(double mdw,double mdh)
{
  return PinTheme(
    width: mdw*1,
    height: mdh*0.07,
    textStyle: TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      color: Color(0xFFb7efc5),
      border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
      borderRadius: BorderRadius.circular(20),
    ),
  );
}