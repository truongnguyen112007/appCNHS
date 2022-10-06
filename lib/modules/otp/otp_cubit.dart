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
    verifyPhone();
  }

  void verifyPhone() async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {},
          verificationFailed: (FirebaseAuthException e) {
            toast('OTP KO HOP LE VUI LONG THU LAI');
          },
          codeSent: (String verificationId, int? resendToken) =>
              verificationId = verificationId,
          codeAutoRetrievalTimeout: (String verification) =>
              verificationId = verification,
          timeout: Duration(seconds: END_TIME - 2));
    } catch (ex) {
      logE("TAG EX: ${ex}");
      toast('Lỗi mạng vui lòng thử lại sau.');
    }
  }
}
