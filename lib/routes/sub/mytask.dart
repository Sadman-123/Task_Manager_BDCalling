import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/routes/sub/userinfo.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../controller/usercontrol.dart';
import '../../style/style.dart';
class MyTasks extends StatelessWidget {
  final Usercontrol user = Get.find();
  @override
  Widget build(BuildContext context) {
    final mdw = MediaQuery.of(context).size.width;
    final mdh = MediaQuery.of(context).size.height;
    String convertToTimeAgo(String dateString) {
      try {
        DateTime parsedDate = DateTime.parse(dateString);
        return timeago.format(parsedDate);
      } catch (e) {
        return "Invalid date format";
      }
    }
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              // Welcome Header
              Container(
                padding: const EdgeInsets.all(3.4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Obx(()=>RichText(
                      text: TextSpan(
                        style: Rich_Text_1(mdw),
                        children: [
                          const TextSpan(text: "Welcome,"),
                          const TextSpan(text: " "),
                          TextSpan(
                            text: "${user.welcomename.value} 👋",
                            style: Rich_Text_2(),
                          ),
                        ],
                      ),
                    ),),
                    IconButton(
                      onPressed: () => user.Logout(mdw),
                      icon: const Icon(Icons.logout),
                    ),
                  ],
                ),
              ),

              // "My Tasks" Title
              Container(
                padding: const EdgeInsets.all(3.4),
                width: double.infinity,
                child: Text(
                  "My Tasks",
                  style: Home_Title_Txt(mdw),
                ),
              ),
              // Task List
              Expanded(
               child: Obx((){
                 return ListView.builder(
                   itemCount: user.tasks.length,
                   itemBuilder: (context, index) {
                     return Custom_Card(context,mdw, mdh, user.tasks[index],user);
                   },
                 );
               }),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskBottomSheet(context, mdw, mdh);
        },
        child: const Icon(Icons.add_task),
      ),
    );
  }
  void _showAddTaskBottomSheet(BuildContext context, double mdw, double mdh) {
    showBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: const Color(0xFFfefffe),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40),
              topRight: Radius.circular(40),
            ),
          ),
          height: mdh * 0.45,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  "Add Task",
                  style: Add_Task_Title(mdw),
                ),
                SizedBox(height: mdh * 0.025),
                TextFormField(
                  controller: user.tasktitle,
                  decoration: InputDecoration(
                    hintText: "Task Title",
                    prefixIcon: const Icon(Icons.title),
                    filled: true,
                    fillColor: input_fillcolor,
                    border: Input_Box_Border(),
                  ),
                ),
                SizedBox(height: mdh * 0.015),
                TextFormField(
                  controller: user.taskdes,
                  decoration: InputDecoration(
                    hintText: "Task Description",
                    filled: true,
                    fillColor: input_fillcolor,
                    border: Input_Box_Border(),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: mdh * 0.015),
                GestureDetector(
                  onTap: () {
                    user.addTask(mdw).then((_){
                      Navigator.pop(context);
                    });
                  },
                  child: Center(
                    child: Container(
                      decoration: sButtonStyle(),
                      height: mdh * 0.06,
                      width: mdw * 0.8,
                      child: Center(
                        child: Text(
                          "ADD TASK",
                          style: sButtonTextStyle(mdw),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
Widget Custom_Card(
    BuildContext context, double mdw, double mdh, dynamic taskData, Usercontrol user) {
  return Card(
    color: card_color,
    shadowColor: card_shadow_color,
    margin: const EdgeInsets.symmetric(vertical: 5),
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          // Task Info
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  taskData['title'] ?? 'No Title',
                  style: Card_style_1(mdw),
                ),
                Text(
                  taskData['description'] ?? 'No Description',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Card_style_2(mdw),
                ),
                Text(
                  convertToTimeAgo(taskData['createdAt']) ?? 'No date',
                  style: Card_style_3(mdw),
                ),
              ],
            ),
          ),
          // Action Buttons
          Expanded(
            flex: 1,
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    user.DeleteTask(mdw, taskData['_id'] ?? '');
                  },
                  icon: const Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}


