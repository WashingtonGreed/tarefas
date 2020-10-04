import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tarefas/src/model/usuario.dart';
import 'package:tarefas/src/utils/json_utils.dart';

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _localFileUsuario async {
    final path = await _localPath;
    return File('$path/usuario.txt');
  }

  Future<void> saveUsuario(Usuario usuario) async {
    try {
      if (usuario != null) {
        final file = await _localFileUsuario;
        String sUsuario = JsonUtils.toJson(usuario);
        await file.writeAsString('$sUsuario');
      } else {
        final file = await _localFileUsuario;
        file.delete();
      }
    } catch (e) {
      print(e);
      print('Erro Salvar dados do Usuario');
    }
  }

  Future<Usuario> readUsuario() async {
    try {
      final file = await _localFileUsuario;
      var exist = await file.exists();
      if (exist) {
        String contents = await file.readAsString();
        Usuario usuario = JsonUtils.fromJson(contents);
        return usuario;
      }
      return null;
    } catch (e) {
      debugPrint(e);
      print('Erro ler Dados Usuario');
      return null;
    }
  }

  Future<void> deleteUsuario() async {
    try {
      final file = await _localFileUsuario;
      var exist = await file.exists();
      if (exist) {
        file.delete();
      }
    } catch (e) {
      print('Erro ler ao deletar Usuario');
    }
  }
