import 'dart:async';

import 'package:base_bloc/data/model/category_model.dart';
import 'package:base_bloc/data/model/feed_model.dart';
import 'package:base_bloc/data/repository/user_repository.dart';
import 'package:base_bloc/modules/tab_home/tab_home_state.dart';
import 'package:base_bloc/utils/toast_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TabHomeCubit extends Cubit<TabHomeState> {
  var repository = UserRepository();

  TabHomeCubit() : super(const TabHomeState(status: FeedStatus.initial)) {
    if (state.status == FeedStatus.initial) {
      getCategory();
    }
  }

  Future<List<CategoryModel>?> getCategory() async {
    var response = await repository.getCategory();
    if (response.error == null && response.data != null) {
      var lCategory = categoryModelFromJson(response.data['data']['data']);
      List<Future<List<FeedModel>?>> tasks = [];
      for (var element in lCategory) {
        tasks.add(getFeedById(element.id ?? 0));
      }
      var lResult = await Future.wait(tasks);
      for (int i = 0; i < lResult.length; i++) {
        lCategory[i].lFeed = lResult[i];
      }
      emit(state.copyOf(lCategory: lCategory, status: FeedStatus.success));
    } else {
      toast(response.error.toString());
    }
    return null;
  }

  Future<List<FeedModel>?> getFeedById(int catId) async {
    var response = await repository.getFeedByCatId(catId);
    if (response.error == null && response.data != null) {
      return feedModelFromJson(response.data['data']['data']);
    }
    return null;
  }

  void refresh() {
    emit(TabHomeState(status: FeedStatus.refresh));
  }
}
