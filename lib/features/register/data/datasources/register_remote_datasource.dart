import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:uuid/uuid.dart';

import '../../../../app/domain/entities/sc_user.dart';
import '../../../../core/enum/app_constants.dart';
import '../../../../core/error/exceptions.dart';
import '../models/task_model.dart';

abstract class RegisterRemoteDataSource {
  Future<SCUser> createUserWithEmailAndPassword({
    required String username,
    required String password,
  });
  Future<String> createUserTasksCategory({
    required String uid,
  });
}
// ignore_for_file: public_member_api_docs, sort_constructors_first

class RegisterRemoteDataSourceImpl extends RegisterRemoteDataSource {
  final Dio dio;
  final FirebaseAuth fir;
  final FirebaseApp firApp;
  RegisterRemoteDataSourceImpl({
    required this.dio,
    required this.fir,
    required this.firApp,
  });
  @override
  Future<SCUser> createUserWithEmailAndPassword({
    required String username,
    required String password,
  }) async {
    try {
      final UserCredential result = await fir.createUserWithEmailAndPassword(
        email: username,
        password: password,
      );

      final SCUser registedUser = SCUser(
        username: username,
        password: password,
        uid: result.user?.uid ?? "",
      );
      return registedUser;
    } on FirebaseAuthException catch (e) {
      throw AuthException(errorCode: e.code);
    }
  }

  @override
  Future<String> createUserTasksCategory({
    required String uid,
  }) async {
    try {
      final String dbUrl = firApp.options.databaseURL ?? "";
      final String taskUid = const Uuid().v4();
      final TaskModel defaultTask = TaskModel(
        uid: taskUid,
        userId: uid,
        title: 'Chào mừng đến với Self-Control',
        description: 'Chào mừng đến với Self-Control',
        starttime: DateTime.now(),
        duetime: DateTime.now(),
      );
      final patchRes = await dio.patch("$dbUrl/$TASKS_CATEGORY.json", data: {
        uid: [defaultTask.toMap()]
      });
      return patchRes.statusCode.toString();
    } on Exception {
      throw ServerException();
    }
  }
}
