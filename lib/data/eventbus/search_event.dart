import '../model/filter_model.dart';

class SearchEvent {
   final int index;
   final String key;
   final Datum? filterModel;
   SearchEvent(this.index, this.key, this.filterModel);
}