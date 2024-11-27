import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../controller/usercontrol.dart';
import '../../style/style.dart';
String convertToTimeAgo(String dateString) {
  try {
    DateFormat dateFormat = DateFormat("MM/dd/yyyy, h:mm:ss a");
    DateTime parsedDate = dateFormat.parse(dateString);
    return timeago.format(parsedDate);
  } catch (e) {
    return "Invalid date format";
  }
}
class Userinfo extends StatelessWidget
{
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
            SizedBox(height: mdh*0.05,),
            Text("User Info",style: Home_Title_Txt(mdw),),
            SizedBox(height: mdh*0.04,),
            Container(
              child: TextFormField(
                controller: user.userfirst,
                readOnly: true,
                cursorColor: Color(0xFF020203),
                cursorWidth: 2.2,
                decoration: InputDecoration(
                    hintText: "First Name",
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
                controller: user.userlast,
                readOnly: true,
                cursorColor: Color(0xFF020203),
                cursorWidth: 2.2,
                decoration: InputDecoration(
                    hintText: "Last Name",
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
                controller: user.useremail,
                readOnly: true,
                cursorColor: Color(0xFF020203),
                cursorWidth: 2.2,
                decoration: InputDecoration(
                    hintText: "Email",
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
                controller: user.userphone,
                readOnly: true,
                cursorColor: Color(0xFF020203),
                cursorWidth: 2.2,
                decoration: InputDecoration(
                    hintText: "Phone",
                    prefixIcon: Icon(Icons.phone),
                    filled: true,
                    fillColor: input_fillcolor,
                    border: Input_Box_Border()
                ),
              ),
            ),
            SizedBox(height: mdh*0.044,),
            Container(
                alignment: Alignment.center,//user.userdate.value
                child: Obx(()=>Text("Created ${convertToTimeAgo(user.userdate.value)}",style: TextStyle(fontSize: mdw*0.050,color: Colors.grey),))
            )
          ],
        ),
      ),
    ),
    );
  }
}