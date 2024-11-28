import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:timeago/timeago.dart' as timeago;
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/josstoast.dart';

class Usercontrol extends GetxController {
  TextEditingController logemail = TextEditingController();
  TextEditingController logpass = TextEditingController();
  TextEditingController regfirstname = TextEditingController();
  TextEditingController reglastname = TextEditingController();
  TextEditingController regaddress = TextEditingController();
  TextEditingController regemail = TextEditingController();
  TextEditingController regpass = TextEditingController();
  TextEditingController tasktitle = TextEditingController();
  TextEditingController taskdes = TextEditingController();
  TextEditingController userpic = TextEditingController();
  TextEditingController userfirst = TextEditingController();
  TextEditingController userlast = TextEditingController();
  TextEditingController useremail = TextEditingController();
  TextEditingController userpass = TextEditingController();
  TextEditingController useraddress = TextEditingController();
  RxString userdate = "".obs;
  RxString usermod = "".obs;
  RxString welcomename = "".obs;
  RxBool isloginloading = false.obs;
  RxBool isregisterloading = false.obs;
  RxBool isupdateprofile=false.obs;
  RxBool isProfileModified = false.obs;
  RxString selectedImagePath = "".obs;
  RxString recovery_otp="".obs;
  RxString total_tasks="".obs;
  RxList<dynamic> tasks = [].obs;
  void get_otp(pin){
    recovery_otp.value=pin;
  }
  String getProfileCreatedDateText() {
    if (userdate.value.isEmpty) {
      return "";
    }
    DateTime parsedDate = DateTime.parse(userdate.value);
    String formattedDate = timeago.format(parsedDate);
    DateTime parsedDate2 = DateTime.parse(usermod.value);
    String formattedDate2 = timeago.format(parsedDate2);

    return isProfileModified.value ? "Updated $formattedDate2" : "Created $formattedDate";
  }
  String BaseUrl = "http://139.59.65.225:8052/";

  @override
  void onInit() {
    super.onInit();
    getUserInfo();
    getTasks();
  }

