import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginState extends Equatable {
  final errorPhone = '';

  @override
  List<Object?> get props => [];
}

class InitState extends LoginState {
  @override
  List<Object?> get props => [];
}

class FalseState extends LoginState {
  final String errorPhone;
  FalseState(this.errorPhone);
  @override
  List<Object?> get props => [];
}

class TrueState extends LoginState{

}
