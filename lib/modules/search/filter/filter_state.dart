import 'package:equatable/equatable.dart';
import '../../../data/model/filter_model.dart';
import '../../new_details/new_detail_state.dart';

class FilterState extends Equatable {
  final Datum? currentFilter;
  final FilterModel? model;
  final FeedStatus status;

  FilterState(
      {this.currentFilter, this.model, this.status = FeedStatus.initial});

  @override
  List<Object?> get props => [currentFilter, model, status];

  FilterState copyOf({
    Datum? currentFilter,
    FilterModel? model,
    FeedStatus? status,
  }) =>
      FilterState(
          currentFilter: currentFilter ?? this.currentFilter,
          model: model ?? this.model,
          status: status ?? this.status);
}
