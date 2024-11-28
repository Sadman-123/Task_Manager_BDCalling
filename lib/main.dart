import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taskmanager/routes/accoutverify.dart';
import 'package:taskmanager/routes/home.dart';
import 'package:taskmanager/routes/login.dart';
import 'package:taskmanager/routes/register.dart';
import 'package:taskmanager/style/style.dart';
import 'controller/usercontrol.dart';
void main()async
{
  Get.put(Usercontrol());
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");
  runApp(Main(hastoken: token!=null,));
}
class Main extends StatelessWidget{
  final bool hastoken;
  Main({super.key, required this.hastoken});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: GlobalTheme(),
      initialRoute: hastoken?'/home':'/login',
      getPages: [
        GetPage(name: '/register', page: () => Register(),transition: Transition.cupertino),
        GetPage(name: '/home', page: () => Home(),transition: Transition.cupertino),
        GetPage(name: '/login', page: () => Login(),transition: Transition.cupertino),
        GetPage(name: '/verify', page: () => Accoutverify(),transition: Transition.cupertino),
      ],
    );
  }
}