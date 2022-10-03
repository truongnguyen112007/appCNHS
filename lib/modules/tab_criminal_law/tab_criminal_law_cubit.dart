import 'dart:async';
import 'package:base_bloc/data/model/feed_model.dart';
import 'package:base_bloc/modules/tab_criminal_law/tab_criminal_law_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/user_repository.dart';

class TabCriminalLawCubit extends Cubit<TabCriminalLawState> {
  var repository = BaseRepository();
  final int catId;

  TabCriminalLawCubit(this.catId)
      : super(const TabCriminalLawState(status: FeedStatus.initial)) {
    if (state.status == FeedStatus.initial) {
      getPost();
    }
  }

  Future<void> getPost({bool isPaging = false}) async {
    if (state.readEnd) return;
    emit(state.copyOf(isLoading: true));
    var currentPage = !isPaging ? 1 : state.currentPage + 1;
    var response = await repository.getPost(catId, state.currentPage);
    try {
      if (response.error == null && response.data != null) {
        var lResponse = feedModelFromJson(response.data['data']['data']);
        if (isPaging) {
          emit(state.copyOf(
              isLoading: false,
              lFeed: state.lFeed..addAll(lResponse),
              status: FeedStatus.success,
              currentPage: currentPage));
        } else {
          emit(
            state.copyOf(
                lFeed: lResponse,
                isLoading: false,
                status: FeedStatus.success,
                currentPage: state.currentPage + 1),
          );
        }
      } else {
        emit(state.copyOf(status: FeedStatus.failure));
      }
    } catch (ex) {
      emit(state.copyOf(readEnd: true));
    }
    return;
  }

  void refresh() {
    emit(const TabCriminalLawState(status: FeedStatus.refresh, currentPage: 1));
    getPost();
  }
}
