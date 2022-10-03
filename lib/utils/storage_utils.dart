import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/model/filter_model.dart';
import 'package:get_storage/get_storage.dart';

class StorageUtils {
  static Future<void> saveFilter(Datum? model) async =>
      await GetStorage().write(StorageKey.filterModel, model?.toJson());

  static Future<Datum?> getFilter() async {
    try {
      var result = GetStorage().read(StorageKey.filterModel);
      return Datum.fromJson(result);
    } catch (ex) {}
    return null;
  }
}
