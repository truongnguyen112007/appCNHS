import 'package:equatable/equatable.dart';

import '../../../data/model/tab_criminal_proceedings_model.dart';

enum FeedStatus { initial, success, failure, refresh }

class TabProceduralState extends Equatable {
  final List<FeedModelCriminalProceedings> lFeed;
  final bool readEnd;
  final int currentPage;
  final FeedStatus status;

  const TabProceduralState(
      {this.readEnd = false,
        this.currentPage = 1,
        this.lFeed = const <FeedModelCriminalProceedings>[],
        this.status = FeedStatus.initial});

  @override
  List<Object?> get props =>
      [lFeed, readEnd, currentPage];

  @override
  String toString() {
    return "TabCriminalProceedingsState: lFeed readEnd currentPage";
  }

  TabProceduralState copyOf(
      {List<FeedModelCriminalProceedings>? lFeed,
        bool? readEnd,
        int? currentPage,
        FeedStatus? status}) =>
      TabProceduralState(
          lFeed: lFeed ?? this.lFeed,
          readEnd: readEnd ?? this.readEnd,
          currentPage: currentPage ?? this.currentPage,
          status: status ?? this.status);
}
