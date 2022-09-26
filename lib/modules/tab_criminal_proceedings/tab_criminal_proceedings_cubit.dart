import 'dart:async';
import 'package:base_bloc/modules/tab_criminal_proceedings/tab_criminal_proceedings_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/test_model.dart';

class TabCriminalProceedingsCubit extends Cubit<TabCriminalProceedingsState> {
  TabCriminalProceedingsCubit() : super(const TabCriminalProceedingsState(status: FeedStatus.initial)) {
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
        emit(TabCriminalProceedingsState(
            readEnd: false,
            lFeed: fakeData(),
            status: FeedStatus.success,
            currentPage: 1));
      });
    }
  }

  void refresh() {
    emit(const TabCriminalProceedingsState(status: FeedStatus.refresh));
    getFeed();
  }



  List<FeedModelCriminalProceedings> fakeData() =>[
    FeedModelCriminalProceedings(content: 'Quyết định 2373/QĐ-BYT năm 2022 hướng dẫn thực hiện tiêu chí, chỉ tiêu thuộc Bộ tiêu chí quốc gia về xã nông thôn mới/xã nông thôn mới nâng cao và huyện nông thôn mới/huyện nông thôn mới nâng cao giai đoạn 2021-2025 thuộc phạm vi quản lý của Bộ Y tế', creatDate: 'Có hiệu lực từ ngày', date: '22/8/2020'),
    FeedModelCriminalProceedings(content: 'Quyết định 2373/QĐ-BYT năm 2022 hướng dẫn thực hiện tiêu chí, chỉ tiêu thuộc Bộ tiêu chí quốc gia về xã nông thôn mới/xã nông thôn mới nâng cao và huyện nông thôn mới/huyện nông thôn mới nâng cao giai đoạn 2021-2025 thuộc phạm vi quản lý của Bộ Y tế', creatDate: 'Có hiệu lực từ ngày', date: '22/8/2020'),
    FeedModelCriminalProceedings(content: 'Quyết định 2373/QĐ-BYT năm 2022 hướng dẫn thực hiện tiêu chí, chỉ tiêu thuộc Bộ tiêu chí quốc gia về xã nông thôn mới/xã nông thôn mới nâng cao và huyện nông thôn mới/huyện nông thôn mới nâng cao giai đoạn 2021-2025 thuộc phạm vi quản lý của Bộ Y tế', creatDate: 'Có hiệu lực từ ngày', date: '22/8/2020'),
    FeedModelCriminalProceedings(content: 'Quyết định 2373/QĐ-BYT năm 2022 hướng dẫn thực hiện tiêu chí, chỉ tiêu thuộc Bộ tiêu chí quốc gia về xã nông thôn mới/xã nông thôn mới nâng cao và huyện nông thôn mới/huyện nông thôn mới nâng cao giai đoạn 2021-2025 thuộc phạm vi quản lý của Bộ Y tế', creatDate: 'Có hiệu lực từ ngày', date: '22/8/2020'),
    FeedModelCriminalProceedings(content: 'Quyết định 2373/QĐ-BYT năm 2022 hướng dẫn thực hiện tiêu chí, chỉ tiêu thuộc Bộ tiêu chí quốc gia về xã nông thôn mới/xã nông thôn mới nâng cao và huyện nông thôn mới/huyện nông thôn mới nâng cao giai đoạn 2021-2025 thuộc phạm vi quản lý của Bộ Y tế', creatDate: 'Có hiệu lực từ ngày', date: '22/8/2020'),
    FeedModelCriminalProceedings(content: 'Quyết định 2373/QĐ-BYT năm 2022 hướng dẫn thực hiện tiêu chí, chỉ tiêu thuộc Bộ tiêu chí quốc gia về xã nông thôn mới/xã nông thôn mới nâng cao và huyện nông thôn mới/huyện nông thôn mới nâng cao giai đoạn 2021-2025 thuộc phạm vi quản lý của Bộ Y tế', creatDate: 'Có hiệu lực từ ngày', date: '22/8/2020'),
    FeedModelCriminalProceedings(content: 'Quyết định 2373/QĐ-BYT năm 2022 hướng dẫn thực hiện tiêu chí, chỉ tiêu thuộc Bộ tiêu chí quốc gia về xã nông thôn mới/xã nông thôn mới nâng cao và huyện nông thôn mới/huyện nông thôn mới nâng cao giai đoạn 2021-2025 thuộc phạm vi quản lý của Bộ Y tế', creatDate: 'Có hiệu lực từ ngày', date: '22/8/2020'),
  ];
}