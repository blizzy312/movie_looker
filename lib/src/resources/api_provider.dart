import 'dart:convert';

import 'package:http/http.dart' show Client;

class ApiProvider{
  final _rootAddress = 'https://api.themoviedb.org/3';
  final _apiKey = '467e0821029c1f28d7a6f61e0e1c851e';
  Client client = Client();

  Future<String> guestLogin() async{
    final response = await client.get('$_rootAddress/authentication/guest_session/new?api_key=$_apiKey');
    final temp = json.decode(response.body);
    print(temp.toString());
    return temp.toString();
  }
}