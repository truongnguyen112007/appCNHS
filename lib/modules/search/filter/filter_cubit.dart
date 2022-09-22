import 'package:base_bloc/modules/search/filter/filter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterCubit extends Cubit<FilterState> {
  FilterCubit() : super(FilterState(0));

  void onClickRadioButton(int index) => emit(FilterState(index));
}
