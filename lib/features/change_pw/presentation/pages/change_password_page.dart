// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:s_c/app/domain/entities/sc_user.dart';
import 'package:s_c/core/error/failures.dart';
import 'package:s_c/core/widgets_catalog/dialogs/hcm23_dialog.dart';
import 'package:s_c/features/change_pw/presentation/cubit/change_pw_cubit.dart';

import '../../../../app/presentation/cubit/app_cubit.dart';
import '../../../../app/presentation/widgets/screen.dart';
import '../../../../core/widgets_catalog/btn/btn_default/btn_default.dart';
import '../../../../core/widgets_catalog/inputs/input_clear/input_clear.dart';
import '../../../home/presentation/pages/home_page.dart';

class ChangePwPage extends StatefulWidget {
  static const String routeName = "ChangePwPage";

  const ChangePwPage({
    Key? key,
  }) : super(key: key);

  @override
  State<ChangePwPage> createState() => _ChangePassword();
}

class _ChangePassword extends State<ChangePwPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _currentPassWordController =
      TextEditingController();
  final TextEditingController _newPassWordController = TextEditingController();
  final TextEditingController _confirmNewPassWordController =
      TextEditingController();
  User? currentUser = FirebaseAuth.instance.currentUser;
  void changePassword(String newPassword) async {
    final SCUser? user = context.read<AppCubit>().state.authState.user;
    if (user == null) return;
    context
        .read<ChangePwCubit>()
        .doUpdatePassword(newPassword: newPassword, user: user);
  }

  @override
  void initState() {
    super.initState();
  }

  void _toggleCurrentPassword() {
    context.read<ChangePwCubit>().toggleHideCurrentPassword();
  }

  void _toggleNewPassword() {
    context.read<ChangePwCubit>().toggleHideNewPassword();
  }

  void _toggleConfirmNewPassword() {
    context.read<ChangePwCubit>().toggleHideConfirmNewPassword();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Screen(builder: (context) {
      return BlocListener<ChangePwCubit, ChangePwState>(
        listenWhen: (previous, current) {
          return previous != current ||
              ((previous is ChangePwFailed && current is ChangePwFailed) &&
                  previous.failure != current.failure);
        },
        listener: (context, state) {
          if (state is ChangePwFailed) {
            late final String errorMess;
            if (state.failure is NetworkFailure) {
              errorMess = "Lỗi kết nối, vui lòng thử lại sau";
            }
            if (state.failure is ServerFailure) {
              errorMess = "Đổi mật khẩu thất bại, vui lòng thử lại sau";
            }
            if (state.failure is CacheFailure) {
              errorMess =
                  "Đổi mật khẩu thành công nhưng không thể tự động đăng nhập, phiền bạn phải đăng nhập thủ công trong phiên sắp tới";
            }
            showDialog(
              context: context,
              builder: (context) => HCM23Dialog(
                title: 'Error',
                content: errorMess,
                backgroundColor: Colors.red.withOpacity(0.4),
                titleTextStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                contentTextStyle:
                    const TextStyle(fontSize: 16, color: Colors.white),
                actions: [
                  CleanDialogActionButtons(
                    actionTitle: 'OK',
                    onPressed: () {
                      if (state.failure is CacheFailure) {
                        Navigator.of(context)
                            .popUntil(ModalRoute.withName(HomePage.routeName));
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                ],
              ),
            );
          }
          if (state is ChangePwSuccess) {
            showDialog(
              context: context,
              builder: (context) => HCM23Dialog(
                title: 'Success',
                content: "Đổi mật khẩu thành công",
                backgroundColor: Colors.green.withOpacity(0.4),
                titleTextStyle: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                contentTextStyle:
                    const TextStyle(fontSize: 16, color: Colors.white),
                actions: [
                  CleanDialogActionButtons(
                    actionTitle: 'OK',
                    onPressed: () {
                      Navigator.of(context)
                          .popUntil(ModalRoute.withName(HomePage.routeName));
                      context.read<AppCubit>().login(
                            username: state.loggedUser.username,
                            password: state.loggedUser.password,
                            uid: state.loggedUser.uid ?? "",
                          );
                    },
                  ),
                ],
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              "Đổi mật khẩu",
            ),
            elevation: 0,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Center(
                  child: Form(
                key: _formKey,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 80),
                        child: Image.asset('assets/images/background.png'),
                      ),
                      BlocBuilder<ChangePwCubit, ChangePwState>(
                          builder: (context, state) {
                        return InputClear(
                          controller: _currentPassWordController,
                          onChanged: context.read<ChangePwCubit>().doTyping,
                          placeholderText: "Mật khẩu hiện tại",
                          clearButton: SvgPicture.asset(
                            "assets/icons/ui_kit/bold/close_square.svg",
                            fit: BoxFit.scaleDown,
                          ),
                          obscureText: state.isHideCurrentPw,
                          decoration: InputDecoration(
                            prefixIcon: SvgPicture.asset(
                              "assets/icons/ui_kit/normal/shield_done.svg",
                              color: const Color(0XFFA2AEBD),
                              fit: BoxFit.scaleDown,
                            ),
                            suffixIcon: InkWell(
                              onTap: _toggleCurrentPassword,
                              child: InkWell(
                                  onTap: _toggleCurrentPassword,
                                  child: SvgPicture.asset(
                                    (state.isHideCurrentPw)
                                        ? "assets/icons/ui_kit/bold/hide.svg"
                                        : "assets/icons/ui_kit/bold/show.svg",
                                    fit: BoxFit.scaleDown,
                                  )),
                            ),
                          ),
                        );
                      }),
                      BlocBuilder<ChangePwCubit, ChangePwState>(
                          builder: (context, state) {
                        return InputClear(
                          controller: _newPassWordController,
                          onChanged: context.read<ChangePwCubit>().doTyping,
                          placeholderText: "Mật khẩu mới",
                          clearButton: SvgPicture.asset(
                            "assets/icons/ui_kit/bold/close_square.svg",
                            fit: BoxFit.scaleDown,
                          ),
                          obscureText: state.isHideNewPw,
                          decoration: InputDecoration(
                            prefixIcon: SvgPicture.asset(
                              "assets/icons/ui_kit/normal/lock.svg",
                              color: const Color(0XFFA2AEBD),
                              fit: BoxFit.scaleDown,
                            ),
                            suffixIcon: InkWell(
                                onTap: _toggleNewPassword,
                                child: SvgPicture.asset(
                                  (state.isHideNewPw)
                                      ? "assets/icons/ui_kit/bold/hide.svg"
                                      : "assets/icons/ui_kit/bold/show.svg",
                                  fit: BoxFit.scaleDown,
                                )),
                          ),
                        );
                      }),
                      BlocBuilder<ChangePwCubit, ChangePwState>(
                          builder: (context, state) {
                        return InputClear(
                          controller: _confirmNewPassWordController,
                          onChanged: context.read<ChangePwCubit>().doTyping,
                          placeholderText: "Nhập lại mật khẩu",
                          clearButton: SvgPicture.asset(
                            "assets/icons/ui_kit/bold/close_square.svg",
                            fit: BoxFit.scaleDown,
                          ),
                          obscureText: state.isHideConfirmNewPw,
                          decoration: InputDecoration(
                            prefixIcon: SvgPicture.asset(
                              "assets/icons/ui_kit/normal/lock.svg",
                              color: const Color(0XFFA2AEBD),
                              fit: BoxFit.scaleDown,
                            ),
                            suffixIcon: InkWell(
                                onTap: _toggleConfirmNewPassword,
                                child: SvgPicture.asset(
                                  (state.isHideConfirmNewPw)
                                      ? "assets/icons/ui_kit/bold/hide.svg"
                                      : "assets/icons/ui_kit/bold/show.svg",
                                  fit: BoxFit.scaleDown,
                                )),
                          ),
                        );
                      }),
                      const SizedBox(height: 40),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: BtnDefault(
                              title: "Huỷ",
                              type: BtnDefaultType.secondary,
                              onTap: () {
                                EasyLoading.dismiss();
                                Navigator.of(context).popUntil(
                                  ModalRoute.withName(HomePage.routeName),
                                );
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 16,
                          ),
                          Expanded(
                            child: BtnDefault(
                              title: "Cập nhật",
                              onTap: () {
                                changePassword(_newPassWordController.text);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                    ]),
              )),
            ),
          ),
        ),
      );
    });
  }
}
