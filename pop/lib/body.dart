import 'package:flutter/material.dart';
import 'nouvelle_page.dart';

class Body extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _BodyState();
  }
}


class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Center(
      child: new RaisedButton(
          color: Colors.teal,
          textColor: Colors.white,
          child: new Text('Appuyez moi',
            style: new TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 20.0
            ),
          ),
          onPressed: alerte,
      ),
    );
  }

  void snack(){
    SnackBar snackBar = new SnackBar(
        content: new Text('Je suis un snackbar',textScaleFactor: 2.0,),
        duration: new Duration(seconds: 5),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  Future<Null> alerte() async {
      return showDialog(context: context,
            barrierDismissible: false,
            builder: (BuildContext context){
                return new AlertDialog(
                  title: new Text('Ceci est une alerte'),
                  content: new Text('Voulez vous continuer'),
                  contentPadding: EdgeInsets.all(5.0),
                  actions: <Widget>[
                    new FlatButton(
                        onPressed:(){
                          print("Abort");
                          Navigator.pop(context);
                          },
                        child: new Text('Annuler',style: new TextStyle(color: Colors.red),),
                    ),
                    new FlatButton(onPressed:(){
                      print('continuez');
                      Navigator.pop(context);
                     } ,
                     child: new Text('Continuez',style: new TextStyle(color: Colors.blue),),
                    ),
                  ],
                );
            }
      );
  }
  Future<Null> dialog(String title , String desc) async {
    return showDialog(context: context,
        barrierDismissible: true,
        builder: (BuildContext context){
          return new SimpleDialog(
            title: new Text(title,textScaleFactor: 1.8),
            contentPadding: EdgeInsets.all(10.0),
            children: <Widget>[
              new Text(desc),
              new Container(height: 20.0,),
              new RaisedButton(
                color: Colors.teal,
                textColor: Colors.white,
                child: new Text('OK'),
                onPressed: (){
              print('Appuye');
              Navigator.pop(context);
             }

              )
            ],
          );
        }
    );
  }

  void versNouvellePage(){
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
      return new NouvellePage('La seconde page');
    }));
  }

}