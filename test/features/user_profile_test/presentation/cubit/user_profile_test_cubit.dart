import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_profile_test_state.dart';

class UserProfileTestCubit extends Cubit<UserProfileTestState> {
  UserProfileTestCubit() : super(UserProfileTestInitial());
}
