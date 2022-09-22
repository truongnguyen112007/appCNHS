import 'package:equatable/equatable.dart';
import '../../../data/model/tab_criminal_law_model.dart';

enum FeedStatus { initial, success, failure, refresh }

class TabLawState extends Equatable {
  final List<FeedModelCriminalLaw> lFeed;
  final bool readEnd;
  final int currentPage;
  final FeedStatus status;

  const TabLawState(
      {this.readEnd = false,
        this.currentPage = 1,
        this.lFeed = const <FeedModelCriminalLaw>[],
        this.status = FeedStatus.initial});

  @override
  List<Object?> get props =>
      [lFeed, readEnd, currentPage];

  @override
  String toString() {
    return "TabLawState: lFeed readEnd currentPage";
  }

  TabLawState copyOf(
      {List<FeedModelCriminalLaw>? lFeed,
        bool? readEnd,
        int? currentPage,
        FeedStatus? status}) =>
      TabLawState(
          lFeed: lFeed ?? this.lFeed,
          readEnd: readEnd ?? this.readEnd,
          currentPage: currentPage ?? this.currentPage,
          status: status ?? this.status);
}
