import 'package:base_bloc/config/constant.dart';
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

  Future<ApiResult> getPost(int catId, int page, {int limit = 20}) async =>
      await GET('post/category?catId=$catId&page=$page&limit=$limit');

  Future<ApiResult> getPostDetailById(int id) async =>
      await GET('post/detail?postId=$id');

  Future<ApiResult> getSearch(
          {required int catId,
          required String content,
          int? typeId,
          required int page}) async =>
      typeId != null
          ? await GET(
              'post/search?catId=$catId&typeId=$typeId&content=$content&page=$page&limit=20')
          : await GET(
              'post/search?catId=$catId&content=$content&page=$page&limit=20');

  Future<ApiResult> getFilter() async => await GET('type');

  Future<ApiResult> login(String uId) async =>
      await POST('user/login', {ApiKey.uid: uId},isContentType: true);
}
