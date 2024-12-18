import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_project/model_view/task_cubit_class.dart';
import 'package:todo_project/view/widgets/addTaskBottomSheet.dart';
import 'package:todo_project/view/widgets/customwidget.dart';
import 'package:todo_project/view/widgets/edit_task_bottom%20Sheet.dart';


class TodayTasks extends StatefulWidget {
  const TodayTasks({super.key});

  //we convert to stateful to use initState
  @override
  State<TodayTasks> createState() => _TodayTasksState();
}

class _TodayTasksState extends State<TodayTasks> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TaskCubit>(context).getInProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 246, 244, 244),
        title: const Text("To Do List"),
        centerTitle: false,
        titleTextStyle: const TextStyle(
            color:Color(0xff094E7F),
            fontSize: 30,
            fontWeight: FontWeight.bold,
            fontFamily: "Inter"),
      ),
      body: BlocConsumer<TaskCubit, TaskState>(listener: (context, state) {
        if (state is MakeTaskDoneSuccess) {
          BlocProvider.of<TaskCubit>(context)
              .inProgressTasks
              .removeWhere((element) {
            return element.id == state.taskId;
          });
        }
        if (state is DeleteTaskSuccess) {
          BlocProvider.of<TaskCubit>(context)
              .inProgressTasks
              .removeWhere((element) {
            return element.id == state.removedTaskId;
          }
          );
        }
      }, builder: (context, state) {
        return BlocProvider.of<TaskCubit>(context).inProgressTasks.isNotEmpty
            ? ListView.separated(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 25),
                itemBuilder: (context, index) {
                  return TasksWidget(
                    taskmodel: BlocProvider.of<TaskCubit>(context)
                        .inProgressTasks[index],
                    editpressed: () {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Padding(
                              padding: EdgeInsets.only(
                                  left: 16,
                                  right: 16,
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: EditTaskBottom(
                                taskModel: BlocProvider.of<TaskCubit>(context)
                                    .inProgressTasks[index],
                              ),
                            );
                          });
                    },
                    removepressed: () {
                      BlocProvider.of<TaskCubit>(context).deleteTask(
                          removedTaskId: BlocProvider.of<TaskCubit>(context)
                                  .inProgressTasks[index]
                                  .id ??
                              0);
                    },
                    donePressed: () {
                      BlocProvider.of<TaskCubit>(context).makeTaskDone(
                          taskId: BlocProvider.of<TaskCubit>(context)
                                  .inProgressTasks[index]
                                  .id ??
                              0);
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const SizedBox(
                    height: 16,
                  );
                },
                itemCount:
                    BlocProvider.of<TaskCubit>(context).inProgressTasks.length)
            : Center(
                child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 43),
                child: Lottie.asset(
                  "assets/Animation - 1732643532986.json",
                ),
              ));
      }),
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          backgroundColor: const Color(0xff094E7F),
          //foregroundColor: Colors.grey,
          onPressed: () {
            showModalBottomSheet(
                context: context,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(20))),
                builder: (context) => Padding(
                    padding: EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: const AddTaskBottom()));
          },
          child: SvgPicture.asset(
            "assets/floating.svg",
          ),
        ),
      ),
    );
  }
}
