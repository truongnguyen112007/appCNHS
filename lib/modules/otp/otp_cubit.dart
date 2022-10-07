import 'package:base_bloc/modules/otp/otp_state.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../utils/toast_utils.dart';

class OtpCubit extends Cubit<OtpState> {
  final String phoneNumber;
  String verificationId = '';
  final END_TIME = 90;

  OtpCubit(this.phoneNumber) : super(OtpState()) {
    getOtp();
  }

  void continueOnclick(String otp) async {
    await FirebaseAuth.instance
        .signInWithCredential(PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: otp))
        .then((value) async {
          logE("TAG VALUE: ${value.user?.uid}");
        })
        .whenComplete(() {})
        .onError((error, stackTrace) {
          toast('OTP HET HAN, VUI LONG THU LAI');
          logE("TAG EXE: ${error}");
          /*      if (error.toString().contains(MessageKey.otp_invalid) ||
              error.toString().contains(MessageKey.verification_id_invalid)) {
            toast(LocaleKeys.wrong_otp.tr);
          } else if (error.toString().contains(MessageKey.otp_expired)) {
            toast(LocaleKeys.otp_het_han.tr);
          }*/
        });
  }

  void getOtp() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {},
          verificationFailed: (FirebaseAuthException e) {
            toast('OTP KO HOP LE VUI LONG THU LAI');
          },
          codeSent: (String verificationId, int? resendToken) =>
              this.verificationId = verificationId,
          codeAutoRetrievalTimeout: (String verification) =>
              verificationId = verification,
          timeout: Duration(seconds: END_TIME - 2));
    } catch (ex) {
      logE("TAG EX: ${ex}");
      toast('Lỗi mạng vui lòng thử lại sau.');
    }
  }
}