  Future<void> pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      selectedImagePath.value = pickedFile.path;
    } else {
      JossToast(msg: "No image selected", mdw: 0, isbad: false);
    }
  }
  Future<void> login(double mdw) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isloginloading.value = true;
    if (logemail.text.isEmpty || logpass.text.isEmpty) {
      JossToast(msg: "Fill Every Blanks", mdw: mdw, isbad: false);
      isloginloading.value = false;
      clear_textfields();
      return;
    } else {
      try {
        var dat = {
          "email": logemail.text.trim(),
          "password": logpass.text.trim()
        };
        var url = Uri.parse("${BaseUrl}user/login");
        var res = await http.post(url,
            body: jsonEncode(dat), headers: {'Content-Type': 'application/json'});
        if (res.statusCode == 200) {
          JossToast(msg: "Logging Successful", mdw: mdw, isbad: true);
          Get.toNamed('/home');
          var loltoken = jsonDecode(res.body)['data']['token'].toString();
          await prefs.setString('token', loltoken);
          print('Token saved');
          getTasks();
          getUserInfo();
          isloginloading.value = false;
          clear_textfields();
        } else {
          JossToast(msg: "Something Went Wrong", mdw: mdw, isbad: false);
          isloginloading.value = false;
          clear_textfields();
        }
      } catch (e) {
        JossToast(msg: "Something Went Wrong", mdw: mdw, isbad: false);
        isloginloading.value = false;
        clear_textfields();
      }
    }
  }
  Future<void> register(double mdw) async {
    isregisterloading.value = true;
    if (regfirstname.text.isEmpty || reglastname.text.isEmpty || regemail.text.isEmpty || regaddress.text.isEmpty || regpass.text.isEmpty) {
      JossToast(msg: "Fill Every Blanks", mdw: mdw, isbad: false);
      isregisterloading.value = false;
      return;
    }
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse("${BaseUrl}user/register"),
      );
      request.headers.addAll({
        'Content-Type': 'multipart/form-data',
      });
      request.fields['email'] = regemail.text.trim();
      request.fields['firstName'] = regfirstname.text.trim();
      request.fields['lastName'] = reglastname.text.trim();
      request.fields['address'] = regaddress.text.trim();
      request.fields['password'] = regpass.text.trim();
      if (selectedImagePath.value.isNotEmpty) {
        var file = await http.MultipartFile.fromPath(
            'file',
            selectedImagePath.value,
            contentType: MediaType('image', 'jpeg')
        );
        request.files.add(file);
      }
      var res = await request.send();
      if (res.statusCode == 200) {
        JossToast(msg: "Registration Successfully", mdw: mdw, isbad: true);
        Get.toNamed('/verify',arguments: {'email':regemail.text});
        isregisterloading.value = false;
        clear_textfields();
      } else if (res.statusCode == 400) {
        JossToast(msg: "This email is Already Registered. Please Try Again with another email", mdw: mdw, isbad: false);
        isregisterloading.value = false;
        clear_textfields();
      } else {
        JossToast(msg: "Something Went Wrong", mdw: mdw, isbad: false);
        isregisterloading.value = false;
        clear_textfields();
      }
    } catch (e) {
      JossToast(msg: "Something Went Wrong", mdw: mdw, isbad: false);
      isregisterloading.value = false;
      clear_textfields();
    }
  }
  Future<void> updateProfile(double mdw) async {
    isupdateprofile.value = true;

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('token');

      if (token == null || token.isEmpty)  {
        JossToast(msg: "Token not found. Please login again.", mdw: mdw, isbad: false);
        isupdateprofile.value = false;
        return;
      }

      var request = http.MultipartRequest(
        'PATCH',
        Uri.parse("${BaseUrl}user/update-profile"),
      );
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      });

      // Add fields to the request
      request.fields['email'] = useremail.text.trim();
      request.fields['firstName'] = userfirst.text.trim();
      request.fields['lastName'] = userlast.text.trim();
      request.fields['address'] = useraddress.text.trim();
      request.fields['password'] = userpass.text.trim();

      // Add image file if available
      if (selectedImagePath.value.isNotEmpty) {
        var file = await http.MultipartFile.fromPath(
          'file',
          selectedImagePath.value,
          contentType: MediaType('image', 'jpeg'),
        );
        request.files.add(file);
      }

      var res = await request.send();

      if (res.statusCode == 200) {
        JossToast(msg: "Profile Updated Successfully", mdw: mdw, isbad: true);
        isProfileModified.value = false;
        getUserInfo();
      } else {
        print("Update profile failed: ${await res.stream.bytesToString()}");
        JossToast(msg: "Something Went Wrong", mdw: mdw, isbad: false);
        isProfileModified.value = false;

      }
    } catch (e) {
      print("Update profile error: $e");
      JossToast(msg: "Something Went Wrong", mdw: mdw, isbad: false);
      isProfileModified.value = false;
    } finally {
      isupdateprofile.value = false;
    }
  }
  Future<void> getUserInfo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tok = prefs.getString('token');
    var url = Uri.parse("${BaseUrl}user/my-profile");
    var res = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tok}'
    });
    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      if (data['data'].containsKey('updatedAt')) {
        isProfileModified.value = true;
      }
      userpic.text=data['data']['image'];
      userfirst.text = data['data']['firstName'];
      welcomename.value = data['data']['firstName'][0] + "" + data['data']['lastName'][0];
      userlast.text = data['data']['lastName'];
      useremail.text = data['data']['email'];
      userpass.text=data['data']['password'];
      useraddress.text = data['data']['address'];
      userdate.value = data['data']['createdAt'];
      usermod.value=data['data']['updatedAt'];
    }
  }
  Future<void> getTasks() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tok = prefs.getString('token');
    var url = Uri.parse("${BaseUrl}task/get-all-task");
    var res = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tok!}'
    });
    if (res.statusCode == 200) {
      var x = jsonDecode(res.body);
      tasks.assignAll(x['data']['myTasks']);
      total_tasks.value=x['data']['count'].toString();
      print(tasks);
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
    };
    try {
      var res = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': "Bearer ${tok!}",
        },
        body: jsonEncode(data),
      );
      if (res.statusCode == 200) {
        JossToast(msg: "Task Added Successfully", mdw: mdw, isbad: true);
        getTasks();
        getUserInfo();
      } else {
        JossToast(msg: "Failed to Add Task", mdw: mdw, isbad: false);
      }
    } catch (e) {
      JossToast(msg: "Something Went Wrong", mdw: mdw, isbad: false);
    }
    clear_textfields();
  }
  Future<void> DeleteTask(double mdw, var idx) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? tok = prefs.getString('token');
    var url = Uri.parse("${BaseUrl}task/delete-task/${idx}");
    var res = await http.delete(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${tok}'
    });
    if (res.statusCode == 200) {
      JossToast(msg: "Deleted Successfully", mdw: mdw, isbad: true);
      getTasks();
    }
  }
  Future<void>check_otp(double mdw,String txt)async{
    try{
      var dat={
        'email':txt,
        'code':recovery_otp.value
      };
      var url = Uri.parse("${BaseUrl}user/activate-user");
      var res=await http.post(url,headers: {'Content-Type':'application/json'},body: jsonEncode(dat));
      if(res.statusCode==200)
      {
        JossToast(msg: "Account Verified Successfully", mdw: mdw, isbad: true);
        Get.toNamed('/login');
      }
      else{
        JossToast(msg: "Upps! Account not verified", mdw: mdw, isbad: false);
      }
    }
    catch(e){
      JossToast(msg: "Something Went Wrong", mdw: mdw, isbad: false);
    }
  }
  Future<void> Logout(double mdw) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    tasks.clear();
    welcomename.value = "";
    isProfileModified.value = false;
    Get.toNamed('/login');
  }
  void clear_textfields() {
    logemail.clear();
    logpass.clear();
    regemail.clear();
    regpass.clear();
    regfirstname.clear();
    reglastname.clear();
    regaddress.clear();
    tasktitle.clear();
    taskdes.clear();
    userfirst.clear();
    userlast.clear();
    useremail.clear();
    useraddress.clear();
    selectedImagePath.value="";
    recovery_otp.value="";
    total_tasks.value="";
  }
}