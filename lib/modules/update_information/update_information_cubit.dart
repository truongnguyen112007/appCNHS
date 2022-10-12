import 'package:base_bloc/data/model/user_model.dart';
import 'package:base_bloc/modules/tab_home/tab_home_page.dart';
import 'package:base_bloc/modules/update_information/update_information_state.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:base_bloc/utils/toast_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../config/constant.dart';
import '../../data/eventbus/switch_tab_event.dart';
import '../../data/repository/user_repository.dart';
import '../../utils/storage_utils.dart';

class UpdateInformationCubit extends Cubit<UpdateInformationState> {
  final String phoneNumber;
  final repository = BaseRepository();

  UpdateInformationCubit(this.phoneNumber) : super(const UpdateInformationState(''));

  void updateUser(String firstName, String lastName, int userId) async {
    var response = await repository.updateProfile(firstName, lastName, userId);
    if (response.error == null && response.data != null) {
      var userData = UserData.fromJson(response.data['data']);
      var userModel = await StorageUtils.getUser();
      if (userModel != null) {
        StorageUtils.saveUser(UserModel(
            data: userModel.data!
                .copyOf(userToken: userModel.data!.token, userData: userData)));
        await StorageUtils.getUser();
        Utils.fireEvent(SwitchTabEvent(BottomNavigationConstant.TAB_ADD));
      } else {
        toast(response.error.toString());
      }
    }
  }



  void oncClickButton(String name, int userId) async {
    if (!isValid(name)) return;
    updateUser('', name, userId);
  }

  bool isValid(String name) {
    bool isUpdate = false;
    if (name.isEmpty) {
      isUpdate = false;
      emit(const UpdateInformationState('Nhập tên người dùng'));
    } else {
      isUpdate = true;
      emit(const UpdateInformationState(''));
    }
    return isUpdate;
  }
}
