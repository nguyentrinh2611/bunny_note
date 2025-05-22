import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s_c/features/change_pw/presentation/pages/change_password_page.dart';
import 'package:s_c/features/user_profile/presentation/pages/user_profile_page.dart';
import '../../../../core/widgets_catalog/dialogs/hcm23_dialog.dart';
import '../../../user_profile/presentation/cubit/user_profile_cubit.dart';

import '../../../../app/presentation/cubit/app_cubit.dart';
import '../../../../core/enum/app_languages.dart';
import '../../../../core/localization/generated/l10n.dart';

import '../../../../core/widgets_catalog/btn/btn_default/btn_default.dart';
import '../../../../core/widgets_catalog/btn/switch/switch_button.dart';
import '../../../../core/widgets_catalog/themes/text_styles.dart';

final List<Map<String, String>> menu = [
  {
    "Thông tin User": "",
  },
  {
    "Đổi mật khẩu": "",
  }
];

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
  void logout() {
    context.read<AppCubit>().logout();
  }

  @override
  void initState() {
    context.read<UserProfileCubit>().doGetUserProfile(
        userId: context.read<AppCubit>().state.authState.user?.uid ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserProfileCubit, UserProfileState>(
        listener: (context, state) {
      if (state is UserProfileHasnotExistState) {
        showDialog(
          context: context,
          builder: (context) => HCM23Dialog(
            title: 'Error',
            content: "Bạn chưa cập nhật Profile",
            backgroundColor: Colors.red.withOpacity(0.4),
            titleTextStyle: const TextStyle(
                fontSize: 25, fontWeight: FontWeight.bold, color: Colors.white),
            contentTextStyle:
                const TextStyle(fontSize: 16, color: Colors.white),
            actions: [
              CleanDialogActionButtons(
                actionTitle: 'OK',
                onPressed: () {
                  Navigator.of(context).pushNamed(UserProfilePage.routeName);
                },
              ),
            ],
          ),
        );
      }
    }, builder: (context, state) {
      return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width * 0.75,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Column(
                  children: [
                    DrawerHeader(
                      decoration: const BoxDecoration(
                        color: Color(0xFFB7ABFD),
                      ),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    )
                  ],
                ),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.green,
                  child: CircleAvatar(
                    radius: 58,
                    backgroundImage: state is UserProfileGetDone
                        ? MemoryImage(const Base64Decoder()
                            .convert(state.userProfile.avatarUrl))
                        : null,
                  ),
                )
              ],
            ),
            Text(
              state is UserProfileGetDone ? state.userProfile.name : "",
              style: tStyle.display18().cTitle(),
            ),
            const SizedBox(
              height: 80,
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(ChangePwPage.routeName);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("Đổi mật khẩu"),
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(UserProfilePage.routeName);
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text("User profile"),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(S.of(context).appLanguage),
                  SCLanguageSwitchButton(
                    currentLocale: context.read<AppCubit>().state.appLanguage!,
                    localeList: appSupportedLanguages,
                    onChangedLanguage: (p0) {
                      context.read<AppCubit>().toggleLanguage(p0);
                    },
                  )
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: BtnDefault(
                onTap: logout,
                type: BtnDefaultType.secondary,
                title: "Đăng xuất",
              ),
            )
          ],
        ),
      );
    });
  }
}
