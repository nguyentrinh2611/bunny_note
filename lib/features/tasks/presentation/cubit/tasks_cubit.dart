// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uuid/uuid.dart';

import 'package:s_c/features/register/domain/entities/task.dart';
import 'package:s_c/features/tasks/domain/usecases/add_new_task.dart';
import 'package:s_c/features/tasks/domain/usecases/delete_task.dart';
import 'package:s_c/features/tasks/domain/usecases/get_tasks.dart';
import 'package:s_c/features/tasks/domain/usecases/update_task.dart';

part 'tasks_state.dart';

class TasksCubit extends Cubit<TasksState> {
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  TasksCubit({
    required this.getTasks,
    required this.addNewTask,
    required this.updateTask,
    required this.deleteTask,
  }) : super(const TasksInitial());
  final GetTasks getTasks;
  final AddNewTask addNewTask;
  final UpdateTask updateTask;
  final DeleteTask deleteTask;
  List<SCTask> tasks = [];

  Future<void> doGetTasks({required String userUid}) async {
    emit(const TasksLoading());
    if (!EasyLoading.isShow) {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
    }
    final failureOrResult =
        await getTasks.call(GetTasksParram(userUid: userUid));
    failureOrResult?.fold((failure) {
      EasyLoading.dismiss();
      emit(
        const LoadedAllTask(),
      );
    }, (result) {
      EasyLoading.dismiss();
      tasks = result;
      emit(LoadedAllTask(tasks: tasks));
      if (!isClosed) emit(LoadedAllTask(tasks: result));
    });
  }

  Future<void> doInitCreateNewTask({required String userId}) async {
    final String taskUid = const Uuid().v4();
    emit(
      CreateNewTaskState(
        newTask: SCTask(
          uid: taskUid,
          userId: userId,
          starttime: DateTime.now(),
          duetime: DateTime.now().add(const Duration(days: 1)),
        ),
      ),
    );
  }

  void doChangeStartDate(String value) {
    final parsedTime = DateTime(
        int.tryParse(value.substring(6, 10)) ?? DateTime.now().year,
        int.tryParse(value.substring(3, 5)) ?? DateTime.now().month,
        int.tryParse(value.substring(0, 2)) ?? DateTime.now().day);
    final SCTask newTask =
        (state as CreateNewTaskState).newTask.copyWith(starttime: parsedTime);
    emit(CreateNewTaskState(newTask: newTask));
    return;
  }

  void doChangeDueDate(String value) {
    final parsedTime = DateTime(
        int.tryParse(value.substring(6, 10)) ?? DateTime.now().year,
        int.tryParse(value.substring(3, 5)) ?? DateTime.now().month,
        int.tryParse(value.substring(0, 2)) ?? DateTime.now().day);
    final SCTask newTask =
        (state as CreateNewTaskState).newTask.copyWith(duetime: parsedTime);
    emit(CreateNewTaskState(newTask: newTask));
    return;
  }

  Future<void> doAddNewTask() async {
    final SCTask newTask = (state as CreateNewTaskState).newTask;

    if (!EasyLoading.isShow) {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
    }
    final failureOrResult = await addNewTask.call(AddNewTaskParams(
      newTask: newTask,
    ));
    failureOrResult?.fold((failure) {
      EasyLoading.dismiss();
      emit(CreateNewTaskStateFailure(newTask: newTask));
    }, (result) {
      emit(CreateNewTaskStateSuccess(newTask: newTask));
      EasyLoading.dismiss();
    });
  }

  void doChangeTaskTitle(String title) {
    final SCTask newTask =
        (state as CreateNewTaskState).newTask.copyWith(title: title);
    emit(CreateNewTaskState(newTask: newTask));
  }

  void doChangeTaskDes(String description) {
    final SCTask newTask = (state as CreateNewTaskState)
        .newTask
        .copyWith(description: description);
    emit(CreateNewTaskState(newTask: newTask));
  }

  void navToTaskDetails(
      {required SCTask task, required List<SCTask> listTasks}) {
    tasks = listTasks;
    emit(EditTaskState(task: task));
  }

  void doChangeCurrentTaskTitle(String title) {
    final SCTask newTask = (state as EditTaskState).task.copyWith(title: title);
    emit(EditTaskState(task: newTask));
  }

  void doChangeCurrentTaskDes(String description) {
    final SCTask newTask =
        (state as EditTaskState).task.copyWith(description: description);
    emit(EditTaskState(task: newTask));
  }

  void doUpdateTask(SCTask currentTask) async {
    final int index =
        tasks.indexWhere((element) => element.uid == currentTask.uid);

    if (index < 0) return;
    tasks.replaceRange(index, index + 1, [currentTask]);
    emit(const TasksLoading());
    if (!EasyLoading.isShow) {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
    }
    final failureOrResult =
        await updateTask.call(UpdateTaskParram(tasks: tasks));
    failureOrResult?.fold((l) {
      EasyLoading.dismiss();
      emit(EditTaskStateFailure(task: currentTask));
    }, (r) {
      EasyLoading.dismiss();
      emit(EditTaskSuccessState(task: currentTask));
    });
  }

  void doDeleteTask(SCTask currentTask) async {
    final int index =
        tasks.indexWhere((element) => element.uid == currentTask.uid);

    if (index < 0) return;
    tasks.removeAt(index);
    emit(const TasksLoading());
    if (!EasyLoading.isShow) {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
    }
    final failureOrResult =
        await deleteTask.call(DeleteTaskParams(tasks: tasks));
    failureOrResult?.fold((l) {
      EasyLoading.dismiss();
      emit(DeleteTaskFailureState(task: currentTask));
    }, (r) {
      EasyLoading.dismiss();
      emit(DeleteTaskSuccessState(task: currentTask));
    });
  }
}
