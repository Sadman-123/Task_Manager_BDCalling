import 'package:flutter/material.dart';
import 'package:taskmanager/routes/sub/mytask.dart';
import 'package:taskmanager/routes/sub/userinfo.dart';
class Home extends StatefulWidget{
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  int ind=0;
  @override
  Widget build(BuildContext context) {
    var mdh=MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: IndexedStack(
        index: ind,
        children: [
          MyTasks(),
          Userinfo()
        ],
      ),
     bottomNavigationBar: NavigationBar(
       height:mdh*0.088,
       backgroundColor: Color(0xFFfefffe),
       onDestinationSelected: (value) {
         setState(() {
           ind=value;
         });
       },
       selectedIndex: ind,
       destinations: [
         NavigationDestination(icon: Icon(Icons.home), label: "Home"),
         NavigationDestination(icon: Icon(Icons.account_circle), label: "Profile"),
       ],
     ),
    );
  }
}
