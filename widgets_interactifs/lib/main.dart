import 'package:flutter/material.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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

  int itemSelectionne;
  bool interrupteur = false;
  double sliderDouble =  0.0;
  DateTime date ;
  TimeOfDay time;

  Map check = {
    'Carottes' : false,
    'Bananes' : false,
    'Yaourt' : false,
    'Pain' : false
  };

  List<Widget> radios(){
    List<Widget> l =[];

    for(int x=0;x<4;x++){
      Row row = new Row(
        children: <Widget>[
          new Text("Chox numero ${x+1}"),
          new Radio(
              value: x,
              groupValue: itemSelectionne,
              onChanged: (int i){
                setState(() {
                  itemSelectionne=i;
                });
              })
        ],
      );
      l.add(row);
    }

    return l;
  }

  List<Widget> checkList (){
    List<Widget> l = [];
    check.forEach((key,value){
        Row row = new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(key,style: new TextStyle(color: (value) ?  Colors.green : Colors.red,)),
            new Checkbox(
              value:(value),
              onChanged:(bool b){
                setState(() {
                  check[key] = b;
                });
              }
            )
          ],
        );
        l.add(row);
    });

    return l;
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            new Text("Aimez vous CodaBee.com"),
            new Switch(
                value: interrupteur,
                inactiveTrackColor: Colors.red,
                activeColor: Colors.green,
                onChanged: (bool bol){
                  interrupteur = bol;
                }
            ),
            new Text("Valeur du slider : $sliderDouble"),
            new Slider(
                value:sliderDouble,
                min:0.0,
                max:10.0,
              inactiveColor: Colors.red,
              activeColor: Colors.green,
              divisions: 5,
              onChanged:(double d){
                  setState(() {
                    sliderDouble = d;
                  });
              }
            ),
            new FlatButton(
                onPressed: (){
                  montrerDate();
                },
                child: new Text((date==null) ? "Appuyez moi" : date.toString())
            ),
            new FlatButton(
                onPressed: (){
                  montrerHeure();
                },
                child: new Text((time==null) ? "Appuyez moi" : time.toString())
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<Null> montrerDate() async {
      DateTime choix = await showDatePicker(
          context: context,
          initialDatePickerMode: DatePickerMode.year,
          initialDate: new DateTime.now(),
          firstDate: new DateTime(1983),
          lastDate: new DateTime(2045)
      );
      if(choix !=null){
        setState(() {
          date=choix;
        });
      }
  }

  Future<Null>  montrerHeure() async{
    TimeOfDay heure = await showTimePicker(
        context: context,
        initialTime: new TimeOfDay.now()
    );

    if(heure!=null){
      setState(() {
        time=heure;
      });
    }
  }
}
