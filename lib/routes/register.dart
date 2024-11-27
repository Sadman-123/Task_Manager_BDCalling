import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/usercontrol.dart';
import '../style/style.dart';
class Register extends StatelessWidget{
  Usercontrol user=Get.find();
  @override
  Widget build(BuildContext context) {
    var mdw=MediaQuery.sizeOf(context).width;
    var mdh=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: mdh*0.065,),
                Container(
                  child: Text("Join Now",style: Title_Text(mdw),),
                ),
                SizedBox(height: mdh*0.015,),
                Container(
                  child: TextFormField(
                    cursorColor: Color(0xFF020203),
                    cursorWidth: 2.2,
                    controller: user.regfirstname,
                    decoration: InputDecoration(
                        hintText: "Enter First Name",
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
                    controller: user.reglastname,
                    decoration: InputDecoration(
                        hintText: "Enter Last Name",
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
                    controller: user.regemail,
                    decoration: InputDecoration(
                        hintText: "Enter Email Address",
                        prefixIcon: Icon(Icons.mail),
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
                    controller: user.regaddress,
                    decoration: InputDecoration(
                        hintText: "Enter Address",
                        prefixIcon: Icon(Icons.map),
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
                    controller: user.regpass,
                    decoration: InputDecoration(
                      hintText: "Enter Password",
                      prefixIcon: Icon(Icons.password),
                      filled: true,
                      fillColor: input_fillcolor,
                      border: Input_Box_Border()
                    ),
                  ),
                ),
                SizedBox(height: mdh*0.030,),
                GestureDetector(
                  onTap: (){user.register(mdw);},
                  child: Center(
                    child: Container(
                      decoration: sButtonStyle(),
                      height: mdh*0.06,
                      width: mdw*0.8,
                        child: Obx(()=>Center(
                          child: user.isregisterloading.value?Button_Loading():Text("REGISTRATION",style: TextStyle(color: Color(0xFFfefffe),fontSize: mdw*0.05,fontWeight: FontWeight.bold,letterSpacing: 0.5),),
                        ),)
                    ),
                  ),
                ),
                SizedBox(height: mdh*0.035,),
                Container(
                    child:Center(
                      child: InkWell(
                        onTap: (){Get.toNamed('/login');},
                        child: RichText(text: TextSpan(
                            style: TextStyle(color: Colors.black,fontSize: mdw*0.0413),
                            children: [
                              TextSpan(text: "Already Have Account?"),
                              TextSpan(text: " "),
                              TextSpan(text: "Lets Go",style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold))
                            ]
                        )),
                      ),
                    )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}