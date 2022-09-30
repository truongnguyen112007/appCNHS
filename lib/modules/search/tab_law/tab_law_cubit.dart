import 'dart:async';
import 'package:base_bloc/modules/search/tab_law/tab_law_state.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/constant.dart';
import '../../../data/model/feed_model.dart';
import '../../../data/model/tab_criminal_law_model.dart';
import '../../../data/repository/user_repository.dart';
import '../../../router/router.dart';
import '../../../router/router_utils.dart';

class TabLawCubit extends Cubit<TabLawState> {
  var repository = BaseRepository();
  final int catId;

  TabLawCubit(this.catId)
      : super(const TabLawState(status: FeedStatus.initial)) {
    if (state.status == FeedStatus.initial) {
      // getFeed();
    }
  }

  Future<void> getSearch({bool isPaging = false, String? keySearch}) async {
    if(!isPaging) emit(state.copyOf(readEnd: false));
    if (state.readEnd) return;
    emit(
      state.copyOf(isLoading: true, keySearch: keySearch ?? ''),
    );
    var currentPage = !isPaging ? 1 : state.currentPage + 1;
    var response = await repository.getSearch(
        page: currentPage, content: keySearch ?? "", catId: catId);
    try {
      if (response.error == null && response.data != null) {
        var lResponse = feedModelFromJson(response.data['data']['data']);
        if (isPaging) {
          emit(state.copyOf(
              readEnd: lResponse.isEmpty ? true : false,
              isLoading: false,
              lPost: state.lFeed..addAll(lResponse),
              status: FeedStatus.success,
              currentPage: currentPage));
        } else {
          emit(
            state.copyOf(
                readEnd: lResponse.isEmpty ? true : false,
                lPost: lResponse,
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

  void itemOnclick(BuildContext context, FeedModel model) =>
      RouterUtils.pushHome(
          context: context,
          route: HomeRouters.detail,
          argument: [BottomnavigationConstant.TAB_HOME, model]);

  void refresh() {
    emit(const TabLawState(
        status: FeedStatus.refresh, currentPage: 1, readEnd: false));
    logE("TAG state.keySearch: ${state.keySearch}");
    getSearch(keySearch: state.keySearch);
  }
}
