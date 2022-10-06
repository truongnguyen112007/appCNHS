import 'package:base_bloc/modules/login/login_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/app_utils.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(InitState());

  void openOtp() {
  }

  void onClickContinue(String phone, BuildContext context) async {
    // if (checkValid(phone,context)) {}
  }

//   bool checkValid(String phone, BuildContext context) {
//     bool isValid = false;
//     if (phone.isEmpty) {
//       isValid = false;
//       emit(FalseState('Login false'));
//     } else if (!Utils.validateMobile(phone)){
//       emit(FalseState('Login false'));
//       isValid = false;
//     } else {
//       isValid = true;
//       emit (TrueState('Login sucess'));
//     }
//   }
}
