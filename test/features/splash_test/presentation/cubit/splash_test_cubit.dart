import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:s_c/features/splash/domain/usecases/check_first_launch.dart';
import 'package:s_c/features/splash/domain/usecases/check_remembered_login.dart';
import 'package:s_c/features/splash/presentation/cubit/splash_cubit.dart';

import 'splash_test_cubit.mocks.dart';

@GenerateMocks([CheckFirstLaunch])
@GenerateMocks([CheckRememberedLogin])
void main() {
  late MockCheckFirstLaunch mockCheckFirstLaunch;
  late MockCheckRememberedLogin mockCheckRememberedLogin;
  late SplashCubit cubit;

  setUp(() {
    mockCheckFirstLaunch = MockCheckFirstLaunch();
    mockCheckRememberedLogin = MockCheckRememberedLogin();
    cubit = SplashCubit(
      checkFirstLaunch: mockCheckFirstLaunch,
      checkRememberedLogin: mockCheckRememberedLogin,
    );
  });

  test('initialState should be Empty', () async {
    expect(cubit.initialState, equals(SplashInitial()));
  });
}
