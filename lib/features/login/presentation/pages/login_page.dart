// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:s_c/app/presentation/cubit/app_cubit.dart';
import 'package:s_c/app/presentation/widgets/screen.dart';
import 'package:s_c/core/widgets_catalog/inputs/input_clear/input_clear.dart';
import 'package:s_c/core/widgets_catalog/inputs/input_normal/input_normal_layout_mixin.dart';
import 'package:s_c/core/widgets_catalog/themes/colors.dart';
import 'package:s_c/core/widgets_catalog/themes/text_styles.dart';
import 'package:s_c/features/login/presentation/cubit/login_cubit.dart';
import 'package:s_c/features/register/presentation/pages/register_page.dart';

import '../../../../core/widgets_catalog/btn/btn_default/btn_default.dart';
import '../../domain/entities/login_page_arg.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = "/LoginPage";
  final LoginPageArg arg;
  const LoginPage({
    Key? key,
    required this.arg,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameCtr = TextEditingController();
  final TextEditingController pwCtr = TextEditingController();
  @override
  void initState() {
    if (widget.arg.username.isNotEmpty && widget.arg.password.isNotEmpty) {
      usernameCtr.text = widget.arg.username;
      pwCtr.text = widget.arg.password;
      loginWithUsernameAndPw();
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loginWithUsernameAndPw() {
    context.read<LoginCubit>().doLoginWithUsernameAndPw(
          username: usernameCtr.text,
          password: pwCtr.text,
        );
  }

  void navigateToRegisterPage() async {
    Navigator.of(context).pushNamed(RegisterPage.routeName);
  }

  void navigateToForgotPwPage() {}

  void toggleHidePw() {
    context.read<LoginCubit>().toggleHidePassword();
  }

  void toggleRememberAccount(bool? value) {
    context.read<LoginCubit>().toggleRememberAccount();
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
      return BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            context.read<AppCubit>().login(
                  username: state.loggedUser.username,
                  password: state.loggedUser.password,
                  isRememmber: state.isRememberAccount,
                  uid: state.loggedUser.uid ?? "",
                );
          }
          if (state is LoginFailed) {
            context.read<AppCubit>().logout();
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Image.asset("assets/images/image_login.png"),
                  Text(
                    "Xin chào",
                    //todo: Tan them theme
                    style: tStyle.paragraph18().w500().copyWith(
                          color: Hcm23Colors.colorTextTitle,
                        ),
                  ),
                  Text(
                    "Vui lòng đăng nhập để sử dụng ứng dụng",
                    //todo: Tan them theme
                    style: tStyle
                        .paragraph14()
                        .w400()
                        .copyWith(color: Hcm23Colors.colorTextPhude),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return InputClear(
                        controller: usernameCtr,
                        onChanged: context.read<LoginCubit>().doTyping,
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
                        feedBackType: (state is LoginFailed)
                            ? FeedbackType.error
                            : FeedbackType.none,
                        feedbackMessage:
                            (state is LoginFailed) ? state.errorCode : null,
                      );
                    },
                  ),
                  BlocBuilder<LoginCubit, LoginState>(
                    builder: (context, state) {
                      return InputClear(
                        controller: pwCtr,
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
                        feedBackType: (state is LoginFailed)
                            ? FeedbackType.error
                            : FeedbackType.none,
                        feedbackMessage:
                            (state is LoginFailed) ? state.errorCode : null,
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: navigateToForgotPwPage,
                          child: Text(
                            "Quên mật khẩu?",
                            style: tStyle
                                .display14()
                                .w500()
                                .copyWith(color: Hcm23Colors.color2),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          BlocBuilder<LoginCubit, LoginState>(
                            buildWhen: (previous, current) {
                              return previous.isRememberAccount !=
                                  current.isRememberAccount;
                            },
                            builder: (context, state) {
                              return Checkbox(
                                checkColor: Colors.white,
                                fillColor:
                                    MaterialStateProperty.resolveWith(getColor),
                                value: state.isRememberAccount,
                                onChanged: toggleRememberAccount,
                              );
                            },
                          ),
                          Text(
                            "Ghi nhớ tài khoản.",
                            style: tStyle
                                .display14()
                                .w500()
                                .copyWith(color: Hcm23Colors.color2),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BtnDefault(
                    onTap: loginWithUsernameAndPw,
                    title: "Đăng nhập",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                      text: TextSpan(
                    text: "Chưa có tài khoản? ",
                    style: tStyle
                        .paragraph14()
                        .w400()
                        .copyWith(color: Hcm23Colors.colorTextPhude),
                    children: [
                      TextSpan(
                          text: "Đăng ký",
                          style: tStyle
                              .display14()
                              .w500()
                              .copyWith(color: Hcm23Colors.color2),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              navigateToRegisterPage();
                            }),
                    ],
                  )),
                  const SizedBox(
                    height: 32,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {},
                        onTapCancel: () {},
                        child: Ink(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            color: Hcm23Colors.color3.withOpacity(0.1),
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/fingerprint.svg",
                            fit: BoxFit.scaleDown,
                            color: Hcm23Colors.color3,
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      //face id
                      GestureDetector(
                        onTap: () {},
                        onTapCancel: () {},
                        child: Ink(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                            color: Hcm23Colors.color3.withOpacity(0.1),
                          ),
                          child: SvgPicture.asset(
                            "assets/icons/face_id.svg",
                            fit: BoxFit.scaleDown,
                            color: Hcm23Colors.color3,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
