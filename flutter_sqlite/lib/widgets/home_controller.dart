import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'package:flutter_sqlite/models/item.dart';
import 'package:flutter_sqlite/widgets/donnees_vides.dart';
import 'package:flutter_sqlite/models/databaseClient.dart';
import 'itemDetail.dart';


class HomeController extends StatefulWidget {
  HomeController({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _HomeControllerState createState() => _HomeControllerState();
}

class _HomeControllerState extends State<HomeController> {


  String nouvelleListe;
  List<Item> items;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recuperer();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(

          title: Text(widget.title),
          actions: <Widget>[
            new FlatButton(onPressed: ()=>ajouter(new Item()), child: new Text("Ajouter",style: new TextStyle(color: Colors.white),))
          ],
        ),
        body: (items==null || items.length==0)
            ? new DonneesVides()
            :new ListView.builder(
              itemCount: items.length,
              itemBuilder: (context , i){
                Item item = items[i];
                return new  ListTile(
                  title: new Text(item.nom),
                  trailing: new IconButton(
                      icon: new Icon(Icons.delete),
                      onPressed: (){
                        DatabaseClient().delete(item.id, 'item').then((int){
                          print("L'int recupere est $int");
                          recuperer();
                        });
                      }),
                  leading: new IconButton(icon: new Icon(
                      Icons.edit),
                      onPressed: ()=>ajouter(item)
                  ),
                  onTap: (){
                    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext buildcontext){
                        return new ItemDetail(item);
                    }));
                  }

                );
            }
        )
    );
  }

  Future<Null> ajouter(Item item) async {
    return  showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext buildcontext){
          return new AlertDialog(
            title: new Text("Ajouter une liste de souhaits"),
            content: new TextField(
              decoration: new InputDecoration(
                  labelText: "Liste",
                  hintText: (item == null) ?"Ex: Mes prochaines jeux videos" : item.nom
              ),
              onChanged: (String str){
                nouvelleListe=str;
              },
            ),

            actions: <Widget>[
              new FlatButton(onPressed: (()=>Navigator.pop(buildcontext)), child: new Text("Annuler")),
              new FlatButton(
                  onPressed:(){
                    if(nouvelleListe!=null){

                        if(item == null){
                          Map<String , dynamic> map = {'nom' : nouvelleListe};
                          Item item = new Item();
                          item.fromMap(map);
                        }else{
                          item.nom = nouvelleListe;
                        }

                      DatabaseClient().upsertItem(item).then((i)=>recuperer());
                      nouvelleListe=null;
                    }
                    Navigator.pop(buildcontext);
                  },
                  child: new Text("Valider",style: new TextStyle(color: Colors.blue),))
            ],
          );

        }
    );
  }


  void recuperer(){
    DatabaseClient().allItems().then((items){
        setState(() {
          this.items=items;
        });
    });
  }
}
