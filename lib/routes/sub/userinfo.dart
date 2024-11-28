import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../controller/usercontrol.dart';
import '../../style/style.dart';
String convertToTimeAgo(String dateString) {
  try {
    DateTime parsedDate = DateTime.parse(dateString);
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
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(onPressed: (){user.Logout(mdw);}, icon: Icon(Icons.logout)),
          )
        ],
      ),
    body: SafeArea(
      child: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("User Info",style: Home_Title_Txt(mdw),),
              SizedBox(height: mdh*0.04,),
              Container(
                child: TextFormField(
                  readOnly: true,
                  controller: TextEditingController(
                    text: user.userpic.text.isEmpty
                        ? "Select an Image"
                        : user.userpic.text,
                  ),
                  decoration: InputDecoration(
                    hintText: "Select an Image",
                    prefixIcon: Icon(Icons.image),
                    suffixIcon: IconButton(
                      onPressed: () {
                        user.pickImage();
                      },
                      icon: Icon(Icons.camera_alt),
                    ),
                    filled: true,
                    fillColor: input_fillcolor,
                    border: Input_Box_Border(),
                  ),
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: mdh*0.015,),
              Container(
                child: TextFormField(
                  controller: user.userfirst,
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
                  cursorColor: Color(0xFF020203),
                  cursorWidth: 2.2,
                  decoration: InputDecoration(
                      hintText: "Email",
                      prefixIcon: Icon(Icons.mail),
                      suffixIcon: Icon(Icons.check_circle,color: Colors.blueAccent,),
                      filled: true,
                      fillColor: input_fillcolor,
                      border: Input_Box_Border()
                  ),
                  readOnly: true,
                ),
              ),
              SizedBox(height: mdh*0.015,),
              Container(
                child: TextFormField(
                  controller: user.userpass,
                  cursorColor: Color(0xFF020203),
                  cursorWidth: 2.2,
                  decoration: InputDecoration(
                      hintText: "Password",
                      prefixIcon: Icon(Icons.password),
                      filled: true,
                      fillColor: input_fillcolor,
                      border: Input_Box_Border()
                  ),
                ),
              ),
              SizedBox(height: mdh*0.015,),
              Container(
                child: TextFormField(
                  controller: user.useraddress,
                  cursorColor: Color(0xFF020203),
                  cursorWidth: 2.2,
                  decoration: InputDecoration(
                      hintText: "Address",
                      prefixIcon: Icon(Icons.map),
                      filled: true,
                      fillColor: input_fillcolor,
                      border: Input_Box_Border()
                  ),
                ),
              ),
              SizedBox(height: mdh*0.024,),
              Container(
                  alignment: Alignment.center,
                  child: Obx(()=>Text("${user.getProfileCreatedDateText()}",style: TextStyle(fontSize: mdw*0.050,color: Colors.grey),))
              ),
              SizedBox(height: mdh*0.025,),
              GestureDetector(
                onTap: () {
                  user.updateProfile(mdw);
                },
                child: Center(
                  child: Container(
                    decoration: sButtonStyle(),
                    height: mdh * 0.06,
                    width: mdw * 0.8,
                    child: Obx((){
                      return Center(
                        child: user.isupdateprofile.value?Button_Loading():Text(
                          "UPDATE PROFILE",
                          style: sButtonTextStyle(mdw),
                        ),
                      );
                    })
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}