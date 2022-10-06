import 'package:base_bloc/modules/login/login_state.dart';
import 'package:base_bloc/router/router.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/app_utils.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState(''));

  void openOtp() {}

  void onClickContinue(String phone, BuildContext context) async {
    if (checkValid(phone, context)) {
      RouterUtils.pushAdd(
          context: context,
          route: AddRouters.otp,
          argument: Utils.standardizePhoneNumber(phone));
    }
  }

  bool checkValid(String phone, BuildContext context) {
    bool isValid = false;
    if (phone.isEmpty) {
      isValid = false;
      emit(LoginState('Vui long nhap sdt'));
    } else if (!Utils.validateMobile(phone)) {
      emit(LoginState('Login falseSdt ko hop le'));
      isValid = false;
    } else {
      isValid = true;
      emit(LoginState(''));
    }
    return isValid;
  }
}
