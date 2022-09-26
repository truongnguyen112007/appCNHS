import 'package:base_bloc/data/repository/api_result.dart';
import 'package:base_bloc/data/repository/base_service.dart';

class UserRepository extends BaseService {
  static UserRepository instance = UserRepository._init();

  factory UserRepository() {
    return instance;
  }

  UserRepository._init() {
    initProvider();
  }

  Future<ApiResult> getFeed() async => await GET(
      'everything?q=tesla&from=2022-08-26&sortBy=publishedAt&apiKey=e68a7e9007e24b23acdcb2aa58432a91');

  Future<ApiResult> getCategory() async => await GET('category');
}
