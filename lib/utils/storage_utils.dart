import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/model/filter_model.dart';
import 'package:get_storage/get_storage.dart';

import '../data/model/user_model.dart';

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

  static Future<void> saveUser(UserModel model) async =>
      await GetStorage().write(StorageKey.userModel, model.toJson());

  static Future<UserModel?> getUser() async {
    try {
      var result = GetStorage().read(StorageKey.userModel);
      return UserModel.fromJson(result);
    } catch (ex) {
      return null;
    }
  }
}
