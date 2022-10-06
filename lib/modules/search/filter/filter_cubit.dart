import 'package:base_bloc/data/model/filter_model.dart';
import 'package:base_bloc/data/repository/user_repository.dart';
import 'package:base_bloc/modules/new_details/new_detail_state.dart';
import 'package:base_bloc/modules/search/filter/filter_state.dart';
import 'package:base_bloc/utils/storage_utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterState()) {
    getFilter();
  }

  void getFilter() async {
    var response = await BaseRepository().getFilter();
    FilterModel model = FilterModel.fromJson(response.data);
    if (model.data == null) {
      emit(state.copyOf(status: FeedStatus.failure));
      return;
    }
    model.data!.insert(0, Datum(name: 'Tất cả'));
    var currentFilter = await StorageUtils.getFilter();
    emit(state.copyOf(
        status: FeedStatus.success,
        model: model,
        currentFilter: currentFilter));
  }

  void onClickRadioButton(int index, BuildContext context) async {
  await  StorageUtils.saveFilter(state.model?.data?[index]);
    Navigator.pop(context, state.model?.data?[index]);
  }
}
