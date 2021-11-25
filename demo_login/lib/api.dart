import 'package:http/http.dart' as http;
import 'dart:convert';
Future loginUser(String email, String password) async{
    String url = 'https://dev.ecom.advn.vn/api/16/v1/account/login';
    final response =await http.post(url,
        headers: {"Accept":"Application/json"},
        body: {'email':email,'password':password}
        );
    var convertedDatatoJson =jsonDecode(response.body);
    return convertedDatatoJson;
}