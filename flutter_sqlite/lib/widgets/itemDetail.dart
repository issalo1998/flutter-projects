import 'package:flutter/material.dart';
import 'package:flutter_sqlite/models/item.dart';

class ItemDetail extends StatefulWidget{

  Item item;

  ItemDetail(Item item){
    this.item = item;
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new _ItemDetailState();
  }

}


class _ItemDetailState extends State<ItemDetail> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.item.nom),
      ),
    );
  }


}