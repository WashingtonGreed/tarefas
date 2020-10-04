import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:flutter/foundation.dart';
import 'package:tarefas/src/model/cep.dart';
import 'package:tarefas/src/utils/adapters/date_time_converter.dart';

class JsonUtils {
  static initialize() {

    JsonMapper().useAdapter(JsonMapperAdapter(valueDecorators: {
      typeOf<List<Cep>>(): (value) => value.cast<Cep>(),
    }, converters: {
      DateTime: DateTimeConverter(),
    }));
  }

  static String toJson(Object object) {
    return JsonMapper.serialize(object);
  }

  static T fromJson<T>(String json) {
    try {
      return JsonMapper.deserialize<T>(json);
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      debugPrint('Erro ao converter para Json');
      return null;
    }
  }

  static T fromMap<T>(Map map) {
    try {
      return JsonMapper.fromMap<T>(map, DeserializationOptions(caseStyle: CaseStyle.SnakeAllCaps));
    } catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      debugPrint('Erro ao converter para Json');
      return null;
    }
  }
}