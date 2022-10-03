import 'package:equatable/equatable.dart';
import '../../../data/model/filter_model.dart';
import '../../new_details/new_detail_state.dart';

class FilterState extends Equatable {
  final int? currentIndex;
  final FilterModel? model;
  final FeedStatus status;

  FilterState(
      {this.currentIndex, this.model, this.status = FeedStatus.initial});

  @override
  List<Object?> get props => [currentIndex, model, status];

  FilterState copyOf({
    int? currentIndex,
    FilterModel? model,
    FeedStatus? status,
  }) =>
      FilterState(
          currentIndex: currentIndex ?? this.currentIndex,
          model: model ?? this.model,
          status: status ?? this.status);
}
