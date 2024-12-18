import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_project/model_view/task_cubit_class.dart';
import 'package:todo_project/view/widgets/customwidget.dart';

class DoneTasks extends StatefulWidget {
  const DoneTasks({super.key});

  @override
  State<DoneTasks> createState() => _DoneTasksState();
}

class _DoneTasksState extends State<DoneTasks> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TaskCubit>(context).getDoneTasksList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor:const Color.fromARGB(255, 246, 244, 244),
          title: const Text("To Do List"),
          centerTitle: false,
          titleTextStyle: const TextStyle(
              color: Color(0xff094E7F),
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: "Inter"),
        ),
        body: BlocConsumer<TaskCubit, TaskState>(
          listener: (context, state) {
            if (state is InitDatabaseSuccess) {
              BlocProvider.of<TaskCubit>(context).getDoneTasksList();
            }
            if (state is DeleteTaskSuccess) {
              BlocProvider.of<TaskCubit>(context)
                  .doneTasks
                  .removeWhere((element) => element.id == state.removedTaskId);
            }
          },
          builder: (context, state) {
            return state is GetDoneTasksLoading
                ? const Center(child: CircularProgressIndicator())
                : BlocProvider.of<TaskCubit>(context).doneTasks.isNotEmpty
                ? ListView.separated(
              padding: const EdgeInsets.symmetric(
                  horizontal: 16, vertical: 25),
              itemBuilder: (context, index) {
                return TasksWidget(
                  taskmodel: BlocProvider.of<TaskCubit>(context)
                      .doneTasks[index],
                  editpressed: () {
                    //
                  },
                  removepressed: () {
                    //
                    BlocProvider.of<TaskCubit>(context).deleteTask(
                        removedTaskId: BlocProvider.of<TaskCubit>(
                            context)
                            .doneTasks[index]
                            .id ??
                            0);
                  },
                  donePressed: () {
                    //
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 16,
                );
              },
              itemCount: BlocProvider.of<TaskCubit>(context)
                  .doneTasks
                  .length,
            )
                : Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 43),
                  child: Lottie.asset(
                    "assets/Animation - 1732643532986.json",
                  ),
                ));
          },
        ));
  }
}
