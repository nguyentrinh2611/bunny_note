import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_test_state.dart';

class AppTestCubit extends Cubit<AppTestState> {
  AppTestCubit() : super(AppTestInitial());
}
