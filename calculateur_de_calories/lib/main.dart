
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Calculateur de calories'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  double poids;
  bool genre = false;
  double age;
  double taille = 170.0;
  int radioSelectionne;

  Map mapActivite = {
    0: "Faible",
    1: "Modere",
    2: "Forte",
  };

  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS){
      print('Nous sommes dans ios');
    }else{
      print('nous sommes dans android');
    }
    return new GestureDetector(
      onTap:((){
        FocusScope.of(context).requestFocus(new FocusNode());
      }),
      child:(Platform.isIOS) ?

          new CupertinoPageScaffold(
            navigationBar: new CupertinoNavigationBar(
              backgroundColor: setColor(),
              middle: texteAvecStyle(widget.title),
            ),
            child: body(),
          )
          : new Scaffold(
              appBar: AppBar(
                backgroundColor: setColor(),
                title: Text(widget.title),
                centerTitle: true,
              ),
              body: body(),
      )
      );

  }



  Widget body(){
    return new SingleChildScrollView(
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          padding(),
          texteAvecStyle("Remplissez tous les champs pour obtenir votre besoin journalière en calorie"),
          padding(),
          new Card(
            elevation: 10.0,
            child: new Column(
              children: <Widget>[
                padding(),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    texteAvecStyle("Femme",color: Colors.pink),
                    switchSelonPlateform(),
                    texteAvecStyle("Homme",color: Colors.blue)
                  ],
                ),
                padding(),
                ageButton(),
                padding(),
                texteAvecStyle("Votre taille est de : ${taille.toInt()} cm",color: setColor()),
                padding(),
                sliderSelonPlateform(),
                padding(),
                new TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (String string){
                    poids = double.tryParse(string);
                  },
                  decoration: new InputDecoration(
                      labelText: "Entrez votre poids en kilos"
                  ),
                ),
                padding(),
                texteAvecStyle("Quelle est votre activité sportive",color: setColor()),
                padding(),
                rowRadio(),
                padding(),
              ],
            ),
          ),
          padding(),
          padding(),
          calculButton()
        ],
      ),
    );
  }


  Widget sliderSelonPlateform(){
    if(Platform.isIOS){
      return new CupertinoSlider(
          activeColor: setColor(),
          value:taille ,
          min:100.0,
          max:215.0,
          onChanged: (double d){
            setState(() {
              taille=d;
            });
          }
      );
    }else{
      return new Slider(
          activeColor: setColor(),
          value:taille ,
          min:100.0,
          max:215.0,
          onChanged: (double d){
            setState(() {
              taille=d;
            });
          }
      );
    }
  }


  Widget calculButton(){
    if(Platform.isIOS){
      return new CupertinoButton(
          color: setColor(),
          child: texteAvecStyle("Calculer",color: Colors.white),
          onPressed: calculNombreCalories
      );
    }else{
      return new RaisedButton(
          color: setColor(),
          child: texteAvecStyle("Calculer",color: Colors.white),
          onPressed: calculNombreCalories
      );
    }
  }

  Widget ageButton(){
    if(Platform.isIOS){
      return new CupertinoButton(
          color: setColor(),
          child: texteAvecStyle((age==null) ? "Entrez votre âge" : "Votre age est ${age.toInt()}",color: Colors.white),
          onPressed: montrerPicker);
    }else{
      return new RaisedButton(
          color: setColor(),
          child: texteAvecStyle((age==null) ? "Entrez votre âge" : "Votre age est ${age.toInt()}",color: Colors.white),
          onPressed: montrerPicker);
    }
  }


  Widget switchSelonPlateform(){
    if(Platform.isIOS){
      return new CupertinoSwitch(
        activeColor: Colors.blue,
          value: genre,
          onChanged: (bool b){
            setState(() {
              genre=b;
            });
          }
      );
    }else{
      return  new Switch(
          value: genre,
          inactiveTrackColor: Colors.pink,
          activeColor: Colors.blue,
          onChanged:(bool b){
            setState(() {
              genre=b;
            });
          }
      );
    }
  }


  Widget texteAvecStyle(String data , {color: Colors.black , fontSize : 15.0}){

    if(Platform.isIOS){
      return new DefaultTextStyle(
          style: new TextStyle(
            color: color,
            fontSize: fontSize
          ),
          child: new Text(
              data,
              textAlign: TextAlign.center,
          )
      );
    }else{
      return new Text(
        data,
        textAlign: TextAlign.center,
        style: new TextStyle(
            color: color,
            fontSize: fontSize
        ),
      );
    }

  }

  Color setColor(){
    if(genre){
      return Colors.blue;
    }else{
      return Colors.pink;
    }
  }

  Row rowRadio(){

    List<Widget> l = [];
    mapActivite.forEach((key,value){
      Column colonne = new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Radio(value: key,
              activeColor: setColor(),
              groupValue: radioSelectionne,
              onChanged: (Object i){
                  setState(() {
                    radioSelectionne=i;
                  });
              }
          ),
          texteAvecStyle(value,color:setColor())
        ],
      );
      l.add(colonne);
    });

    return new Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: l,
    );
  }

  Padding padding(){
    return new Padding(padding: EdgeInsets.only(top:20));
  }

  Future <Null> montrerPicker() async {
      DateTime choix = await showDatePicker(
          initialDatePickerMode: DatePickerMode.year,
          context: context,
          initialDate: new DateTime.now(),
          firstDate: new DateTime(1900),
          lastDate: new DateTime.now()
      );

      if(choix!=null){
        var difference = new DateTime.now().difference(choix);
        var jours = difference.inDays;
        var ans = (jours/365);
        setState(() {
          age = ans;
        });
      }
  }


  calculNombreCalories(){
    if(age!=null && poids!=null && radioSelectionne!=null){

    }else{
      alerte();
    }
  }

  Future<Null> alerte() async{
    return showDialog(
        context: context,
      barrierDismissible: false,
      builder: (BuildContext buildcontext){
          if(Platform.isIOS){
            return new CupertinoAlertDialog(
              title:texteAvecStyle("Erreur"),
              content: texteAvecStyle("Tous les champs ne sont pas remplies"),
                actions:<Widget>[
                  new CupertinoButton(
                      color:Colors.white,
                      onPressed: (()=>Navigator.pop(buildcontext)),
                      child: texteAvecStyle("OK",color: Colors.red)
                  )
                ]
            );
          }
          return new AlertDialog(
            title:texteAvecStyle("Erreur"),
            content: texteAvecStyle("Tous les champs ne sont pas remplies"),
            actions:<Widget>[
                new FlatButton(
                    onPressed: (()=>Navigator.pop(buildcontext)),
                    child: texteAvecStyle("OK",color: Colors.red)
                )
            ]
          );
      }
    );
  }
}
