import 'package:base_bloc/data/model/post_detail_model.dart';
import 'package:base_bloc/modules/new_details/new_detail_state.dart';
import 'package:base_bloc/utils/log_utils.dart';
import 'package:base_bloc/utils/toast_utils.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repository/user_repository.dart';

class NewDetailPageCubit extends Cubit<NewDetailPageState> {
  var repository = BaseRepository();
  final int postId;

  NewDetailPageCubit(this.postId)
      : super(const NewDetailPageState(status: FeedStatus.initial)) {
    if (state.status == FeedStatus.initial) {
      getPostDetail();
    }
  }

  void getPostDetail() async {
    var response = await BaseRepository().getPostDetailById(postId);
    if (response.error == null && response.data != null) {
      try {
        var model = PostDetailModel.fromJson(response.data);
        emit(state.copyOf(postDetailModel: model, status: FeedStatus.success));
      } catch (ex) {
        emit(state.copyOf(status: FeedStatus.failure));
      }
    } else {
      emit(state.copyOf(status: FeedStatus.failure));
    }
  }
}
