import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart';
import 'package:geocoder/geocoder.dart';
import 'package:http/http.dart' as http;
import 'temps.dart';
import 'dart:convert';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Location location = new Location();
  LocationData position;
  try {
    position = await location.getLocation();
  } on PlatformException catch (e) {
    print("Erreur : $e");
  }

  if (position != null) {
    final latitude = position.latitude;
    final longitude = position.longitude;
    final Coordinates coordinates = new Coordinates(latitude, longitude);
    final ville = await Geocoder.local.findAddressesFromCoordinates(coordinates);

    if(ville!=null){
      print(ville.first.locality);
      runApp(MyApp(ville.first.locality));
    }
  }
}

class MyApp extends StatelessWidget {

  String ville;

  MyApp(String ville){
    this.ville = ville;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(ville , title: 'Coda Meteo'),
    );
  }
}

class MyHomePage extends StatefulWidget {

  MyHomePage(String ville , {Key key, this.title}) : super(key: key){
    this.villeDeLutilisateur=ville;
  }


  final String title;
  String villeDeLutilisateur;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  List<String> villes = [];
  String villechoisie;
  String key = "villes";
  Temps tempsActuel;

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    obtenir();
    appelApi();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      drawer: drawer(),
      body: (tempsActuel==null) ? Center(
        child: new Text((villechoisie==null) ? widget.villeDeLutilisateur : villechoisie),
      ) : new Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration:new BoxDecoration(
            image: new DecorationImage(
                image: new AssetImage(assetName()) , fit: BoxFit.cover
            )
          ),
          padding:EdgeInsets.all(20.0),
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              textAvecStyle(tempsActuel.name , fontSize: 30.0),
              new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  textAvecStyle("${tempsActuel.temp.toInt()}C",fontSize: 45.0),
                  new Image.asset(tempsActuel.icon)
                ],
              ),
              textAvecStyle(tempsActuel.main,fontSize: 30.0),
              textAvecStyle(tempsActuel.description,fontSize: 25.0)
            ],
          )
      ) ,
    );
  }

  String assetName(){
    if(tempsActuel.icon.contains("04")){
      print(tempsActuel.icon);
      return "assets/n.jpg";
    }else if(tempsActuel.icon.contains("01") || tempsActuel.icon.contains("02") || tempsActuel.icon.contains("03")){
      return "assets/d1.jpg";
    }else{
      return "assets/d2.jpg";
    }
  }

  Text textAvecStyle(String data , {color:Colors.white , fontSize: 18.0,fontStyle:FontStyle.italic,textAlign:TextAlign.center}){
    return new Text(
        data,
        textAlign: textAlign,
        style:new TextStyle(
            color: color,
            fontStyle: fontStyle,
            fontSize: fontSize
        )
    );
  }


  Future<Null> ajoutVille() async {
    return showDialog(
        context: context ,
        barrierDismissible: true,
        builder: (BuildContext buildcontext){
          return new SimpleDialog(
            contentPadding: EdgeInsets.all(20.0),
            title: textAvecStyle("Ajoutez une ville",fontSize: 22.0,color: Colors.blue),
            children: <Widget>[
              new TextField(
                decoration: new InputDecoration(labelText:  "Ville : "),
                onSubmitted: (String str){
                  ajouter(str);
                  Navigator.pop(buildcontext);
                },
              )
            ],
          );
        }
    );
  }

  void obtenir() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    List<String> liste = await sharedPreferences.getStringList(key);
    if(liste !=null){
      setState(() {
        villes = liste;
      });
    }
  }

  void ajouter (String str) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    villes.add(str);
    await sharedPreferences.setStringList(key, villes);
    obtenir();
  }

  void supprimer(String str) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    villes.remove(str);
    await sharedPreferences.setStringList(key, villes);
    obtenir();
  }


  void appelApi() async{
    String str;
    if(villechoisie==null){
      str=widget.villeDeLutilisateur;
    }else{
      str=villechoisie;
    }
    List<Address> coord = await Geocoder.local.findAddressesFromQuery(str);
    if(coord!=null){
      final  lat = coord.first.coordinates.latitude;
      final long = coord.first.coordinates.longitude;
      String lang = Localizations.localeOf(context).languageCode;
      final key = "32b46ead35d655aae64eff0ffbc194c5";

      String urlApi = "http://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&units=metric&lang=fr&APPID=$key";

      final reponse = await http.get(urlApi);
      if(reponse.statusCode==200){
        Temps temps = new Temps();
        Map map = json.decode(reponse.body);
        temps.fromJson(map);
         setState(() {
           tempsActuel = temps;
         });
      }
    }
  }

  Widget drawer (){
    return new Drawer(
        child:new Container(
            child: new ListView.builder(
                itemCount: villes.length+2,
                itemBuilder: (context, i){
                  if(i==0){
                    return DrawerHeader(
                      child: new Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          textAvecStyle("Mes villes",fontSize: 20.0),
                          new RaisedButton(
                              color: Colors.white,
                              elevation: 8.0,
                              child: textAvecStyle("Ajouter une ville",color: Colors.blue),
                              onPressed: ajoutVille
                          )
                        ],
                      ),
                    );
                  }else if(i==1){
                    return new ListTile(
                      title: textAvecStyle(widget.villeDeLutilisateur),
                      onTap: (){
                        villechoisie=null;
                        appelApi();
                        Navigator.pop(context);
                      },
                    );
                  }
                  else{
                    String ville = villes[i-2];
                    return new ListTile(
                        title: textAvecStyle(ville),
                        trailing: new IconButton(
                            icon: new Icon(Icons.delete,color: Colors.white),
                            onPressed: (()=>supprimer(ville))
                        ),
                        onTap:(){
                          setState(() {
                            villechoisie=ville;
                            appelApi();
                            Navigator.pop(context);
                          });
                        }
                    );
                  }

                }),
            color:Colors.blue
        )

    );
  }

}
