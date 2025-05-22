import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:s_c/features/user_profile/data/models/user_profile_model.dart';
import 'package:s_c/features/user_profile/domain/usecases/set_user_profile.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/usecases/get_user_profile.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  final GetUserProfile getUserProfile;
  final SetUserProfile setUserProfile;

  UserProfileCubit({
    required this.getUserProfile,
    required this.setUserProfile,
  }) : super(UserProfileInitial());

  MemoryImage? memoryImage;
  String base64Image = "";

  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  Future getImage({
    required void Function() onSelected,
  }) async {
    ImagePicker picker = ImagePicker();
    var image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      final img = File(image.path);

      List<int> imageBytes = img.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
      memoryImage = MemoryImage(const Base64Decoder().convert(base64Image));

      onSelected.call();
    }
  }

  void doGetUserProfile({required String userId}) async {
    final failureOrResult =
        await getUserProfile.call(GetUserProfileParams(userId: userId));
    failureOrResult?.fold((l) {
      emit(UserProfileHasnotExistState());
    }, (r) {
      base64Image = r.avatarUrl;
      memoryImage = MemoryImage(const Base64Decoder().convert(r.avatarUrl));

      nameController.text = r.name;
      addressController.text = r.address;
      phoneController.text = r.phone;
      emit(UserProfileGetDone(userProfile: r));
    });
  }

  void doSetUserProfile({required String userId}) async {
    final UserProfileModel user = UserProfileModel(
      name: nameController.text,
      address: addressController.text,
      phone: phoneController.text,
      gender: "",
      avatarUrl: base64Image,
    );
    if (!EasyLoading.isShow) {
      EasyLoading.show(maskType: EasyLoadingMaskType.black);
    }
    final failureOrResult = await setUserProfile
        .call(SetUserProfileParams(userId: userId, userProfile: user));
    failureOrResult?.fold((l) {
      EasyLoading.dismiss();
    }, (r) {
      EasyLoading.dismiss();
      emit(UserProfileSetDone(userProfile: r));
    });
  }
}
