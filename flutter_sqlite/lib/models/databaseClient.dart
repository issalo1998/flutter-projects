import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'item.dart';

class DatabaseClient {

  Database _database ;

  Future<Database> get database async {
    if(_database != null){
      return _database;
    }else{
      _database= await create();
      return _database;
    }
  }

  Future create() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String database_directory = join(directory.path,'database.db');
    var bdd = await openDatabase(database_directory,version: 1,onCreate: _onCreate );
    return bdd;
  }

  Future _onCreate(Database db , int version) async {
    await db.execute(''' CREATE TABLE item (id INTEGER PRIMARY KEY , nom TEXT NOT NULL) ''');
  }


  // ECRITURE DE DONNEES

  Future<Item> ajoutItem(Item item) async {
    Database maDatabase = await database ;
    print(item.toMap());
    item.id = await maDatabase.insert('item', item.toMap());
    return item;
  }

  Future<int> delete( int id , String table) async {
      Database maDatabase = await database;
      return maDatabase.delete(table , where: 'id=?',whereArgs: [id]);
  }


  Future<int> updateItem(Item item) async{
    Database madatabase = await database;
    return madatabase.update('item', item.toMap(),where: 'id=?',whereArgs: [item.id]);
  }

  Future<Item> upsertItem(Item item) async {
      Database maDatabase = await database;
      if(item.id==null){
        item.id = await maDatabase.insert('item', item.toMap());
      }else{
        await maDatabase.update('item', item.toMap(),where: 'id=?',whereArgs: [item.id]);
      }
      return item;
  }

  // LECTURE DE DONNES

  Future <List<Item>> allItems() async {
    Database maDatabase = await database;
    List<Map<String, dynamic>> resultat = await maDatabase.rawQuery('SELECT * FROM item');
    List<Item> items = [];
    resultat.forEach((map){
      Item item = new Item();
      item.fromMap(map);
      items.add(item);
    });
    return items;
  }

}