
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main(){
  runApp( new MyApp());
}

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
      home: MyHomePage(title: 'Les scrollables'),
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


  
  List<Activite> mesActivites  = [
    new Activite("Velo", Icons.directions_bike),
    new Activite("Peinture", Icons.palette),
    new Activite("Golf", Icons.golf_course),
    new Activite("Arcade", Icons.gamepad),
    new Activite("Bricolage", Icons.build),
    new Activite("Velo", Icons.directions_bike),
    new Activite("Peinture", Icons.palette),
    new Activite("Golf", Icons.golf_course),
    new Activite("Arcade", Icons.gamepad),
    new Activite("Bricolage", Icons.build),
    new Activite("Velo", Icons.directions_bike),
    new Activite("Peinture", Icons.palette),
    new Activite("Golf", Icons.golf_course),
    new Activite("Arcade", Icons.gamepad),
    new Activite("Bricolage", Icons.build),
  ];

  Orientation orientation;
  
  
  @override
  Widget build(BuildContext context) {

    orientation = MediaQuery.of(context).orientation;
    print(orientation);


    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
          child:(orientation==Orientation.portrait) ? liste() : grille()

      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }





  Widget liste(){
    return  new ListView.builder(
        itemCount: mesActivites.length,
        itemBuilder: (context,i){
          Activite activite = mesActivites[i];
          return new Dismissible(
            key: new Key(activite.nom),
            child: new Container(
              padding:EdgeInsets.all(5.0),
              height: 125.0,
              child: new Card(
                elevation: 7.5,
                child: new InkWell(
                  onTap: (()=>print("Tape")),
                  child:new Container(
                      height: 100.0,
                      child:new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          new Icon(activite.icon,color:Colors.teal,size: 75.0,),
                          new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              new Text("Activite:",style:new TextStyle(color: Colors.teal,fontSize: 20.0)),
                              new Text(activite.nom,style: new TextStyle(color: Colors.teal[700],fontSize: 30.0))
                            ],
                          )
                        ],
                      )
                  ),
                ),
              ),
            ),
            background: new Container(
              padding: EdgeInsets.only(right: 20.0),
              color: Colors.red,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  new Text("Supprimer", style:new TextStyle(color:Colors.white)),
                  new Icon(Icons.delete,color: Colors.white,)
                ],
              ),
            ),
            onDismissed: (direction){
              setState(() {
                print(activite.nom);
                mesActivites.removeAt(i);
              });
            },

          );
        }
    );
  }

  Widget grille(){
    return new GridView.builder(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4),
      itemCount: mesActivites.length,
      itemBuilder: (context, i) {
        return new Container(
          margin: EdgeInsets.all(2.5),
          child: new Card(
            elevation: 10.0,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                new Text('Activite:',
                  style: new TextStyle(color: Colors.teal, fontSize: 15.0),),
                new Icon(
                  mesActivites[i].icon, color: Colors.teal, size: 45.0,),
                new Text(mesActivites[i].nom, style: new TextStyle(
                    color: Colors.teal,
                    fontSize: 20.0,
                    fontStyle: FontStyle.italic)),
              ],
            ),
          ),
        );
      },
    );
  }


}





class Activite {
  String nom;
  IconData icon;

  Activite( String nom, IconData icon){
    this.nom = nom;
    this.icon=icon;
  }
}


