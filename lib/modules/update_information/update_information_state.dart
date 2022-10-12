import 'package:equatable/equatable.dart';

class UpdateInformationState extends Equatable {
  final String errorName;

  const UpdateInformationState(this.errorName);

  @override
  List<Object?> get props => [errorName];
}
