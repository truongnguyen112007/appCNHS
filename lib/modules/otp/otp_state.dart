import 'package:equatable/equatable.dart';

class OtpState extends Equatable {
  final String timeDisplay;
  final int timeCountdown;
  final String? errorOTP;

  const OtpState({this.timeCountdown = 90, this.timeDisplay = '1:30',this.errorOTP,});

  @override
  List<Object?> get props => [timeDisplay, timeCountdown];
}
