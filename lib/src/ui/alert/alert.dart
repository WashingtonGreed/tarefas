import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialog extends StatelessWidget {
  final String title, description, buttonText;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context));
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
            top: Consts.avatarRadius + Consts.padding,
            bottom: Consts.padding,
            left: Consts.padding,
            right: Consts.padding,
          ),
          margin: EdgeInsets.only(top: Consts.avatarRadius),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(Consts.padding),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                title,
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                description,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    buttonText,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}

alertaPadrao({@required BuildContext context ,String title = "Aviso", @required String description}) {
  Widget cancelaButton = FlatButton(
    child: Text("Cancelar"),
    onPressed: () {
            Navigator.pop(context,false);
    },
  );
  Widget continuaButton = FlatButton(
    child: Text("Continuar"),
    onPressed: () {
      Navigator.pop(context,true);
    },
  );
  //configura o AlertDialog
  return AlertDialog(
    title: Text(title),
    content: Text(description),
    actions: [
      cancelaButton,
      continuaButton,
    ],
  );
}

alertLoading({@required String texto, Widget icon}) {
  AlertDialog alert = AlertDialog(
      content: Container(
    height: 80,
    child: Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: icon != null ? icon : CircularProgressIndicator()),
            Container(padding: EdgeInsets.all(5), child: Text(texto)),
          ]),
    ),
  ));
  Get.dialog(
    alert,
    barrierDismissible: false,
  );
}
