// ignore_for_file: use_build_context_synchronously

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app/presentation/cubit/app_cubit.dart';
import '../../../../core/widgets_catalog/dialogs/hcm23_dialog.dart';
import '../../../../injection_container.dart';
import '../cubit/tasks_cubit.dart';
import '../pages/task_details_page.dart';
import 'task_card.dart';

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit(
          getTasks: sl(), addNewTask: sl(), updateTask: sl(), deleteTask: sl())
        ..doGetTasks(
            userUid: context.read<AppCubit>().state.authState.user?.uid ?? ""),
      child: BlocConsumer<TasksCubit, TasksState>(
        listener: (context, state) {
          if (state is DeleteTaskSuccessState) {
            showDialog(
              context: context,
              builder: (_) => HCM23Dialog(
                title: 'Thông báo',
                content: "Xoá bản ghi thành công",
                backgroundColor: Colors.green.withOpacity(0.4),
                titleTextStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                contentTextStyle:
                    const TextStyle(fontSize: 16, color: Colors.white),
                actions: [
                  CleanDialogActionButtons(
                    actionTitle: 'OK',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
            context.read<TasksCubit>().doGetTasks(
                userUid:
                    context.read<AppCubit>().state.authState.user?.uid ?? "");
          } else if (state is DeleteTaskFailureState) {
            showDialog(
              context: context,
              builder: (context) => HCM23Dialog(
                title: 'Error',
                content: "Có lỗi xảy ra, vui lòng thử lại sau",
                backgroundColor: Colors.red.withOpacity(0.4),
                titleTextStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                contentTextStyle:
                    const TextStyle(fontSize: 16, color: Colors.white),
                actions: [
                  CleanDialogActionButtons(
                    actionTitle: 'OK',
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is! LoadedAllTask) {
            return Container();
          }

          return RefreshIndicator(
            key: context.read<TasksCubit>().refreshIndicatorKey,
            color: Colors.white,
            backgroundColor: Colors.blue,
            strokeWidth: 4.0,
            onRefresh: () async {
              context.read<TasksCubit>().doGetTasks(
                  userUid:
                      context.read<AppCubit>().state.authState.user?.uid ?? "");
            },
            child: Container(
                padding: const EdgeInsets.all(16),
                width: double.infinity,
                height: double.infinity,
                child: state.tasks.isNotEmpty
                    ? ListView.separated(
                        padding: const EdgeInsets.only(bottom: 20),
                        itemBuilder: (context, index) {
                          final color = Color(
                                  (math.Random().nextDouble() * 0xFFFFFF)
                                      .toInt())
                              .withOpacity(0.1);

                          return TaskCard(
                            key: UniqueKey(),
                            task: state.tasks[index],
                            color: color,
                            viewTask: () async {
                              await Navigator.of(context)
                                  .pushNamed(TaskDetailsPage.routeName,
                                      arguments: TaskDetailsArg(
                                        userId: state.tasks[index].userId ?? "",
                                        task: state.tasks[index],
                                        listTasks: state.tasks,
                                      ));

                              context.read<TasksCubit>().doGetTasks(
                                  userUid: state.tasks[index].userId ?? "");
                            },
                            deleteTask: () {
                              context.read<TasksCubit>().doDeleteTask(
                                    state.tasks[index],
                                  );
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            height: 0.5,
                            width: double.infinity,
                            color: Colors.black.withOpacity(0.5),
                          );
                        },
                        itemCount: state.tasks.length,
                      )
                    : Container()),
          );
        },
      ),
    );
  }
}
