
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'model.dart';

@jsonSerializable
@Json(ignoreNullMembers: true)
class Tarefa extends BeanBase {
  int id;
  int idUsuario;
  String titulo;
  String descricao;
  String dataEntrega;
  String dataConclusao;

  Tarefa({
    this.id,
    this.idUsuario,
    this.titulo,
    this.descricao,
    this.dataEntrega,
    this.dataConclusao,
  });

  Tarefa.fromMap(Map map) {
     id = map["id"];
     idUsuario = map["idUsuario"];
     titulo = map["titulo"];
     descricao = map["descricao"];
     dataEntrega = map["dataEntrega"];
     dataConclusao = map["dataConclusao"];
  }

  Map toMap(){
    Map<String, dynamic> map = {
     "idUsuario" : idUsuario,
      "titulo" : titulo,
      "descricao" : descricao,
     "dataEntrega" : dataEntrega,
     "dataConclusao" : dataConclusao,
    }; 

    if(id != null ){
      map["id"] = id;
    }

    return map;
  }

}
