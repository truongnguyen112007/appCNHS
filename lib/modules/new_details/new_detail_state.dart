import 'package:base_bloc/data/model/post_detail_model.dart';
import 'package:equatable/equatable.dart';

enum FeedStatus { initial, success, failure, refresh}

class NewDetailState extends Equatable {
  final FeedStatus status;
  final bool isLoading;
  final PostDetailModel? postDetailModel;
  const NewDetailState(
      {this.isLoading = true,
        this.postDetailModel,
        this.status = FeedStatus.initial});

  @override
  List<Object?> get props => [status,isLoading,postDetailModel];

  @override
  String toString() {
    return "TAB NEW DETAIL: lDetail readEnd currentPage";
  }

  NewDetailState copyOf(
      {
        bool? isLoading,
        FeedStatus? status,
      PostDetailModel? postDetailModel}
      ) =>
      NewDetailState(
          isLoading: isLoading ?? this.isLoading,
          postDetailModel: postDetailModel ?? this.postDetailModel,
          status: status ?? this.status);
}