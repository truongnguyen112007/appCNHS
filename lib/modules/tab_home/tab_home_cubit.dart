import 'dart:async';

import 'package:base_bloc/modules/tab_home/tab_home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/home_model.dart';

class TabHomeCubit extends Cubit<TabHomeState> {
  TabHomeCubit() : super(const TabHomeState(status: FeedStatus.initial)) {
    if (state.status == FeedStatus.initial) {
      getFeed();
    }
  }

  void getFeed({bool isPaging = false}) {
    if (state.readEnd) return;
    if (isPaging) {
      Timer(const Duration(seconds: 1), () {
        emit(state.copyOf(
            lFeed: List.of(state.lFeed)..addAll(fakeData()), readEnd: true));
      });
    } else {
      Timer(const Duration(seconds: 1), () {
        emit(TabHomeState(
            readEnd: false,
            lFeed: fakeData(),
            status: FeedStatus.success,
            currentPage: 1));
      });
    }
  }

  void refresh() {
    emit(TabHomeState(status: FeedStatus.refresh));
    getFeed();
  }



  List<HomeModel> fakeData() =>[
    HomeModel(content: 'Quyết định 2373/QĐ-BYT năm 2022 hướng dẫn thực hiện tiêu chí, chỉ tiêu thuộc Bộ tiêu chí quốc gia về xã nông thôn mới/xã nông thôn mới nâng cao và huyện nông thôn mới/huyện nông thôn mới nâng cao giai đoạn 2021-2025 thuộc phạm vi quản lý của Bộ Y tế', creatDate: 'Có hiệu lực từ ngày', date: '22/8/2020'),
    HomeModel(content: 'Quyết định 2373/QĐ-BYT năm 2022 hướng dẫn thực hiện tiêu chí, chỉ tiêu thuộc Bộ tiêu chí quốc gia về xã nông thôn mới/xã nông thôn mới nâng cao và huyện nông thôn mới/huyện nông thôn mới nâng cao giai đoạn 2021-2025 thuộc phạm vi quản lý của Bộ Y tế', creatDate: 'Có hiệu lực từ ngày', date: '22/8/2020'),
    HomeModel(content: 'Quyết định 2373/QĐ-BYT năm 2022 hướng dẫn thực hiện tiêu chí, chỉ tiêu thuộc Bộ tiêu chí quốc gia về xã nông thôn mới/xã nông thôn mới nâng cao và huyện nông thôn mới/huyện nông thôn mới nâng cao giai đoạn 2021-2025 thuộc phạm vi quản lý của Bộ Y tế', creatDate: 'Có hiệu lực từ ngày', date: '22/8/2020'),
    HomeModel(content: 'Quyết định 2373/QĐ-BYT năm 2022 hướng dẫn thực hiện tiêu chí, chỉ tiêu thuộc Bộ tiêu chí quốc gia về xã nông thôn mới/xã nông thôn mới nâng cao và huyện nông thôn mới/huyện nông thôn mới nâng cao giai đoạn 2021-2025 thuộc phạm vi quản lý của Bộ Y tế', creatDate: 'Có hiệu lực từ ngày', date: '22/8/2020'),
  ];
}