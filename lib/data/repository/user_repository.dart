import 'package:base_bloc/config/constant.dart';
import 'package:base_bloc/data/repository/api_result.dart';
import 'package:base_bloc/data/repository/base_service.dart';
import 'package:dio/dio.dart';

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
      await POST('user/login', {ApiKey.uid: uId}, isContentType: true);

  Future<ApiResult> updateProfile(
      String firstName, String lastName, int userId) async {
    var body = FormData.fromMap(
        {ApiKey.firstName: firstName, ApiKey.lastName: lastName});
    return await PATCH('user/update/$userId', body);
  }

  Future<ApiResult> feedBack (String name, String phone,String email,String address,String content ) async {
    var body = FormData.fromMap({ApiKey.name: name,
      ApiKey.phone: phone,
      ApiKey.email: email,ApiKey.address: address,ApiKey.main: content});
       return await POST('feedback', body,isMultipart: true);
  }

  Future<ApiResult> logOut() async {
      return await GET('user/logout');
  }

  Future<ApiResult> deleteUser() async {
    return await GET('user/delete-account');
  }
}
