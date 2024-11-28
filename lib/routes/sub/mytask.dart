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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor:  Color(0xFFfefffe),
            pinned: true,
            actions: [
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: CircleAvatar(
                  backgroundColor: Colors.greenAccent,
                  radius: 33,
                  child: Text("${user.welcomename.value}",style: TextStyle(fontSize: mdw*0.057),),
                ),
              ),
            ],
            expandedHeight: mdh*0.41,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              background: Image.asset("assets/pic/bg.png",fit: BoxFit.cover,),
              title: Card(
                color: Color(0xFF378CE7),
                child: Container(child: Obx(()=>Text("You got ${user.total_tasks} Tasks",style: Card_style_total(mdw),)),padding: EdgeInsets.all(10),),
              ),
            ),
          ),
          Obx((){
            return SliverList(delegate: SliverChildBuilderDelegate(
              childCount: user.tasks.length,
              (context, index) {
                return Custom_Card(context,mdw, mdh, user.tasks[index],user);
              },
            ));
          })
        ],
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
Widget Custom_Card(BuildContext context, double mdw, double mdh, dynamic taskData, Usercontrol user) {
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


