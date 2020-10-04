
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:tarefas/src/model/model.dart';

@jsonSerializable
@Json(ignoreNullMembers: true)
class Usuario extends BeanBase {
  int id;
  String nome;
  String email;
  String dataNascimento;
  String cpf;
  String cep;
  String estado;
  String cidade;
  String bairro;
  String rua;
  String numero;
  String senha;

  Usuario({
    this.id,
    this.nome,
    this.email,
    this.dataNascimento,
    this.cpf,
    this.cep,
    this.estado,
    this.cidade,
    this.bairro,
    this.rua,
    this.numero,
    this.senha,
  });

  Usuario.fromMap(Map map) {
    
     id = map["id"];
     nome = map["nome"];
     email = map["email"];
     dataNascimento = map["dataNascimento"];
     cpf = map["cpf"];
     cep = map["cepa"];
     estado = map["estado"];
     cidade = map["cidade"];
     bairro = map["bairro"];
     rua = map["rua"];
     numero = map["numero"];
     senha = map["senha"];
  }

  Map toMap(){
    Map<String, dynamic> map = {
     "nome" : nome,
     "email" : email,
     "dataNascimento" : dataNascimento,
     "cpf" : cpf,
     "cep" : cep,
     "estado" : estado,
     "cidade" : cidade,
     "bairro" : bairro,
     "rua" : rua,
     "numero" : numero,
     "senha" : senha,
    }; 

    if(id != null ){
      map["id"] = id;
    }

    return map;
  }

}
