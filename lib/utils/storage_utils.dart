import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/globals.dart' as globals;
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

  static Future<void> saveUser(UserModel model) async{
    globals.accessToken = model.data?.token?.token ?? '';
    await GetStorage().write(StorageKey.userModel, model.toJson());
  }

  static Future<UserModel?> getUser() async {
    try {
      var userModel =
          UserModel.fromJson(GetStorage().read(StorageKey.userModel));
      globals.isLogin = (userModel.isMissingUserInfo ?? true) ? false : true;
      globals.accessToken = userModel.data?.token?.token ?? '';
      return userModel;
    } catch (ex) {
      return null;
    }
  }
}
