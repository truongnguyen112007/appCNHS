import 'package:base_bloc/modules/search/search_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit() : super(InitState());

  void jumToPage (int index) => emit(onClickTab(index));
}