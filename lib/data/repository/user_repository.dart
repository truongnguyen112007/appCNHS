import 'package:base_bloc/data/repository/api_result.dart';
import 'package:base_bloc/data/repository/base_service.dart';

class BaseRepository extends BaseService {
  static BaseRepository instance = BaseRepository._init();

  factory BaseRepository() {
    return instance;
  }

  BaseRepository._init() {
    initProvider();
  }

  Future<ApiResult> getCategory() async => await GET('category');

  Future<ApiResult> getFeedByCatId(int catId) async =>
      await GET('post/news?catId=$catId');

  Future<ApiResult> getPost(int catId, int page, {int limit = 10}) async =>
      await GET('post/category?catId=$catId&page=$page&limit=$limit');

  Future<ApiResult> getPostDetailById(int id) async =>
      await GET('post/detail?postId=$id');
}
