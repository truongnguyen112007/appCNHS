import 'package:base_bloc/data/repository/user_repository.dart';
import 'package:base_bloc/modules/feedback/feedback_state.dart';
import 'package:base_bloc/utils/storage_utils.dart';
import 'package:base_bloc/utils/toast_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedBackCubit extends Cubit<FeedBackSate> {
  final repository = BaseRepository();
  FeedBackCubit() : super(FeedBackSate());

  void sentOnClick(/*String name, int phone,String email,String address,*/String content )async {
    var userModel =await StorageUtils.getUser();
    var response = await repository.feedBack(userModel?.data?.userData?.lastName??'', userModel?.data?.userData?.phone ?? '', "truong@gmail.com", "asdad",content);
    if (response.error == null && response.data != null){
      toast(response.message);
    }else {
      toast('false');
    }
  }
}
