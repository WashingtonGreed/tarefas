import 'package:cpfcnpj/cpfcnpj.dart';
import 'package:flutter/material.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:tarefas/src/database/data_base.dart';
import 'package:tarefas/src/model/cep.dart';
import 'package:tarefas/src/model/usuario.dart';
import 'package:tarefas/src/provider/usuario.provider.dart';
import 'package:tarefas/src/screens/index.dart';
import 'package:tarefas/src/screens/login/login.dart';
import 'package:tarefas/src/services/cep.service.dart';
import 'package:tarefas/src/ui/alert/alert.dart';
import 'package:tarefas/src/ui/button/button.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

var _nomeController = TextEditingController();
var _emailController = TextEditingController();
var _dataNascimentoController = TextEditingController();
var _estadoController = TextEditingController();
var _cidadeController = TextEditingController();
var _bairroController = TextEditingController();
var _ruaController = TextEditingController();
var _senhaController = TextEditingController();
var _numeroController = TextEditingController();
var _cpfController = MaskedTextController(mask: '000.000.000-00');
var _cepController = MaskedTextController(mask: '00000-000');
final df = new DateFormat('dd/MM/yyyy');
GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

class _SignupState extends State<Signup> {
  @override
  void initState() {
    super.initState();

    _emailController.text = "";
    _dataNascimentoController.text = "";
    _cepController.text = "";
    _numeroController.text = "";
    _nomeController.text = "";
    _cpfController.text = "";
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () => Get.off(Login()),
        child: new Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Get.off(Login())),
            title: Text("Novo Usuário"),
          ),
          backgroundColor: Colors.white,
          bottomSheet: bottomButton(context, _formKey, "CRIAR", _salvarUsuario),
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
                    decoration:
                        InputDecoration(labelText: "Nome", hintText: "Nome"),
                    controller: _nomeController,
                    validator: (value) {
                      return validadorNome(value, 'Informe seu nome');
                    }),
                SizedBox(height: 20.0),
                TextFormField(
                    decoration:
                        InputDecoration(labelText: "Email", hintText: "Email"),
                    controller: _emailController,
                    validator: (value) {
                      return validadorEmail(value, 'Informe um Email valido');
                    }),
                SizedBox(height: 20.0),
                TextFormField(
                    decoration:
                        InputDecoration(labelText: "Data", hintText: "Data"),
                    readOnly: true,
                    controller: _dataNascimentoController,
                    onTap: () async {
                      DateTime date = await showDatePicker(
                          context: context,
                          initialDate:
                              DateTime.now().add(Duration(days: -4383)),
                          firstDate: DateTime(1920),
                          lastDate: DateTime.now().add(Duration(days: 0)));
                      if (date != null) {
                        final df = new DateFormat('dd/MM/yyyy');
                        _dataNascimentoController.text = df.format(date);
                      }
                    },
                    validator: (value) {
                      return validaData(value,
                          'Apenas usuários maiores de 12 anos podem se cadastrar');
                    }),
                SizedBox(height: 20.0),
                TextFormField(
                    decoration:
                        InputDecoration(labelText: "CPF", hintText: "CPF"),
                    controller: _cpfController,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      return validadorCpf(value, 'Informe um CPF valido');
                    }),
                SizedBox(height: 20.0),
                TextFormField(
                    decoration:
                        InputDecoration(labelText: "CEP", hintText: "CEP"),
                    controller: _cepController,
                    onChanged: (value) {
                      return onChangedCep(value);
                    },
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      return validadorCep(value, 'Informe um CEP valido');
                    }),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: "Estado", hintText: "Estado"),
                  controller: _estadoController,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: "Cidade", hintText: "Cidade"),
                  controller: _cidadeController,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: "Bairro", hintText: "Bairro"),
                  controller: _bairroController,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: "Rua", hintText: "Rua"),
                  controller: _ruaController,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: "Numero", hintText: "Numero"),
                  controller: _numeroController,
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  decoration:
                      InputDecoration(labelText: "Senha", hintText: "Senha"),
                  controller: _senhaController,
                  obscureText: true,
                  validator: (value) {
                    return validadorSenha(
                        value, 'Informe uma senha com no minimo 6 digitos');
                  },
                ),
                SizedBox(height: 50.0),
              ],
            ),
          ),
        ));
  }

  void _salvarUsuario() async {
  DataBase dataBase = new DataBase();

  Usuario usuario = new Usuario();
  usuario.nome = _nomeController.text;
  usuario.email = _emailController.text.toLowerCase();
  usuario.dataNascimento = _dataNascimentoController.text;
  usuario.estado = _estadoController.text;
  usuario.cidade = _cidadeController.text;
  usuario.bairro = _bairroController.text;
  usuario.rua = _ruaController.text;
  usuario.senha = _senhaController.text;
  usuario.numero = _numeroController.text;
  usuario.cpf = _cpfController.text;
  usuario.cep = _cepController.text;

  alertLoading(texto: "Validando dados");
  await Future.delayed(Duration(seconds: 1));

  dataBase.saveUsuario(usuario).then((value) async {
    Navigator.pop(context);
    
    if (value["error"] == null) {
      usuario.id = value["id"];
      await saveUsuario(usuario);
      Get.off(Index());
    } else {
      Get.dialog(CustomDialog(
        title: "Aviso",
        description: value["error"].first,
        buttonText: "Ok",
      ));
    }
  });
}

void onChangedCep(String value) async {
  if (value.length >= 9) {
    alertLoading(texto: "Buscando Endereço");
    
    Cep cep = await getCep(value);
    print(cep);
    if(cep != null){
    _estadoController.text = cep.uf;
    _cidadeController.text = cep.localidade;
    _bairroController.text = cep.bairro;
    _ruaController.text = cep.logradouro;
    }
    await Future.delayed(Duration(seconds: 1));

    Navigator.pop(context);
    
  }
}


}

String validaData(String value, String textValidator) {
  int idade = 0;

  if (value.trim().isNotEmpty) {
    DateTime dataNascimento = DateFormat("dd/MM/yyyy").parse(value);
    DateTime dataAtual = DateTime.now();
    idade = dataAtual.year - dataNascimento.year;
    int mesAtual = dataAtual.month;
    int mesNascimento = dataNascimento.month;
    if (mesNascimento > mesAtual) {
      idade--;
    } else if (mesAtual == mesNascimento) {
      int diaAtual = dataAtual.day;
      int diaNascimento = dataNascimento.day;
      if (diaNascimento > diaAtual) {
        idade--;
      }
    }
  }
  return idade < 12 ? textValidator : null;
}

String validadorNome(String value, String textValidator) {
  if (value.trim().isEmpty || value.length < 3) {
    return textValidator;
  }
  return null;
}


String validadorSenha(String value, String textValidator) {
  if (value.trim().isEmpty || value.length < 6) {
    return textValidator;
  }
  return null;
}

String validadorCpf(String value, String textValidator) {
  if (value.isNotEmpty && value.length < 14 && !CPF.isValid(value)) {
    return textValidator;
  } else {
    return null;
  }
}

String validadorCep(String value, String textValidator) {
  if (value.isNotEmpty && value.length < 9) {
    return textValidator;
  } else {
    return null;
  }
}

String validadorEmail(String value, String textValidator) {
  {
    bool emailValido = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$')
        .hasMatch(value);
    if (!emailValido) {
      return "Insira um email valido";
    }
    return null;
  }
}


