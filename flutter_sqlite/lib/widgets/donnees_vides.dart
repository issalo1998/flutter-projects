import 'package:flutter/material.dart';

class DonneesVides extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new Text("Aucunes Donnees n'est presente",
      textAlign: TextAlign.center,
      textScaleFactor:2.0,
      style:new TextStyle(
        color: Colors.red,
        fontStyle: FontStyle.italic
      )
    )
    );
  }


}