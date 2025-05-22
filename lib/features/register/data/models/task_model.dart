import '../../domain/entities/task.dart';

class TaskModel extends SCTask {
  TaskModel({
    required super.description,
    required super.duetime,
    required super.starttime,
    required super.title,
    required super.uid,
    required super.userId,
  });
}
