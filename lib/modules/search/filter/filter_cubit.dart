import 'package:base_bloc/modules/search/filter/filter_state.dart';
import 'package:base_bloc/utils/storage_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterState(0)) {
    getFilter();
  }

  void getFilter() async {
    var currentIndex = await StorageUtils.getFilter();
    emit(FilterState(currentIndex));
  }

  void onClickRadioButton(int index) async {
    await StorageUtils.saveFilter(index);
    emit(FilterState(index));
  }
}
