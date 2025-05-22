// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:s_c/app/presentation/cubit/app_cubit.dart';
import 'package:s_c/app/presentation/widgets/screen.dart';
import 'package:s_c/core/widgets_catalog/dialogs/hcm23_dialog.dart';
import 'package:s_c/features/user_profile/presentation/cubit/user_profile_cubit.dart';
import '../../../../core/widgets_catalog/btn/btn_default/btn_default.dart';
import '../../../../core/widgets_catalog/inputs/input_clear/input_clear.dart';
import '../../../home/presentation/pages/home_page.dart';

class UserProfilePage extends StatefulWidget {
  static const String routeName = "UserProfilePage";

  const UserProfilePage({
    Key? key,
  }) : super(key: key);

  @override
  State<UserProfilePage> createState() => _UserInfo();
}

class _UserInfo extends State<UserProfilePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  late final _cubit = context.read<UserProfileCubit>();

  @override
  Widget build(BuildContext context) {
    return Screen(builder: (context) {
      return BlocListener<UserProfileCubit, UserProfileState>(
        listener: (context, state) {
          if (state is UserProfileSetDone) {
            showDialog(
              context: context,
              builder: (context) => HCM23Dialog(
                title: 'Thông báo',
                content: "Cập nhật profile thành công",
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
              "Thông tin người dùng",
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
                          padding: const EdgeInsets.symmetric(vertical: 60),
                          child: Container(
                            width: 160,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: Stack(
                              alignment: AlignmentDirectional.bottomCenter,
                              children: [
                                BlocBuilder<UserProfileCubit, UserProfileState>(
                                  builder: (context, state) {
                                    return CircleAvatar(
                                      radius: 80,
                                      backgroundColor: Colors.green,
                                      child: CircleAvatar(
                                        radius: 78,
                                        backgroundColor: Colors.grey,
                                        backgroundImage: _cubit.memoryImage,
                                      ),
                                    );
                                  },
                                ),
                                Container(
                                  color: Colors.grey,
                                  child: InkWell(
                                    onTap: () {
                                      _cubit.getImage(
                                        onSelected: () {
                                          setState(() {});
                                        },
                                      );
                                    },
                                    child: Ink(
                                      child: const Icon(
                                        Icons.camera_alt,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                      InputClear(
                        controller: _cubit.nameController,
                        placeholderText: "Họ tên",
                        clearButton: SvgPicture.asset(
                          "assets/icons/ui_kit/bold/close_square.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: SvgPicture.asset(
                            "assets/icons/ui_kit/normal/shield_done.svg",
                            color: const Color(0XFFA2AEBD),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      InputClear(
                        controller: _cubit.addressController,
                        // onChanged: context.read<ChangePwCubit>().doTyping,
                        placeholderText: "Địa chỉ",
                        clearButton: SvgPicture.asset(
                          "assets/icons/ui_kit/bold/close_square.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: SvgPicture.asset(
                            "assets/icons/ui_kit/normal/lock.svg",
                            color: const Color(0XFFA2AEBD),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      InputClear(
                        controller: _cubit.phoneController,
                        // onChanged: context.read<ChangePwCubit>().doTyping,
                        placeholderText: "Số điện thoại",
                        clearButton: SvgPicture.asset(
                          "assets/icons/ui_kit/bold/close_square.svg",
                          fit: BoxFit.scaleDown,
                        ),
                        decoration: InputDecoration(
                          prefixIcon: SvgPicture.asset(
                            "assets/icons/ui_kit/normal/phone.svg",
                            color: const Color(0XFFA2AEBD),
                            fit: BoxFit.scaleDown,
                          ),
                        ),
                      ),
                      const SizedBox(height: 100),
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
                                _cubit.doSetUserProfile(
                                    userId: context
                                            .read<AppCubit>()
                                            .state
                                            .authState
                                            .user
                                            ?.uid ??
                                        "");
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
