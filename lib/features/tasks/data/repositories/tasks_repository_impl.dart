import 'package:dartz/dartz.dart';
import '../../domain/usecases/delete_task.dart';
import '../../domain/usecases/update_task.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../../register/domain/entities/task.dart';
import '../datasources/tasks_remote_datasource.dart';
import '../../domain/repositories/tasks_repository.dart';

import '../../../../core/error/exceptions.dart';

class TasksRepositoryImpl implements TasksRepository {
  final NetworkInfo networkInfo;
  final TasksRemoteDataSource remoteDataSource;
  TasksRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
  });
  @override
  Future<Either<Failure, List<SCTask>>> getTasks(
      {required String userUid}) async {
    if (await networkInfo.isConnected) {
      try {
        final List<SCTask> result =
            await remoteDataSource.getTasks(userUid: userUid);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(errorCode: e.errorCode));
      } catch (err) {
        return const Left(ServerFailure(errorCode: null));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, String>> addNewTask({required SCTask newTask}) async {
    if (await networkInfo.isConnected) {
      try {
        final String result =
            await remoteDataSource.addNewTask(newTask: newTask);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(errorCode: e.errorCode));
      } catch (err) {
        return const Left(ServerFailure(errorCode: null));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, String>> updateTask(
      {required UpdateTaskParram parram}) async {
    if (await networkInfo.isConnected) {
      try {
        final String result =
            await remoteDataSource.updateTask(task: parram.tasks);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(errorCode: e.errorCode));
      } catch (err) {
        return const Left(ServerFailure(errorCode: null));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }

  @override
  Future<Either<Failure, String>> deletetask({
    required DeleteTaskParams parram,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final String result =
            await remoteDataSource.deleteTask(task: parram.tasks);
        return Right(result);
      } on ServerException catch (e) {
        return Left(ServerFailure(errorCode: e.errorCode));
      } catch (err) {
        return const Left(ServerFailure(errorCode: null));
      }
    } else {
      return const Left(NetworkFailure());
    }
  }
}
