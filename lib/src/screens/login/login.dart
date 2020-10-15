import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarefas/src/database/data_base.dart';
import 'package:tarefas/src/model/usuario.dart';
import 'package:tarefas/src/provider/usuario.provider.dart';
import 'package:tarefas/src/screens/index.dart';
import 'package:tarefas/src/screens/login/signup.dart';
import 'package:tarefas/src/style/theme.dart' as themme;
import 'package:tarefas/src/ui/alert/alert.dart';
import 'package:tarefas/src/ui/button/button.dart';
import 'package:tarefas/src/ui/input/input.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

TextEditingController emailController = TextEditingController();
TextEditingController senhaController = TextEditingController();

class _LoginState extends State<Login> {

@override
 void dispose() {
   emailController.clear();
   senhaController.clear();
   super.dispose();
 }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final formKey = new GlobalKey<FormState>();
  bool obscureSenha = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: themme.Colors.corPrincipal,
      body: SingleChildScrollView(
        padding:
            EdgeInsets.only(top: 50.0, left: 50.0, right: 50.0, bottom: 30.0),
        child: Form(
          key: formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Image.asset(themme.ImagesApp.logo, scale: 1.0),
                textFormFieldLogin(
                    'Email', 'Insira seu email', emailController),
                textFormFieldSenha(
                    'Senha', 'Insira sua Senha', senhaController),
                raiseButton(
                    context: context,
                    text: 'ENTRAR',
                    function: _signIn,
                    formkey: formKey),
                flatButton(context, 'CADASTRO', _signup),
              ]),
        ),
      ),
    );
  }

  Widget textFormFieldSenha(String labelText, String textvalidator,
      TextEditingController controller) {
    return TextFormField(
        obscureText: obscureSenha,
        cursorColor: Colors.white,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: IconButton(
            icon: Icon(
              obscureSenha ? Icons.visibility : Icons.visibility_off,
              color: Theme.of(context).primaryColorDark,
            ),
            onPressed: () {
              setState(() {
                obscureSenha = !obscureSenha;
              });
            },
          ),
          labelStyle: TextStyle(color: Colors.white, fontSize: 20.0),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
        textAlign: TextAlign.start,
        style: TextStyle(color: Colors.white, fontSize: 25.0),
        controller: controller,
        validator: (value) {
          if (value.trim().isEmpty) {
            return textvalidator;
          }
          return null;
        });
  }
}

void _signIn(BuildContext context) async {
  alertLoading(texto: "Validando dados");
  DataBase dataBase = new DataBase();
  Usuario usuario =
      await dataBase.getLogin(emailController.text, senhaController.text);
  await Future.delayed(Duration(seconds: 1));
  Navigator.pop(context);

  if (usuario != null) {
    await saveUsuario(usuario);
    Get.to(Index());
  } else {
    showDialog(
        context: context,
        builder: (context) => CustomDialog(
              title: "Aviso",
              description: "Email/senha não correspondem!",
              buttonText: "Ok",
            ));
  }
}

void _signup(BuildContext context) async {
  Get.to(Signup());
}
