import 'dart:convert';

import 'package:tarefas/src/model/cep.dart';
import 'dart:async';
import 'package:tarefas/src/services/services.dart';
import 'package:tarefas/src/utils/json_utils.dart';

Service service = new Service();

Future<Cep> getCep(String cep) async {
  try {
    
    final response = await service.getService(cep);

    if (response.statusCode == 200) {
      Map map = jsonDecode(response.body);
      Cep cep = JsonUtils.fromJson(jsonEncode(map));
      return cep;

    } else {
      return null;
    }
  } catch (e) {
    return null;
  }
}