import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tarefas/src/model/usuario.dart';
import 'package:tarefas/src/provider/usuario.provider.dart';
import 'package:tarefas/src/screens/index.dart';
import 'package:tarefas/src/screens/login/login.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:tarefas/src/utils/json_utils.dart';
import 'package:tarefas/main.reflectable.dart';
import 'package:tarefas/src/style/theme.dart' as themme;

void main() {
  initializeReflectable();
  JsonUtils.initialize();
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

Future<Usuario> _futureUsuario;

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    _futureUsuario = readUsuario();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: Get.key,
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('pt'),
        ],
        debugShowCheckedModeBanner: false,
        theme: themme.Theme.theme,
        title: 'Tarefas',
        home: FutureBuilder<Usuario>(
          future: _futureUsuario,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return snapshot.data != null ? Index() : Login();
            } else {
              return new Center(
                child: Image.asset(themme.ImagesApp.logo, scale: 1.0),
              );
            }
          },
        ));
  }
}
