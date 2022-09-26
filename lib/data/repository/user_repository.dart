import 'package:base_bloc/data/repository/api_result.dart';
import 'package:base_bloc/data/repository/base_service.dart';

class UserRepository extends BaseService {
  static UserRepository instance = UserRepository._init();

  factory UserRepository() {
    return instance;
  }

  UserRepository._init(){
    initProvider();
  }

  Future<ApiResult> getCategory() async => await GET('category');
}
