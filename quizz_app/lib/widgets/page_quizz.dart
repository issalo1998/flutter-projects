import 'package:flutter/material.dart';
import 'custom_text.dart';
import 'package:quizz_app/models/question.dart';

class PageQuizz extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _PageQuizzState();
  }

}

class _PageQuizzState extends State<PageQuizz>{


  Question question;

  List<Question> listeQuestions = [
    new Question("La devide de la Belqique est l'union et la force" ,true,"","belgique.jpg"),
    new Question("La lune va finir par tomber sur terre à cause de la gravité" ,false,"","lune.jpg"),
    new Question("La Russie est plus grande en superficie que pluton" ,true,"","russie.jpg"),
    new Question("Nyctalope est une race naine d'antilope" ,false,"","nyctalope.jpg"),
    new Question("La commodore 64 est l'ordinateur de bureau le plus vendu" ,true,"","commodore.jpg"),
    new Question("Le nom du drapeau des pirates est black skull" ,false,"Il est appelé Jolly Roger","pirate.png"),
    new Question("Haddock est le nom du chien Tintin " ,false,"","tintin.jpg"),
    new Question("La barbe des pharaons est fausse" ,true,"","pharaon.jpg"),
    new Question("Au Quebec tire toi une buche veut dire viens viens" ,true,"","buche.jpg"),
    new Question("Le module lunaire eagle ne possedait que 4Ko de ram" ,true,"","lune.jpg")
  ];

  int index = 0;
  int score = 0;

  @override

  void initState(){
    super.initState();
    question = listeQuestions[index];
  }






  @override
  Widget build(BuildContext context) {
    double taille = MediaQuery.of(context).size.width * 0.75;
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title : new CustomText("Le Quizz"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new CustomText("Question numero ${index+1}",color: Colors.grey[900]),
            new CustomText("Score : $score/$index",color: Colors.grey[900],),
            new Card(
              elevation:10.0,
                  child:new Container(
                    width:taille,
                    height: taille,
                    child:
                    new Image.asset("quizz_assets/${question.imagePath}",fit: BoxFit.cover,)
              )
            ),
            new CustomText(question.question,color: Colors.grey[900],factor: 1.3,),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                bouton(true),
                bouton(false)
              ],
            )
          ],
        ),
      ),
    );
  }

  RaisedButton bouton(bool b){
    return new RaisedButton(
      onPressed: (()=>dialog(b)),
      color: Colors.blue,
      child:new CustomText((b) ? "Vrai" : "Faux",factor: 1.25,)
    );
  }

  Future<Null> dialog(bool b) async {
    bool bonnereponse = (b==question.reponse);
    String vrai = "quizz_assets/vrai.jpg";
    String faux = "quizz_assets/faux.jpg";

    if(bonnereponse){
      score++;
    }

    return showDialog(context: context,
      barrierDismissible: false,
      builder: (BuildContext conntext){
        return new SimpleDialog(
          title:new CustomText((bonnereponse) ? " C'est gagné" : "Oups!!! c'est perdu",factor: 1.4, color: (bonnereponse) ? Colors.green : Colors.red),
          contentPadding: EdgeInsets.all(20.0),
          children: <Widget>[
            new Image.asset((bonnereponse) ? vrai : faux,fit: BoxFit.cover,),
            new Container(height: 25.0,),
            new CustomText(question.explication,factor: 1.25,color: Colors.grey[900],),
            new Container(height: 25.0,),
            new RaisedButton(onPressed: (){
              Navigator.pop(context);
              questionSuivante();
            },
            child: new CustomText("Au suivant", factor: 1.25),
            color: Colors.blue,
            )
          ],
        );
      }
    );
  }

  Future<Null> alerte() async{
    return showDialog(context: context,
        barrierDismissible: false,
        builder: (BuildContext buildContext){
          return new AlertDialog(
            title:new CustomText("C'est fini",factor: 1.4, color: Colors.blue),
            contentPadding: EdgeInsets.all(20.0),
            content: new CustomText("Votre score : $score/ $index ",color: Colors.grey[900],),
            actions: <Widget>[
                new FlatButton(onPressed: (){
                  Navigator.pop(buildContext);
                  Navigator.pop(context);
                },
                  child: new CustomText("OK",factor: 1.25,color: Colors.blue,)
                )

            ],
          );
        }
    );
  }



  void questionSuivante(){
    if(index < listeQuestions.length-1){
        index++;
        setState(() {
          question = listeQuestions[index];
        });
    }else{
      alerte();
    }
  }



}