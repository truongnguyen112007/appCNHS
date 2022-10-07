import 'package:equatable/equatable.dart';

class OtpState extends Equatable {
  final String timeDisplay;
final int timeCountdown;
  const OtpState( {this.timeCountdown = 90 ,this.timeDisplay = '1:30'});

  @override
  List<Object?> get props => [timeDisplay,timeCountdown];
}
