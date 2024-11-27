import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/usercontrol.dart';
import '../style/style.dart';
class Login extends StatelessWidget{
  Usercontrol user=Get.find();
  @override
  Widget build(BuildContext context) {
    var mdw=MediaQuery.sizeOf(context).width;
    var mdh=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: mdh*0.065,),
              Container(
                child: Text("Let's go",style: Title_Text(mdw)),
              ),
              SizedBox(height: mdh*0.015,),
              Container(
                child: TextFormField(
                  cursorColor: Color(0xFF020203),
                  cursorWidth: 2.2,
                  controller: user.logemail,
                  decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.person),
                      filled: true,
                      fillColor: input_fillcolor,
                      border: Input_Box_Border()
                  ),
                ),
              ),
              SizedBox(height: mdh*0.015,),
              Container(
                child: TextFormField(
                  cursorColor: Color(0xFF020203),
                  cursorWidth: 2.2,
                  controller: user.logpass,
                  obscureText: true,
                  decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.password),
                      filled: true,
                      fillColor: input_fillcolor,
                      border: Input_Box_Border()
                  ),
                ),
              ),
              SizedBox(height: mdh*0.030,),
              GestureDetector(
                onTap: (){
                  user.login(mdw);
                },
                child: Center(
                  child: Container(
                    decoration: sButtonStyle(),
                    height: mdh*0.06,
                    width: mdw*0.8,
                    child: Obx(()=>Center(
                      child: user.isloginloading.value?Button_Loading():Text("LOGIN",style: sButtonTextStyle(mdw),),
                    ),)
                  ),
                ),
              ),
              SizedBox(height: mdh*0.035,),
              Container(
                child:Center(
                  child: InkWell(
                    onTap: (){Get.toNamed('/register');},
                    child: RichText(text: TextSpan(
                      style: TextStyle(color: Colors.black,fontSize: mdw*0.0413),
                      children: [
                        TextSpan(text: "Don't Have Account?"),
                        TextSpan(text: " "),
                        TextSpan(text: "Create One",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold))
                      ]
                    )),
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}