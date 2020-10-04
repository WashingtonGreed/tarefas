import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:tarefas/src/model/model.dart';

@jsonSerializable
@Json(ignoreNullMembers: true)
class Cep extends BeanBase {
  int codigo;
  String cep;
  String uf;
  String logradouro;
  String bairro;
  String localidade;
  String numero;

  Cep({
    this.codigo,
    this.cep,
    this.uf,
    this.logradouro,
    this.bairro,
    this.localidade,
    this.numero,
  });
}

