// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:s_c/features/login/data/datasources/login_remote_data_source.dart';
import 'package:s_c/features/splash/data/models/sc_user_model.dart';

import 'login_remote_data_source_test.mocks.dart';

@GenerateMocks([
  FirebaseAuth,
  UserCredential
], customMocks: [
  MockSpec<FirebaseAuth>(
      as: #MockFirebaseAuthForTest, onMissingStub: OnMissingStub.returnDefault),
  MockSpec<UserCredential>(
      as: #MockUserCredentialForTest,
      onMissingStub: OnMissingStub.returnDefault),
])
void main() {
  late LoginRemoteDataSourceImpl remoteDataSource;
  late MockFirebaseAuth mockFirebaseAuth;
  late MockUserCredential mockUserCredential;
  const String username = "admin@self-control.com";
  const String password = "123456";

  SCUserModel userModel = const SCUserModel(
      password: password, username: username, uid: "test UID");

  setUp(() {
    mockFirebaseAuth = MockFirebaseAuth();
    mockUserCredential = MockUserCredential();
    remoteDataSource = LoginRemoteDataSourceImpl(fir: mockFirebaseAuth);
  });

  // test("should return SCUserModel with uid when login success ", () async {
  //   when(mockFirebaseAuth.signInWithEmailAndPassword(
  //           email: username, password: password))
  //       .thenAnswer((realInvocation) => Future.value(mockUserCredential));
  //   when(remoteDataSource.loginWithUsernameAndPw(
  //           username: username, password: password))
  //       .thenAnswer((realInvocation) async => Future.value(userModel));

  //   // act
  //   final SCUserModel result = await remoteDataSource.loginWithUsernameAndPw(
  //       username: username, password: password);
  //   // assert
  //   expect(result, equals(userModel));
  // });
}
