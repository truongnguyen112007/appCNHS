import 'package:equatable/equatable.dart';
import '../../../data/model/feed_model.dart';

enum FeedStatus { initial, success, failure, refresh }

class TabLawState extends Equatable {
  final List<FeedModel> lFeed;
  final bool readEnd;
  final int currentPage;
  final FeedStatus status;
  final bool isLoading;
  final String keySearch;

  const TabLawState(
      {this.lFeed = const <FeedModel>[],
        this.isLoading = true,
        this.readEnd = false,
      this.currentPage = 1,
      this.status = FeedStatus.initial,
      this.keySearch = ''});

  @override
  List<Object?> get props => [readEnd, currentPage, status, lFeed, isLoading];

  @override
  String toString() {
    return "TabLawState: lFeed readEnd currentPage";
  }

  TabLawState copyOf(
          {List<FeedModel>? lPost,
          bool? readEnd,
          bool? isLoading,
          int? currentPage,
          String? keySearch,
          FeedStatus? status}) =>
      TabLawState(
          lFeed: lPost ?? this.lFeed,
          readEnd: readEnd ?? this.readEnd,
          isLoading: isLoading ?? this.isLoading,
          currentPage: currentPage ?? this.currentPage,
          keySearch: keySearch ?? this.keySearch,
          status: status ?? this.status);
}
