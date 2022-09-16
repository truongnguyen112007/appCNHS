import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class HomeState extends Equatable {}

class InitState extends HomeState {
  @override
  List<Object?> get props => [];
}

class IndexChangeState extends HomeState {
  final int index;

  IndexChangeState(this.index);

  @override
  List<Object?> get props => [index];
}

class onClickSearchIcon extends HomeState {
  @override
  List<Object?> get props => [];

}
