import 'dart:async';

import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/model/user_model.dart';
import 'package:base_bloc/modules/otp/otp_state.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/utils/app_utils.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:base_bloc/utils/storage_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/eventbus/switch_tab_event.dart';
import '../../data/repository/user_repository.dart';
import '../../router/router.dart';
import '../../utils/toast_utils.dart';

class OtpCubit extends Cubit<OtpState> {
  final repository = BaseRepository();
  final String phoneNumber;
  String verificationId = '';
  final END_TIME = 90;
  var startCountDown = 90;

  OtpCubit(this.phoneNumber) : super(const OtpState()) {
    getOtp();
    startTimer();
  }

  bool isValid(String text) {
    var isValid = false;
    if (text.isEmpty) {
      emit(state.copyOf(errorOtp: 'Vui lòng nhập OTP'));
      // toast('Vui lòng nhập otp.');
    } else if (text.length == 6) {
      isValid = true;
    } else {
      emit(state.copyOf(errorOtp: 'OTP chưa đúng định dạng'));
      // toast('Otp chưa đúng định dạng.');
    }
    return isValid;
  }

  void continueOnclick(String otp, BuildContext context) async {
    if (!isValid(otp)) return;
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: otp))
        .then((value) async {
          handleLogin(value.user?.uid ?? '', context);
        })
        .whenComplete(() {})
        .onError((error, stackTrace) {
          emit(state.copyOf(errorOtp: 'Lỗi OTP'));
          // toast('Otp không đúng, vui lòng thử lại sau.');
        });
  }

  void resentOnclick() {
    getOtp();
    startTimer();
  }

  void getOtp() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {},
          verificationFailed: (FirebaseAuthException e) {
            toast('OTP không hợp lệ, vui lòng thử lại');
          },
          codeSent: (String verificationId, int? resendToken) {
            this.verificationId = verificationId;
          },
          codeAutoRetrievalTimeout: (String verification) =>
              verificationId = verification,
          timeout: Duration(seconds: END_TIME - 2));
    } catch (ex) {
      // toast('Lỗi mạng, vui lòng thử lại sau.');
    }
  }

  void handleLogin(String uid, BuildContext context) async {
    var response = await repository.login(uid);
    try {
      var userModel = UserModel.fromJson(response.data);
      StorageUtils.saveUser(userModel);
      if (userModel.isMissingUserInfo == true) {
        RouterUtils.pushAdd(
            context: context,
            route: AddRouters. update,
            argument: [phoneNumber, userModel.data?.userData?.id ?? 0]);
      } else {
        StorageUtils.getUser();
        Utils.fireEvent(SwitchTabEvent(BottomNavigationConstant.TAB_ADD));
      }
    } catch (ex) {
      toast('Lỗi mạng, vui lòng thử lại sau.');
    }
  }

  String getTimeDisplay() => startCountDown >= 60
      ? '01:${(startCountDown - 60).toString().length == 1 ? '0${startCountDown - 60}' : startCountDown - 60}'
      : '00:${startCountDown.toString().length == 1 ? '0$startCountDown' : startCountDown}';

  void startTimer({bool isVerify = false}) {
    startCountDown = END_TIME;
    emit(state.copyOf(timeDisplay: '01:30'));
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (startCountDown == 0) {
          timer.cancel();
        } else {
          startCountDown--;
          emit(state.copyOf( timeDisplay: getTimeDisplay(), timeCountdown: startCountDown));
        }
      },
    );
  }
}
