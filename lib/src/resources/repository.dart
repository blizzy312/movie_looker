
import 'api_provider.dart';

class Repository{


  Future<String> guestLogin(){
    return ApiProvider().guestLogin();
  }
}