// ignore_for_file: depend_on_referenced_packages, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:s_c/app/presentation/cubit/app_cubit.dart';
import 'package:s_c/app/presentation/widgets/screen.dart';
import 'package:s_c/core/widgets_catalog/btn/btn_default/btn_default.dart';
import 'package:s_c/core/widgets_catalog/inputs/input_clear/input_clear.dart';
import 'package:s_c/core/widgets_catalog/inputs/input_normal/input_normal_layout_mixin.dart';
import 'package:s_c/core/widgets_catalog/themes/colors.dart';
import 'package:s_c/core/widgets_catalog/themes/text_styles.dart';

import '../cubit/register_cubit.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/RegisterPage';
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameCtr = TextEditingController();
  final TextEditingController pwCtr = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void navigateToForgotPwPage() {}

  void toggleHidePw() {
    context.read<RegisterCubit>().toggleHidePassword();
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.blue;
    }
    return Colors.red;
  }

  @override
  Widget build(BuildContext context) {
    return Screen(builder: (context) {
      return BlocListener<RegisterCubit, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            context.read<AppCubit>().login(
                  username: state.loggedUser.username,
                  password: state.loggedUser.password,
                  isRememmber: true,
                  uid: state.loggedUser.uid ?? "",
                );
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: AppBar(
            title: const Text("Đăng ký"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Image.asset("assets/images/image_login.png"),
                  ),
                  Text(
                    "Xin chào Người dùng!",
                    style: tStyle.paragraph18().w500().copyWith(
                          color: Hcm23Colors.colorTextTitle,
                        ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    "Vui lòng điền thông tin tài khoản để đăng ký!",
                    style: tStyle
                        .paragraph14()
                        .w400()
                        .copyWith(color: Hcm23Colors.colorTextPhude),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      return InputClear(
                        controller: usernameCtr,
                        onChanged: context.read<RegisterCubit>().doTyping,
                        placeholderText: "Tài khoản",
                        clearButton: SvgPicture.asset(
                          "assets/icons/ui_kit/bold/close_square.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: SvgPicture.asset(
                            "assets/icons/ui_kit/normal/user.svg",
                            color: const Color(0XFFA2AEBD),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                        feedBackType: (state is RegisterFailed)
                            ? FeedbackType.error
                            : FeedbackType.none,
                        feedbackMessage:
                            (state is RegisterFailed) ? state.errorCode : null,
                      );
                    },
                  ),
                  BlocBuilder<RegisterCubit, RegisterState>(
                    builder: (context, state) {
                      return InputClear(
                        controller: pwCtr,
                        onChanged: context.read<RegisterCubit>().doTyping,
                        placeholderText: "Mật khẩu",
                        obscureText: state.isHidePw,
                        decoration: InputDecoration(
                          prefixIcon: SvgPicture.asset(
                            "assets/icons/ui_kit/bold/lock.svg",
                            fit: BoxFit.scaleDown,
                          ),
                          suffixIcon: InkWell(
                              onTap: toggleHidePw,
                              child: SvgPicture.asset(
                                (state.isHidePw)
                                    ? "assets/icons/ui_kit/bold/hide.svg"
                                    : "assets/icons/ui_kit/bold/show.svg",
                                fit: BoxFit.scaleDown,
                              )),
                        ),
                        clearButton: SvgPicture.asset(
                          "assets/icons/ui_kit/bold/close_square.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        feedBackType: (state is RegisterFailed)
                            ? FeedbackType.error
                            : FeedbackType.none,
                        feedbackMessage:
                            (state is RegisterFailed) ? state.errorCode : null,
                      );
                    },
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  BtnDefault(
                    title: "Đăng ký",
                    onTap: doRegister,
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "Hoặc",
                    style: tStyle
                        .paragraph14()
                        .w400()
                        .copyWith(color: Hcm23Colors.colorTextPhude),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  BtnDefault(
                    type: BtnDefaultType.secondary,
                    title: "Đăng nhập",
                    onTap: navigateToLogin,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }

  void doRegister() {
    context.read<RegisterCubit>().doCreateUserWithEmailAndPassword(
        username: usernameCtr.text, password: pwCtr.text);
  }

  void navigateToLogin() {}
}
