import 'dart:async';
import 'package:base_bloc/modules/search/tab_law/tab_law_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/tab_criminal_law_model.dart';

class TabLawCubit extends Cubit<TabLawState> {
  TabLawCubit() : super(const TabLawState(status: FeedStatus.initial)) {
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
        emit(TabLawState(
            readEnd: false,
            lFeed: fakeData(),
            status: FeedStatus.success,
            currentPage: 1));
      });
    }
  }

  void refresh() {
    emit(const TabLawState(status: FeedStatus.refresh));
    getFeed();
  }



  List<FeedModelCriminalLaw> fakeData() =>[
    FeedModelCriminalLaw(content: 'Quyết định 2373/QĐ-BYT năm 2022 hướng dẫn thực hiện tiêu chí, chỉ tiêu thuộc Bộ tiêu chí quốc gia về xã nông thôn mới/xã nông thôn mới nâng cao và huyện nông thôn mới/huyện nông thôn mới nâng cao giai đoạn 2021-2025 thuộc phạm vi quản lý của Bộ Y tế', creatDate: 'Có hiệu lực từ ngày', date: '22/8/2020'),
    FeedModelCriminalLaw(content: 'Quyết định 2373/QĐ-BYT năm 2022 hướng dẫn thực hiện tiêu chí, chỉ tiêu thuộc Bộ tiêu chí quốc gia về xã nông thôn mới/xã nông thôn mới nâng cao và huyện nông thôn mới/huyện nông thôn mới nâng cao giai đoạn 2021-2025 thuộc phạm vi quản lý của Bộ Y tế', creatDate: 'Có hiệu lực từ ngày', date: '22/8/2020'),
    FeedModelCriminalLaw(content: 'Quyết định 2373/QĐ-BYT năm 2022 hướng dẫn thực hiện tiêu chí, chỉ tiêu thuộc Bộ tiêu chí quốc gia về xã nông thôn mới/xã nông thôn mới nâng cao và huyện nông thôn mới/huyện nông thôn mới nâng cao giai đoạn 2021-2025 thuộc phạm vi quản lý của Bộ Y tế', creatDate: 'Có hiệu lực từ ngày', date: '22/8/2020'),
    FeedModelCriminalLaw(content: 'Quyết định 2373/QĐ-BYT năm 2022 hướng dẫn thực hiện tiêu chí, chỉ tiêu thuộc Bộ tiêu chí quốc gia về xã nông thôn mới/xã nông thôn mới nâng cao và huyện nông thôn mới/huyện nông thôn mới nâng cao giai đoạn 2021-2025 thuộc phạm vi quản lý của Bộ Y tế', creatDate: 'Có hiệu lực từ ngày', date: '22/8/2020'),
    FeedModelCriminalLaw(content: 'Quyết định 2373/QĐ-BYT năm 2022 hướng dẫn thực hiện tiêu chí, chỉ tiêu thuộc Bộ tiêu chí quốc gia về xã nông thôn mới/xã nông thôn mới nâng cao và huyện nông thôn mới/huyện nông thôn mới nâng cao giai đoạn 2021-2025 thuộc phạm vi quản lý của Bộ Y tế', creatDate: 'Có hiệu lực từ ngày', date: '22/8/2020'),
    FeedModelCriminalLaw(content: 'Quyết định 2373/QĐ-BYT năm 2022 hướng dẫn thực hiện tiêu chí, chỉ tiêu thuộc Bộ tiêu chí quốc gia về xã nông thôn mới/xã nông thôn mới nâng cao và huyện nông thôn mới/huyện nông thôn mới nâng cao giai đoạn 2021-2025 thuộc phạm vi quản lý của Bộ Y tế', creatDate: 'Có hiệu lực từ ngày', date: '22/8/2020'),
    FeedModelCriminalLaw(content: 'Quyết định 2373/QĐ-BYT năm 2022 hướng dẫn thực hiện tiêu chí, chỉ tiêu thuộc Bộ tiêu chí quốc gia về xã nông thôn mới/xã nông thôn mới nâng cao và huyện nông thôn mới/huyện nông thôn mới nâng cao giai đoạn 2021-2025 thuộc phạm vi quản lý của Bộ Y tế', creatDate: 'Có hiệu lực từ ngày', date: '22/8/2020'),
  ];
}