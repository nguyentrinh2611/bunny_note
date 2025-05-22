// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s_c/features/login/domain/entities/login_page_arg.dart';

import '../../../../app/presentation/cubit/app_cubit.dart';
import '../../../../app/presentation/widgets/screen.dart';
import '../../../login/presentation/pages/login_page.dart';
import '../../../onboarding/pages/onboarding_page.dart';
import '../cubit/splash_cubit.dart';

class SplashPage extends StatefulWidget {
  static const String routeName = "/";
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<SplashCubit>().checkIsFirstLaunch();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(
      builder: (context) {
        return BlocListener<SplashCubit, SplashState>(
          listener: (context, state) {
            if (state is SplashFirstLaunch) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  OnboardingPage.routeName, (route) => false);
            }
            if (state is SplashUnremembered) {
              context.read<AppCubit>().logout();
            }
            if (state is SplashRemembered) {
              Navigator.of(context).pushNamedAndRemoveUntil<LoginPageArg>(
                LoginPage.routeName,
                arguments: LoginPageArg(
                    username: state.username, password: state.password),
                (route) => false,
              );
            }
          },
          child: const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}
