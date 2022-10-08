import 'dart:async';
import 'package:base_bloc/data/model/user_model.dart';
import 'package:base_bloc/modules/otp/otp_state.dart';
import 'package:base_bloc/modules/update_information/update_information_page.dart';
import 'package:base_bloc/router/router_utils.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:base_bloc/utils/navigator_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import '../../data/repository/user_repository.dart';
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

  void continueOnclick(String otp, BuildContext context) async {
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: otp))
        .then((value) async {
          logE("TAG VALUE: ${value.user?.uid}");
          handleLogin(value.user?.uid??'');
        })
        .whenComplete(() {})
        .onError((error, stackTrace) {
          emit(OtpState(errorOTP: 'Lỗi OTP'));
          // toast('OTP HẾT HẠN, VUI LÒNG THỬ LẠI');
          logE("TAG EXE: ${error}");
        });
    handleLogin('');
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
          codeSent: (String verificationId, int? resendToken){
            this.verificationId = verificationId;
            logE("TSAFA : $verificationId");
          },
          codeAutoRetrievalTimeout: (String verification) =>
              verificationId = verification,
          timeout: Duration(seconds: END_TIME - 2));
    } catch (ex) {
      logE("TAG EX: ${ex}");
      toast('Lỗi mạng vui lòng thử lại sau.');
    }
  }

  void handleLogin(String uid) async{
    var response = await repository.login(uid);
    var userModel = UserModel.fromJson(response.data);
    logE("TAG RESPONSE: ${response.data}");
    if (userModel.userData == null ) {}
    else {}
  }
  String getTimeDisplay() => startCountDown >= 60
      ? '01:${(startCountDown - 60).toString().length == 1 ? '0${startCountDown - 60}' : startCountDown - 60}'
      : '00:${startCountDown.toString().length == 1 ? '0$startCountDown' : startCountDown}';

  void startTimer({bool isVerify = false}) {
    startCountDown = END_TIME;
    emit(const OtpState(timeDisplay: '01:30'));
    Timer.periodic(
      const Duration(seconds: 1),
      (Timer timer) {
        if (startCountDown == 0) {
          timer.cancel();
        } else {
          startCountDown--;
          emit(OtpState(
              timeDisplay: getTimeDisplay(), timeCountdown: startCountDown));
        }
      },
    );
  }
}
