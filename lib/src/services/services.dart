import 'package:http/http.dart' as http;
import 'dart:async';

http.Client client = http.Client();

class Service {
  
Future<http.Response> getService(String cep) async {
  String request = 'https://viacep.com.br/ws/$cep/json/';
    var response = await client.get(request, headers: {"Content-type": "application/json"});
    return response;
  }
}

