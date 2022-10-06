import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class LoginState extends Equatable {
  final String errorPhone;

  const LoginState(this.errorPhone);

  @override
  List<Object?> get props => [errorPhone];
}
