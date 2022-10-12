import 'package:base_bloc/localizations/app_localazations.dart';
import 'package:base_bloc/modules/login/login_state.dart';
import 'package:base_bloc/router/router.dart';
import 'package:base_bloc/router/router_utils.dart';
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
      emit(LoginState(AppLocalizations.of(context)!.enterPhoneNumber));
    } else if (!Utils.validateMobile(phone)) {
      emit(LoginState(AppLocalizations.of(context)!.phoneNumberNotTrue));
      isValid = false;
    } else {
      isValid = true;
      emit(const LoginState(''));
    }
    return isValid;
  }
}
