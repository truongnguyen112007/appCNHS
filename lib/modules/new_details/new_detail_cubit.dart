import 'package:base_bloc/data/model/post_detail_model.dart';
import 'package:base_bloc/modules/new_details/new_detail_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/user_repository.dart';

class NewDetailCubit extends Cubit<NewDetailState>{
  var repository = BaseRepository();
  final int postId;
  NewDetailCubit(this.postId) : super(const NewDetailState(status: FeedStatus.initial)) {
    if (state.status == FeedStatus.initial) {
        getPostDetail();
    }
  }

  void getPostDetail() async {
    var response = await BaseRepository().getPostDetailById(postId);
    if (response.error == null && response.data != null) {
      try{
        var model = PostDetailModel.fromJson(response.data);
        emit(state.copyOf(postDetailModel: model,status: FeedStatus.success));
      }catch(ex){}
    }
  }


}
