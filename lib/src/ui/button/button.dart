import 'package:flutter/material.dart';
import 'package:tarefas/src/style/theme.dart' as themme;

Widget raiseButton({BuildContext context, String text, Icon icon,Function function, GlobalKey<FormState> formkey}) {
  return Container(
    padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
    child: Container(
      height: 50.0,
      decoration: new BoxDecoration(
        color: themme.Colors.corPrincipal,
        border: new Border.all(color: Colors.white, width: 3.0),
      ),
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            icon == null
                ? Container(
                    padding: EdgeInsets.only(
                        top: 10.0, left: 40.0, bottom: 10.0, right: 10.0),
                  )
                : Center(
                    child: Container(
                      padding: EdgeInsets.only(
                          top: 10.0, left: 10.0, bottom: 10.0, right: 10.0),
                      color: themme.Colors.corPrincipal,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          icon,
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            width: 1.0,
                            height: 20.0,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
            Container(
              width: MediaQuery.of(context).size.width * 0.5,
              child: FlatButton(
                child: Text('$text',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 15.0)),
                color: themme.Colors.corPrincipal,
                onPressed: () {
                  
                  if(formkey!=null){
                    var form = formkey.currentState;
                  if (form.validate()) {
                    function(context);
                  }
                  }else{
                    function(context);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Widget flatButton(BuildContext context, String textButton, Function function) {
  return FlatButton(
    child: Text(
      textButton,
      textAlign: TextAlign.center,
      style: themme.FontStyle.textStyle,
    ),
    onPressed: () {
      function(context);
    },
  );
}

Widget bottomButton(BuildContext context, GlobalKey<FormState> formkey, String textButton, Function function) {
  return Container(
    height: 50.0,
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Flexible(
          flex: 1,
          child: RaisedButton(
            color: themme.Colors.corPrincipal,
            onPressed: () async {
              final form = formkey.currentState;
              if (form.validate()) {
                  function();
              }
            },
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    textButton,
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
}