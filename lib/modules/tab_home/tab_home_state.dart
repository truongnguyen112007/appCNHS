import 'package:equatable/equatable.dart';
import '../../data/model/home_model.dart';

enum FeedStatus { initial, success, failure, refresh }

class TabHomeState extends Equatable {
  final List<FeedModelHome> lFeed;
  final bool readEnd;
  final int currentPage;
  final FeedStatus status;

  const TabHomeState(
      {this.readEnd = false,
        this.currentPage = 1,
        this.lFeed = const <FeedModelHome>[],
        this.status = FeedStatus.initial});

  @override
  List<Object?> get props =>
      [lFeed, readEnd, currentPage];

  @override
  String toString() {
    return "TAB HOME STATE: lFeed readEnd currentPage";
  }

  TabHomeState copyOf(
      {List<FeedModelHome>? lFeed,
        bool? readEnd,
        int? currentPage,
        FeedStatus? status}) =>
      TabHomeState(
          lFeed: lFeed ?? this.lFeed,
          readEnd: readEnd ?? this.readEnd,
          currentPage: currentPage ?? this.currentPage,
          status: status ?? this.status);
}
