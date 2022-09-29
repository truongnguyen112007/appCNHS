import 'package:base_bloc/data/model/feed_model.dart';
import 'package:equatable/equatable.dart';

enum FeedStatus {initial, success, failure, refresh}

class TabCriminalLawState extends Equatable {
  final List<FeedModel> lFeed;
  final bool readEnd;
  final int currentPage;
  final FeedStatus status;
  final bool isLoading;

  const TabCriminalLawState(
      {this.lFeed = const <FeedModel>[],
      this.isLoading = true,
      this.readEnd = false,
      this.currentPage = 1,
      this.status = FeedStatus.initial});

  @override
  List<Object?> get props => [readEnd, currentPage, status, lFeed, isLoading];

  @override
  String toString() {
    return "TAB CriminalLaw STATE: lFeed readEnd currentPage";
  }

  TabCriminalLawState copyOf(
          {List<FeedModel>? lPost,
          bool? readEnd,
          bool? isLoading,
          int? currentPage,
          FeedStatus? status}) =>
      TabCriminalLawState(
          lFeed: lPost ?? this.lFeed,
          readEnd: readEnd ?? this.readEnd,
          isLoading: isLoading ?? this.isLoading,
          currentPage: currentPage ?? this.currentPage,
          status: status ?? this.status);
}
