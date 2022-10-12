import 'package:base_bloc/modules/tab_add/tab_add_state.dart';
import 'package:base_bloc/utils/toast_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../config/constant.dart';
import '../../data/repository/user_repository.dart';
import '../../router/router.dart';
import '../../router/router_utils.dart';
import '../../utils/storage_utils.dart';

class AddCubit extends Cubit<AddState> {
  final repository = BaseRepository();

  AddCubit() : super(AddState());

  void loginOnClick(BuildContext context) async {
    await RouterUtils.pushAdd(
        context: context,
        route: AddRouters.login,
        argument: BottomNavigationConstant.TAB_ADD);
    emit(AddState(timeStamp: DateTime.now().millisecondsSinceEpoch));
  }

  void updateProfileOnClick(BuildContext context) async {
    var userModel = await StorageUtils.getUser();
    RouterUtils.pushAdd(context: context, route: AddRouters.update, argument: [
      userModel?.data?.userData?.phone ?? '',
      userModel?.data?.userData?.id ?? 0
    ]);
  }

  void feedBackOnClick(BuildContext context) async {
    await RouterUtils.pushAdd(
        context: context,
        route: AddRouters.comment,
        argument: BottomNavigationConstant.TAB_ADD);
  }

  void contactOnClick(BuildContext context) async {
    await RouterUtils.pushAdd(
        context: context,
        route: AddRouters.contact,
        argument: BottomNavigationConstant.TAB_ADD);
  }

  void logOutOnClick() async {
    var response = await repository.logOut();
    if (response.error == null) {
      StorageUtils.clearInfo();
      toast(response.message);
      emit(AddState(timeStamp: DateTime.now().microsecondsSinceEpoch));
    } else {
      toast(response.error);
    }
  }

  void deleteOnClick () async {
    var response = await repository.deleteUser();
    if (response.error == null) {
      toast(response.message);
      emit(AddState(timeStamp: DateTime.now().microsecondsSinceEpoch));
    } else {
      toast(response.error);
    }
  }
}
