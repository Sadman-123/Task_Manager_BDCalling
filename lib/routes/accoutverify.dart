import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:taskmanager/controller/usercontrol.dart';
import '../style/style.dart';
class Accoutverify extends StatelessWidget{
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Let's Verify",style: Title_Text(mdw)),
                    Text("We have Sent a Code to xyz@gmail.com",style: TextStyle(fontSize: mdw*0.041),)
                  ],
                ),
              ),
              SizedBox(height: mdh*0.045,),
              Container(
               padding: EdgeInsets.only(
                 left: 14,
                 right: 14
               ),
                child:  Pinput(
                  length: 6,
                  keyboardType: TextInputType.number,
                  pinAnimationType: PinAnimationType.scale,
                  defaultPinTheme: pin_code_theme(mdw, mdh),
                  onChanged: (pin){
                    // user.get_otp(pin);
                  },
                ),
              ),
              SizedBox(height: mdh*0.030,),
              GestureDetector(
                onTap: (){
                  // user.login(mdw);
                },
                child: Center(
                  child: Container(
                      decoration: sButtonStyle(),
                      height: mdh*0.06,
                      width: mdw*0.8,
                      child: Obx(()=>Center(
                        child: user.isloginloading.value?Button_Loading():Text("VERIFY ACCOUNT",style: sButtonTextStyle(mdw),),
                      ),)
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}