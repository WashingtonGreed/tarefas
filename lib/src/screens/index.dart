import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tarefas/src/database/data_base.dart';
import 'package:tarefas/src/model/tarefa.dart';
import 'package:tarefas/src/model/usuario.dart';
import 'package:tarefas/src/provider/usuario.provider.dart';
import 'package:tarefas/src/screens/tarefa/TarefaDetalhes.dart';
import 'package:tarefas/src/ui/alert/alert.dart';

import 'login/login.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  
  SlidableController slidableController;
  Usuario usuario = new Usuario();
  DataBase dataBase = new DataBase();
  List<Tarefa> tarefas;

  @protected
  void initState() {
    super.initState();
    _inicializa();

  }

   _inicializa() async {
    DataBase dataBase = new DataBase();
    usuario = await readUsuario();

   await dataBase.getAllTarefasUsuario(usuario.id).then((value) {
     setState(() {
       tarefas = value;
     });
   });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => null,
        child: new Scaffold(
          appBar: AppBar(
            leading: Icon(null),
            actions: <Widget>[
              IconButton(
                  icon: Icon(FontAwesomeIcons.signOutAlt),
                  onPressed: () async {
                    await deleteUsuario();
                    Get.off(Login());
                  })
            ],
            title: Text("Tarefas"),
          ),
          body: Center(
            child: OrientationBuilder(
              builder: (context, orientation) => _buildList(
                  context,
                  orientation == Orientation.portrait
                      ? Axis.vertical
                      : Axis.horizontal),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => Get.to(TarefaDetalhes(usuario: usuario)),
          ),
        ));
  }

  Widget _buildList(BuildContext context, Axis direction) {
    return tarefas != null
        ? ListView.builder(
      scrollDirection: direction,
      itemBuilder: (context, index) {
        final Axis slidableDirection = direction == Axis.horizontal
            ? Axis.vertical
            : Axis.horizontal;
        return _getSlidableWithLists(context, index, slidableDirection);
      },
      itemCount: tarefas.length,
    )
        : CircularProgressIndicator();
  }

  Widget _getSlidableWithLists(BuildContext context, int index, Axis direction) {
    final Tarefa item = tarefas[index];
    return Slidable(
      key: Key(item.id.toString()),
      controller: slidableController,
      direction: direction,
      actionPane: SlidableBehindActionPane(),
      actionExtentRatio: 0.25,
      child: direction == Axis.horizontal
          ? VerticalListItem(tarefas[index])
          : HorizontalListItem(tarefas[index]),
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: item.dataConclusao != "" ? 'reabrir' : 'Concluir',
          color: item.dataConclusao != "" ? Colors.purple : Colors.red,
          icon: item.dataConclusao != ""
              ? Icons.check_circle_rounded
              : Icons.error,
          onTap: () async {

            bool taf = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return alertaPadrao(context: context, 
                description: 
                item.dataConclusao == "" ? "Deseja concluir esta tarefa?": "Deseja reabrir esta tarefa?");
              },
            );
            
            if(taf){
            setState(() {
              item.dataConclusao =
                  item.dataConclusao != "" ? '' : DateFormat('dd/MM/yyyy').format(DateTime.parse(DateTime.now().toString()));

            });
            await dataBase.updateTarefa(item);
          }},

          closeOnTap: true,
        ),
        IconSlideAction(
          caption: 'Visualizar',
          color: Colors.purple[600],
          icon: Icons.remove_red_eye_sharp,
          onTap: () => Get.off(TarefaDetalhes(
            usuario: usuario,
            tarefa: item,
            visualizar: true,
          )),
          closeOnTap: false,
        ),
        IconSlideAction(
          caption: 'Editar',
          color: Colors.purple[700],
          icon: Icons.edit,
          onTap: () => Get.off(TarefaDetalhes(
            usuario: usuario,
            tarefa: item,
          )),
          closeOnTap: false,
        ),
        IconSlideAction(
          caption: 'Excluir',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () async {

            bool delete = await showDialog(
              context: context,
              builder: (BuildContext context) {
                return alertaPadrao(context: context, description: "Deseja excluir esta tarefa?");
              },
            );
            
            if(delete){
            await dataBase.deleteTarefa(item.id);
            setState(() {
              tarefas.removeAt(index);
            });
            }

          },
        ),
      ],
    );
  }
}

class HorizontalListItem extends StatelessWidget {
  HorizontalListItem(this.item);
  final Tarefa item;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: 160.0,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.error),
              foregroundColor: Colors.white,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                item.titulo,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class VerticalListItem extends StatelessWidget {
  VerticalListItem(this.item);
  final Tarefa item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>  Slidable.of(context)?.open(),
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor:
                item.dataConclusao != "" ? Colors.blue : Colors.red,
            child: item.dataConclusao != ""
                ? Icon(Icons.check_circle_rounded)
                : Icon(Icons.error),
            foregroundColor: Colors.white,
          ),
          title: Text(item?.titulo ?? ""),
          subtitle: Text(item.dataConclusao != ""
              ? "Data de entrega: ${item.dataEntrega} \nData de conclusão: ${item.dataConclusao}"
              : "Data de entrega: ${item.dataEntrega}"),
        ),
      ),
    );
  }
}