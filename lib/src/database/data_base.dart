import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tarefas/src/database/tarefa.tabela.dart';
import 'package:tarefas/src/database/usuario.tabela.dart';
import 'package:tarefas/src/model/tarefa.dart';
import 'package:tarefas/src/model/usuario.dart';

class DataBase {

  static final DataBase _instance = DataBase.internal();
  factory DataBase() => _instance;
  DataBase.internal();

  TabelaUsuario tabelaUsuario = new TabelaUsuario();
  TabelaTarefa tabelaTarefa = new TabelaTarefa();

  Database _db;

  Future<Database> get db async {
    if(_db != null){
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

    Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "banco.db");

    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
          '''CREATE TABLE ${tabelaUsuario.nomeTabela}(${tabelaUsuario.id} INTEGER PRIMARY KEY, ${tabelaUsuario.nome} TEXT, ${tabelaUsuario.email} TEXT, ${tabelaUsuario.dataNascimento} TEXT, ${tabelaUsuario.cpf} TEXT, ${tabelaUsuario.cep} TEXT, ${tabelaUsuario.estado} TEXT, ${tabelaUsuario.cidade} TEXT, ${tabelaUsuario.bairro} TEXT, ${tabelaUsuario.rua} TEXT, ${tabelaUsuario.numero} TEXT, ${tabelaUsuario.senha} TEXT)'''
      );
      await db.execute(
      '''CREATE TABLE ${tabelaTarefa.nomeTabela}(${tabelaTarefa.id} INTEGER PRIMARY KEY, ${tabelaTarefa.idUsuario} INTEGER, ${tabelaTarefa.titulo} TEXT, ${tabelaTarefa.descricao} TEXT, ${tabelaTarefa.dataEntrega} TEXT, ${tabelaTarefa.dataConclusao} TEXT)'''
      );
    });
  }

  Future<Map> saveUsuario(Usuario usuario) async {
    Database banco = await db;

    List<Map> map = await 
    banco.rawQuery('''SELECT * FROM ${tabelaUsuario.nomeTabela} WHERE '${tabelaUsuario.email}' = ${tabelaUsuario.email} OR '${usuario.cpf}' = ${tabelaUsuario.cpf} LIMIT 1''');
    
    if(map.length == 0){
      usuario.id = await banco.insert(tabelaUsuario.nomeTabela, usuario.toMap());
      return usuario.toMap();
    }

    Map<String,dynamic> error = new Map<String,dynamic>();

    error["error"] =  (map[0]["email"] == usuario.email ?
    ["E-mail já cadastrado informe outro!"]:["cpf já cadastrado informe outro!"]);

    return error;
  }

  Future<Tarefa> saveTarefa(Tarefa tarefa) async {
    Database banco = await db;
    
      tarefa.id = await banco.insert(tabelaTarefa.nomeTabela, tarefa.toMap());
      return tarefa;
  }

  Future<Usuario> getUsuario(int id) async {
    Database banco = await db;
    
    List<Map> maps = await banco.query(tabelaUsuario.nomeTabela,
      columns: [tabelaUsuario.id, tabelaUsuario.nome, tabelaUsuario.email, tabelaUsuario.dataNascimento,
    tabelaUsuario.cpf, tabelaUsuario.cep, tabelaUsuario.estado, tabelaUsuario.cidade, 
    tabelaUsuario.bairro, tabelaUsuario.rua, tabelaUsuario.numero, tabelaUsuario.senha],
      where: "${tabelaUsuario.id} = ?",
      whereArgs: [id]);

    if(maps.length > 0){
      return Usuario.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<Usuario> getLogin1(String email, String senha) async {
    Database banco = await db;
    
    List<Map> maps = await 
    banco.rawQuery('''SELECT * FROM ${tabelaUsuario.nomeTabela} WHERE '$email' = ${tabelaUsuario.email} AND '$senha' = ${tabelaUsuario.senha} LIMIT 1''');

    if(maps.length > 0){
      return Usuario.fromMap(maps.first);
    } else {
      return null;
    }
  }


  Future<Usuario> getLogin(String email, String senha) async {
    Database banco = await db;
    
    List listMap = await banco.query(tabelaUsuario.nomeTabela,
      columns: ['''*'''],
      where: '${tabelaUsuario.email} = ? AND ${tabelaUsuario.senha} = ?',
      whereArgs: [email, senha]);

    if(listMap.length > 0){
      return Usuario.fromMap(listMap.first);
    } else {
      return null;
    }
  }

  Future<List<Tarefa>> getAllTarefasUsuario(int id) async {
    Database banco = await db;
    List listMap = await banco.query(tabelaTarefa.nomeTabela,
      columns: [tabelaTarefa.id, tabelaTarefa.titulo, tabelaTarefa.descricao,
      tabelaTarefa.dataConclusao, tabelaTarefa.dataEntrega, tabelaTarefa.idUsuario],
      where: "${tabelaTarefa.idUsuario} = ?",
      whereArgs: [id]);
    
    List<Tarefa> listTarefas = List<Tarefa>();
    for(Map m in listMap){
      listTarefas.add(Tarefa.fromMap(m));
    }
    return listTarefas;
  }

    Future<int> deleteTarefa(int id) async {
    Database banco = await db;
    return await banco.delete(tabelaTarefa.nomeTabela, where: "${tabelaTarefa.id} = ?",
    whereArgs: [id]);
  }

  Future<int> updateTarefa(Tarefa tarefa) async {
    Database banco = await db;
    return await banco.update(tabelaTarefa.nomeTabela,
        tarefa.toMap(),
        where: "${tabelaTarefa.id} = ?",
        whereArgs: [tarefa.id]);
  }
  
    Future close() async {
    Database banco = await db;
    banco.close();
  }

}