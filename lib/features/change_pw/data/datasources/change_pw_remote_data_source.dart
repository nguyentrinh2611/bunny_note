// ignore_for_file: public_member_api_docs, sort_constructors_first, unused_local_variable
import 'package:firebase_auth/firebase_auth.dart';
import 'package:s_c/core/error/exceptions.dart';
import 'package:s_c/core/utils/logger.dart';

abstract class ChangePwRemoteDataSource {
  Future<String> changePw({required String newPassword});
}

class ChangePwRemoteDataSourceImpl implements ChangePwRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  ChangePwRemoteDataSourceImpl({
    required this.firebaseAuth,
  });
  @override
  Future<String> changePw({required String newPassword}) async {
    final User? user = firebaseAuth.currentUser;
    if (user == null) {
      throw ServerException();
    } else {
      try {
        final result = await user.updatePassword(newPassword);
        return newPassword;
      } catch (e) {
        AppLogger.instance.e(e);
        throw (ServerException());
      }
    }
  }
}
