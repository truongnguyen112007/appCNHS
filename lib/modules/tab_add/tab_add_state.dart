import 'package:equatable/equatable.dart';

class AddState extends Equatable {
  final int timeStamp;

  AddState({this.timeStamp = 1});

  @override
  List<Object?> get props => [timeStamp];
}
