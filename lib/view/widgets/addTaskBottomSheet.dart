import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import 'package:todo_project/model_view/task_cubit_class.dart';
import 'package:todo_project/core/enumTasks.dart';
import 'package:todo_project/model/models/task_model.dart';

class AddTaskBottom extends StatefulWidget {
  const AddTaskBottom({super.key});
  @override
  State<AddTaskBottom> createState() => _AddTaskBottomState();
}

class _AddTaskBottomState extends State<AddTaskBottom> {
  List<tasklistEnum> taskLevel = [
    tasklistEnum.High,
    tasklistEnum.Medium,
    tasklistEnum.Low
  ];
  TextEditingController controller = TextEditingController();

  tasklistEnum? value;

  String? datetime;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaskCubit, TaskState>(
      listener: (context, state) {
        if (state is AddNewTaskSuccess) {
          Navigator.pop(context); //to remove task Bottom sheet
          BlocProvider.of<TaskCubit>(context).getInProgressTaskList();
        }
      },
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: TextField(
                controller: controller,
                decoration: InputDecoration(
                    hintText: "Task Title",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: Color(0xff094E7F)),
                      //Color(0xffEB0201)
                    )),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: DropdownButtonFormField(
                  items: taskLevel
                      .map(
                        (level) => DropdownMenuItem(
                          value: level,
                          child: Text(
                            level.name,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                        ),
                      )
                      .toList(),
                  value: value, //initial value
                  onChanged: (level) {
                    setState(() {
                      value = level;
                    });
                  },
                  decoration: InputDecoration(
                      hintText: "Task Level",
                      hintStyle: const TextStyle(fontSize: 16),
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 13),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: Color(0xff094E7F)),
                      ))),
            ),
            TextButton(
                onPressed: () {
                  showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)))
                      .then((date) {
                    showTimePicker(
                            initialTime: TimeOfDay.now(), context: context)
                        .then((time) {
                      datetime = date
                          ?.add(
                            Duration(
                              hours: time?.hour ?? 0,
                              minutes: time?.minute ?? 0,
                            ),
                          )
                          .toString();
                      setState(() {});
                    });
                  }).catchError((e) {});
                },
                child: Text(
                  datetime != null
                      ? Jiffy.parse(datetime ?? "").yMMMMEEEEdjm
                      : "Select date",
                  style: const TextStyle(
                      color: Color(0xff094E7F),
                      fontSize: 16),
                )),
            const SizedBox(
              height: 16,
              width: double.infinity,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  BlocProvider.of<TaskCubit>(context).AddNewTask(
                      taskModel: TaskModel(
                    level: value?.name,
                    dateTime: datetime,
                    title: controller.text,
                  ));
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff094E7F),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    )),
                child: state is AddNewTaskLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : const Text(
                        "Add Task",
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: "inter",
                          fontSize: 16,
                        ),
                      ),
              ),
            ),
            const SizedBox(height: 32)
          ],
        );
      },
    );
  }
}
