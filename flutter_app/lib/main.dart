import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      title: 'Les widgets basiques',
      theme: new ThemeData(
        primarySwatch: Colors.red
      ),
      debugShowCheckedModeBanner: false,
      home: new Home() ,
    );
  }

}

class Home extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _Home();
  }

}

class _Home extends State<Home> {

  bool oui = false;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    double largeur = MediaQuery.of(context).size.width;
    return new Scaffold(
      appBar: new AppBar(
        title:new Text('Salut'),
        leading: new Icon(Icons.account_circle),
        actions: <Widget>[
          new Icon(Icons.access_alarm),
          new Icon(Icons.golf_course),
          new Icon(Icons.directions_bike),
        ],
        elevation: 10.0,
        centerTitle: true,
      ),

      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
          children: <Widget>[
            new Text('Slt les codeurs',
            style: new TextStyle(
              color:  (oui) ? Colors.grey[900]: Colors.green,
              fontSize: 30.0,
              fontStyle: FontStyle.italic
            )
            ),
            new Card(
              elevation: 20.0,
                child: new Container(
                  width: 200,
                  height: 200,
                  child: new Image.asset('images/bug.jpg',
                  fit: BoxFit.cover,
                  ),
                ),
            ),
            new IconButton(icon: new Icon(Icons.delete), onPressed:(){
              setState(() {
                oui = !oui;
              });
            }),
            new Container(
              height:largeur/5,
              color:Colors.teal,
              margin: EdgeInsets.only(left:20.0,right:20.0),
              child:new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Icon(Icons.thumb_up,
                    color: Colors.white,
                    size: largeur/10,
                  ),
                  new Icon(Icons.thumb_down,
                    color: Colors.white,
                    size: largeur/10,
                  ),
                  new Icon(Icons.palette,
                    color: Colors.white,
                    size: largeur/10,
                  )
                ],
              )
            )
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed:boutonAppuye,
        elevation:10.0,
        child:new Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

    );
  }

  boutonAppuye(){
    setState(() {
      oui = !oui;
    });
  }

}