// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s_c/app/presentation/cubit/app_cubit.dart';
import 'package:s_c/features/home/presentation/pages/home_page.dart';
import 'package:s_c/features/login/domain/entities/login_page_arg.dart';
import 'package:s_c/features/login/presentation/pages/login_page.dart';

class Screen extends StatelessWidget {
  final Widget Function(BuildContext context) builder;
  const Screen({
    Key? key,
    required this.builder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AppCubit, AppState>(
      listenWhen: (previous, current) {
        return previous.authState != current.authState;
      },
      listener: (context, state) {
        if (state.authState.isLoged == true) {
          Navigator.of(context)
              .pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
        } else {
          if (ModalRoute.of(context)?.settings.name != LoginPage.routeName) {
            Navigator.of(context).pushNamedAndRemoveUntil<LoginPageArg>(
                LoginPage.routeName,
                arguments: LoginPageArg(password: "", username: ""),
                (route) => false);
          }
        }
      },
      child: builder.call(context),
    );
  }
}
