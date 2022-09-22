import 'package:equatable/equatable.dart';

 abstract class SearchState extends Equatable{}

class InitState extends SearchState {
  @override
  List<Object?> get props => [];
}

class onClickTab extends SearchState{

   final int index;

   onClickTab (this.index);

  @override
  List<Object?> get props => [index];
}

