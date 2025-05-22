// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'tasks_cubit.dart';

abstract class TasksState extends Equatable {
  const TasksState();
}

class TasksInitial extends TasksState {
  const TasksInitial();
  @override
  List<Object?> get props => [];
}

class TasksLoading extends TasksState {
  const TasksLoading();
  @override
  List<Object?> get props => [];
}

class LoadedAllTask extends TasksState {
  final List<SCTask> tasks;
  const LoadedAllTask({
    this.tasks = const [],
  });

  @override
  List<Object?> get props => [tasks];
}

class CreateNewTaskState extends TasksState {
  final SCTask newTask;
  const CreateNewTaskState({required this.newTask});
  @override
  List<Object?> get props => [newTask];
}

class CreateNewTaskStateSuccess extends CreateNewTaskState {
  const CreateNewTaskStateSuccess({
    required super.newTask,
  });
  @override
  List<Object?> get props => [newTask];
}

class CreateNewTaskStateFailure extends CreateNewTaskState {
  const CreateNewTaskStateFailure({
    required super.newTask,
  });
  @override
  List<Object?> get props => [newTask];
}

class EditTaskState extends TasksState {
  final SCTask task;
  const EditTaskState({required this.task});
  @override
  List<Object?> get props => [task];
}

class EditTaskSuccessState extends EditTaskState {
  const EditTaskSuccessState({
    required super.task,
  });
  @override
  List<Object?> get props => [task];
}

class EditTaskStateFailure extends EditTaskState {
  const EditTaskStateFailure({
    required super.task,
  });
  @override
  List<Object?> get props => [task];
}

class DeleteTaskState extends TasksState {
  final SCTask task;
  const DeleteTaskState({required this.task});
  @override
  List<Object?> get props => [task];
}

class DeleteTaskSuccessState extends DeleteTaskState {
  const DeleteTaskSuccessState({
    required super.task,
  });
  @override
  List<Object?> get props => [task];
}

class DeleteTaskFailureState extends DeleteTaskState {
  const DeleteTaskFailureState({
    required super.task,
  });
  @override
  List<Object?> get props => [task];
}
