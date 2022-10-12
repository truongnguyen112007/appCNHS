import 'package:equatable/equatable.dart';

class OtpState extends Equatable {
  final String timeDisplay;
  final int timeCountdown;
  final String? errorOTP;

  const OtpState({
    this.timeCountdown = 90,
    this.timeDisplay = '1:30',
    this.errorOTP,
  });

  OtpState copyOf({String? timeDisplay, int? timeCountdown, String? errorOtp}) =>
      OtpState(
          timeCountdown: timeCountdown ?? this.timeCountdown,
          timeDisplay: timeDisplay ?? this.timeDisplay,
          errorOTP: errorOtp ?? errorOTP);

  @override
  List<Object?> get props => [timeDisplay, timeCountdown,errorOTP];
}
