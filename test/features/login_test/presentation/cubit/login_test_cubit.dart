import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:s_c/features/login/domain/usecases/login_with_username_and_pw.dart';
import 'package:s_c/features/login/presentation/cubit/login_cubit.dart';

import 'login_test_cubit.mocks.dart';

@GenerateMocks([LoginWithUsernameAndPw])
void main() {
  late MockLoginWithUsernameAndPw mockLoginWithUsernameAndPw;

  late LoginCubit cubit;

  setUp(() {
    mockLoginWithUsernameAndPw = MockLoginWithUsernameAndPw();
    cubit = LoginCubit(
      loginWithUsernameAndPw: mockLoginWithUsernameAndPw,
    );
  });

  test('initialState should be Empty', () async {
    //assert
    expect(cubit.initial,
        equals(const LoginInitial(isHidePw: true, isRememberAccount: true)));
  });

  // group("Login with remember username and password => Success", () {
  //   const String username = "admin@self-control.com";
  //   const String password = "123456";
  //   const SCUser user = SCUser(username: username, password: password);

  //   test("loginWithUsernameAndPw usecase", () async* {
  //     //arrange
  //     when(mockLoginWithUsernameAndPw(user))
  //         .thenAnswer((realInvocation) async => const Right(user));
  //     cubit.loginWithUsernameAndPw(user);
  //     await untilCalled(mockLoginWithUsernameAndPw(user));

  //     //assert
  //     verify(mockLoginWithUsernameAndPw(user));
  //   });
  // });

  //todo: cubit test đang có vấn đề, không viết cubit test đc
}
