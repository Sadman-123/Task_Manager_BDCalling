import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/josstoast.dart';
class Usercontrol extends GetxController{
  TextEditingController logemail=TextEditingController();
  TextEditingController logpass=TextEditingController();
  TextEditingController regfirstname=TextEditingController();
  TextEditingController reglastname=TextEditingController();
  TextEditingController regphone=TextEditingController();
  TextEditingController regemail=TextEditingController();
  TextEditingController regpass=TextEditingController();
  TextEditingController tasktitle=TextEditingController();
  TextEditingController taskdes=TextEditingController();
  TextEditingController userfirst=TextEditingController();
  TextEditingController userlast=TextEditingController();
  TextEditingController useremail=TextEditingController();
  TextEditingController userphone=TextEditingController();
  RxString userdate="".obs;
  RxString welcomename="".obs;
  RxBool isloginloading=false.obs;
  RxBool isregisterloading=false.obs;
  RxList<dynamic> tasks=[].obs;
  String BaseUrl="http://139.59.65.225:8052/";
  @override
  void onInit() {
    super.onInit();
    getUserInfo();
    getTasks();
  }
  Future<void>login(double mdw)
  async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isloginloading.value=true;
    if(logemail.text.isEmpty || logpass.text.isEmpty)
      {
        JossToast(msg: "Fill Every Blanks", mdw: mdw, isbad: false);
        isloginloading.value=false;
        clear_textfields();
        return;
      }
    else{
      try{
        var dat={
          "email":logemail.text.trim(),
          "password":logpass.text.trim()
        };
        var url=Uri.parse("${BaseUrl}user/login");
        var res=await http.post(url,body: jsonEncode(dat),headers: {'Content-Type':'application/json'});
        if(res.statusCode==200)
          {
            JossToast(msg: "Logging Successful", mdw: mdw, isbad: true);
            Get.toNamed('/home');
            var loltoken=jsonDecode(res.body)['token'].toString();
            await prefs.setString('token',loltoken );
            print('Token saved');
            getTasks();
            getUserInfo();
            isloginloading.value=false;
            clear_textfields();
          }
        else if(res.statusCode==404)
        {
          JossToast(msg: "Something Went Wrong", mdw: mdw, isbad: false);
          isloginloading.value=false;
          clear_textfields();
        }
        else{
          JossToast(msg: "Something Went Wrong", mdw: mdw, isbad: false);
          isloginloading.value=false;
          clear_textfields();
        }
      }
      catch(e)
    {
      JossToast(msg: "Something Went Wrong", mdw: mdw, isbad: false);
      isloginloading.value=false;
      clear_textfields();
    }
    }
  }
  Future<void>register(double mdw)
  async{
    isregisterloading.value=true;
    if(regfirstname.text.isEmpty || reglastname.text.isEmpty || regemail.text.isEmpty || regphone.text.isEmpty || regpass.text.isEmpty)
      {
        JossToast(msg: "Fill Every Blanks", mdw: mdw, isbad: false);
        isregisterloading.value=false;
        clear_textfields();
        return;
      }
    else{
      try
      {
        var dat={
          "email":regemail.text.trim(),
          "firstName":regfirstname.text.trim(),
          "lastName":reglastname.text.trim(),
          "mobile":regphone.text.trim(),
          "password":regpass.text.trim()
        };
        var url=Uri.parse("${BaseUrl}user/register");
        var res=await http.post(url,headers: {'Content-Type':'application/json'},body: jsonEncode(dat));
        if(res.statusCode==200)
        {
          JossToast(msg: "Registration Successfully", mdw: mdw, isbad: true);
          isregisterloading.value=false;
          clear_textfields();
        }
        else if(res.statusCode==400)
        {
          JossToast(msg: "This email is Already Registered.Please Try Again with other email", mdw: mdw, isbad: false);
          isregisterloading.value=false;
          clear_textfields();
        }
        else if(res.statusCode==404)
        {
          JossToast(msg: "Something Went Wrong", mdw: mdw, isbad: false);
          isregisterloading.value=false;
          clear_textfields();
        }
        else if(res.statusCode==500)
        {
          JossToast(msg: "Registration Failed", mdw: mdw, isbad: false);
          isregisterloading.value=false;
          clear_textfields();
        }
      }
      catch(e)
      {
        JossToast(msg: "Something Went Wrong", mdw: mdw, isbad: false);
        isregisterloading.value=false;
        clear_textfields();
      }
    }
  }
  Future<void>getUserInfo()async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tok = prefs.getString('token');
    var url=Uri.parse("${BaseUrl}user/my-profile");
    var res=await http.get(url,headers: {
      'Content-Type':'application/json',
      'token':'${tok}'
    });
    if(res.statusCode==200)
      {
        var data=jsonDecode(res.body);
        userfirst.text=data['data']['firstName'];
        welcomename.value=data['data']['firstName']+" "+data['data']['lastName'];
        userlast.text=data['data']['lastName'];
        useremail.text=data['data']['email'];
        userphone.text=data['data']['mobile'];
        userdate.value=data['data']['createdDate'];
      }
  }
  Future<void>getTasks()async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tok = prefs.getString('token');
    var url=Uri.parse("${BaseUrl}task/get-all-task");
    var res=await http.get(url,headers: {
      'Content-Type':'application/json',
      'token':'${tok}'
    });
    if(res.statusCode==200)
      {
        var x=jsonDecode(res.body);
        tasks.assignAll(x['data']);
        print(x);
      }
  }
  Future<void> addTask(double mdw) async {
    if (tasktitle.text.isEmpty || taskdes.text.isEmpty) {
      JossToast(msg: "Fill Every Blanks", mdw: mdw, isbad: false);
      return;
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tok = prefs.getString('token');

    var url = Uri.parse("${BaseUrl}task/create-task");
    var data = {
      "title": tasktitle.text.trim(),
      "description": taskdes.text.trim(),
      "status":"new"
    };

    try {
      var res = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'token': tok!,
        },
        body: jsonEncode(data),
      );
      if (res.statusCode == 200) {
        JossToast(msg: "Task Added Successfully", mdw: mdw, isbad: true);
        getTasks(); // Refresh tasks
      } else {
        JossToast(msg: "Failed to Add Task", mdw: mdw, isbad: false);
      }
    } catch (e) {
      JossToast(msg: "Something Went Wrong", mdw: mdw, isbad: false);
    }
    clear_textfields();
  }
  Future<void>DeleteTask(double mdw,var idx)async
  {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tok = prefs.getString('token');
    var url=Uri.parse("${BaseUrl}task/delete-task/${idx}");
    var res=await http.delete(url,headers: {
      'Content-Type':'application/json',
      'token':'${tok}'
    });
    if(res.statusCode==200)
      {
        JossToast(msg: "Deleted Successfully", mdw: mdw, isbad: true);
        getTasks();
      }
  }
  Future<void> Logout(double mdw)
  async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    tasks.clear();
    Get.toNamed('/login');
    JossToast(msg: "Logged Out Successfully", mdw: mdw, isbad: true);
  }
  void clear_textfields()
  {
    logemail.clear();
    logpass.clear();
    regemail.clear();
    regpass.clear();
    regfirstname.clear();
    reglastname.clear();
    regphone.clear();
    tasktitle.clear();
    taskdes.clear();
  }
  @override
  void dispose() {
    super.dispose();
    logemail.dispose();
    logpass.dispose();
    regemail.dispose();
    regpass.dispose();
    regfirstname.dispose();
    reglastname.dispose();
    regphone.dispose();
    tasktitle.dispose();
    taskdes.dispose();
  }
}