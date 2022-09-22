import 'package:equatable/equatable.dart';

class FilterState extends Equatable {
  final int currentIndex;

  FilterState(this.currentIndex);

  @override
  List<Object?> get props => [currentIndex];
}

