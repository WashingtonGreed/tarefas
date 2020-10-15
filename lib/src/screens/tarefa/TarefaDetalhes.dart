import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tarefas/src/database/data_base.dart';
import 'package:tarefas/src/model/tarefa.dart';
import 'package:tarefas/src/model/usuario.dart';
import 'package:tarefas/src/screens/index.dart';
import 'package:tarefas/src/ui/alert/alert.dart';
import 'package:tarefas/src/ui/button/button.dart';

class TarefaDetalhes extends StatefulWidget {
  final Tarefa tarefa;
  final Usuario usuario;
  final bool visualizar;
  TarefaDetalhes({this.tarefa, this.usuario, this.visualizar = false});

  @override
  _TarefaDetalhesState createState() => _TarefaDetalhesState();
}

TextEditingController _tituloController = TextEditingController();
TextEditingController _descricaoController = TextEditingController();
TextEditingController _dataEntregaController = TextEditingController();
TextEditingController _dataConclusaoController = TextEditingController();

final df = new DateFormat('dd/MM/yyyy');

GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

class _TarefaDetalhesState extends State<TarefaDetalhes> {
  @override
  void initState() {
    if (widget.tarefa == null) {
      _tituloController.text = "";
      _descricaoController.text = "";
      _dataEntregaController.text = "";
      _dataConclusaoController.text = "";
    } else {
      _tituloController.text = widget.tarefa.titulo;
      _descricaoController.text = widget.tarefa.descricao;
      _dataEntregaController.text = widget.tarefa.dataEntrega;
      _dataConclusaoController.text = widget.tarefa.dataConclusao;
    }
    super.initState();
  }


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Get.off(Index()),
        child: new Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Get.off(Index())),
            title: Text(widget.tarefa?.titulo ?? "Tarefa"),
          ),
          backgroundColor: Colors.white,
          bottomSheet: widget.visualizar
              ? null
              : bottomButton(context, _formKey, widget.tarefa == null ? "CRIAR" : "SALVAR", salvarTarefa),
          body: _body(context),
        ));
  }

  Widget _body(BuildContext context) {
    return Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextFormField(
                    readOnly: widget.visualizar,
                    decoration: InputDecoration(
                        labelText: "Titulo", hintText: "Titulo"),
                    controller: _tituloController,
                    validator: (value) {
                      return validadorNome(value, 'Informe um Titulo');
                    }),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: "Data de Entrega",
                              hintText: "Data de Entrega"),
                          readOnly: true,
                          controller: _dataEntregaController,
                          validator: (value){
                            return value.isEmpty ? "Escolha uma data de Entrega" : null;
                          },
                          onTap: () async {
                            if(!widget.visualizar){
                            DateTime date = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now().add(Duration(days: 1)),
                                firstDate: DateTime(1920),
                                lastDate: DateTime(2030));
                            if (date != null) {
                              final df = new DateFormat('dd/MM/yyyy');
                              _dataEntregaController.text = df.format(date);
                            }
                          }},
                        )),

                    _dataConclusaoController.text != "" ? SizedBox(width: 20.0) : Container(),
                    
                    _dataConclusaoController.text != "" ? Expanded(
                        child: TextFormField(
                          readOnly: true,
                            decoration: InputDecoration(
                                labelText: "Data conclusão",
                                hintText: "Data conclusão"),
                            controller: _dataConclusaoController)) : Container(),
                  ],
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  readOnly: widget.visualizar,
                  decoration: InputDecoration(
                      labelText: "Descrição", hintText: "Descrição"),
                  controller: _descricaoController,
                  maxLines: 3,
                ),
                SizedBox(height: 50.0),
              ],
            ),
          ),
        ));
  }

  String validadorNome(String value, String textValidator) {
    if (value.trim().isEmpty || value.length < 3) {
      return textValidator;
    }
    return null;
  }

  String validaData(String value, String textValidator) {
    if (value.trim().isEmpty) {
      return textValidator;
    }
    return null;
  }

  void salvarTarefa() async {
    DataBase _dataBase = new DataBase();

    Tarefa _tarefa = new Tarefa();

    _tarefa.titulo = _tituloController.text;
    _tarefa.descricao = _descricaoController.text;
    _tarefa.dataEntrega = _dataEntregaController.text;
    _tarefa.dataConclusao = _dataConclusaoController.text;
    _tarefa.idUsuario = widget.usuario.id;

    alertLoading(texto: "Salvando Tarefa...");


    if (widget.tarefa != null) {
      _tarefa.id = widget.tarefa.id;
      await _dataBase.updateTarefa(_tarefa);
    } else {
      await _dataBase.saveTarefa(_tarefa);
    }

    await Future.delayed(Duration(seconds: 1));
    Navigator.pop(context);
    Get.off(Index());
  }
}
