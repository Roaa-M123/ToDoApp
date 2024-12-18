import 'package:flutter/material.dart';
import 'package:todo_project/view/screens/DoneTaskScreen.dart';

import 'package:todo_project/view/screens/TodayTasksScreen.dart';

class AppLayoutScreen extends StatefulWidget {
  const AppLayoutScreen({super.key});
  @override
  State<AppLayoutScreen> createState() => _AppLayoutScreenState();
}

List<Widget> screens = [const TodayTasks(), const DoneTasks()];
int currentIndex = 0;

class _AppLayoutScreenState extends State<AppLayoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Color.fromARGB(255, 246, 244, 244),
            selectedItemColor: const Color(0xff094E7F),
            unselectedItemColor: Colors.grey,
            onTap: (index) {
              currentIndex = index;
              setState(() {});
            },
            currentIndex: currentIndex,
            items: [
              const BottomNavigationBarItem(
                  icon: Icon(Icons.today), label: "Inprogress Tasks"),
              const BottomNavigationBarItem(
                  icon: Icon(Icons.task_alt), label: "Done Tasks")
            ]));
  }
}
