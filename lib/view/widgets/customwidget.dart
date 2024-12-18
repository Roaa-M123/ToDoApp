import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:todo_project/view/widgets/actionIconbuttonWidget.dart';
import 'package:todo_project/model/models/task_model.dart';

class TasksWidget extends StatelessWidget {
  final void Function() editpressed;
  final void Function() removepressed;
  final void Function()? donePressed;

  final TaskModel taskmodel;

  const TasksWidget(
      {super.key,
      required this.editpressed,
      required this.removepressed,
      required this.taskmodel,
      required this.donePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      alignment: Alignment.center,
      height: 110,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
                color: Color(0xffE5E5E5),
                blurRadius: 9.36,
                spreadRadius: 6,
                offset: Offset(0, 0) //offset.zero
                )
          ]),
      child: Row(children: [
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 0,
                ),
                child: Text(
                  taskmodel.title != null ? taskmodel.title ?? "" : "NoTitle",
                  style: TextStyle(
                      color: Color(0xff094E7F),
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: "Inter"),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 245, 237, 235),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  taskmodel.dateTime != null
                      ? Jiffy.parse(taskmodel.dateTime ?? "").yMMMMEEEEdjm
                      : "NoDate",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff094E7F),
                      fontSize: 9,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Inter"),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 245, 237, 235),
                    borderRadius: BorderRadius.circular(4)),
                child: Text(
                  taskmodel.level ?? "NoLevel",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Color(0xff094E7F),
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      fontFamily: "Inter"),
                ),
              )
            ],
          ),
        ),
        taskmodel.isDone == true
            ? Row(
                children: [
                  Icon(
                    Icons.task_alt,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  ActionIconButton(
                    iconPath: "assets/throw.svg",
                    onPressed: removepressed,
                  ),
                ],
              )
            : Column(children: [
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    ActionIconButton(
                      onPressed: editpressed,
                      iconPath: "assets/edit.svg",
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ActionIconButton(
                      iconPath: "assets/throw.svg",
                      onPressed: removepressed,
                    ),
                  ],
                ),
                SizedBox(
                  height: 45,
                  child: TextButton(
                      onPressed: donePressed,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                      ),
                      child: Text(
                        "Done",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Inter",
                            color: Color(0xff094E7F)),
                      )),
                )
              ]),
      ]),
    ); //
  }
}
