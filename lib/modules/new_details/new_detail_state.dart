import 'package:base_bloc/data/model/post_detail_model.dart';
import 'package:equatable/equatable.dart';

enum FeedStatus { initial, success, failure, refresh}

class NewDetailPageState extends Equatable {
  final FeedStatus status;
  final bool isLoading;
  final PostDetailModel? postDetailModel;
  const NewDetailPageState(
      {this.isLoading = true,
        this.postDetailModel,
        this.status = FeedStatus.initial});

  @override
  List<Object?> get props => [status,isLoading,postDetailModel];

  @override
  String toString() {
    return "TAB NEW DETAIL: lDetail readEnd currentPage";
  }

  NewDetailPageState copyOf(
      {
        bool? isLoading,
        FeedStatus? status,
      PostDetailModel? postDetailModel}
      ) =>
      NewDetailPageState(
          isLoading: isLoading ?? this.isLoading,
          postDetailModel: postDetailModel ?? this.postDetailModel,
          status: status ?? this.status);
}