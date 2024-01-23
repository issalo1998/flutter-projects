
import 'dart:convert';

import 'package:covid_19/constant.dart';
import 'package:covid_19/widgets/counter.dart';
import 'package:covid_19/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;



class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);



  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> listepays = [];
  String dropdownValue = 'senegal';
  Album album = new Album();
  String urlApi = "https://coronavirus-19-api.herokuapp.com/countries/senegal";
  int day;
  var year;
  var mois;
  int cas = 0;
  int todaydeaths = 0;

  @override
  void initState() {
    pays();
    appelApi();
    year=new DateTime.now().year;
    day = new DateTime.now().day;
    mois = new DateTime.now().month;
    month(mois);


  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: new Column(
        children: <Widget>[
          MyHeader(
              image: "assets/icons/Drcorona.svg",
              textTop: "Il vous suffit de",
              textBottom: " rester chez vous ",
              page:2
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.height/50),
            padding: EdgeInsets.symmetric(vertical:  MediaQuery.of(context).size.height/100,horizontal:   MediaQuery.of(context).size.height/50),
            height: MediaQuery.of(context).size.height/13,
            width: double.infinity,
            decoration:BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: Color(0xFFEE5E5E5),
                )
            ),
            child: Row(
              children: <Widget>[
                SvgPicture.asset("assets/icons/maps-and-flags.svg"),
                Expanded(
                  child: DropdownButton(
                    isExpanded: true,
                    underline: SizedBox(),
                    icon: SvgPicture.asset("assets/icons/dropdown.svg"),
                    value: dropdownValue,
                    items: listepays.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (newvalue) {
                      dropdownValue = newvalue;
                      setState(() {
                        urlApi = "https://coronavirus-19-api.herokuapp.com/countries/$newvalue";
                        appelApi();
                      });
                    },
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: MediaQuery.of(context).size.height/31),
          Padding(
            padding: EdgeInsets.symmetric(horizontal:  MediaQuery.of(context).size.height/50),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    RichText(
                      text: TextSpan(
                          children: [
                            TextSpan(
                                text: "Mise à jour \n",
                                style: kTitleTextstyle

                            ),
                            TextSpan(
                                text: "Mise à $day $mois $year",
                                style:TextStyle(
                                  color: kTextLightColor,
                                )
                            )
                          ]
                      ),
                    ),
                    Spacer(),
                    Column(
                      children: <Widget>[
                        Text(
                          "Cas  du  jour  : $cas",
                          style: TextStyle(
                              color:kPrimaryColor,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                        Text(
                          "Deces du jour : $todaydeaths",
                          style: TextStyle(
                              color:kPrimaryColor,
                              fontWeight: FontWeight.w600
                          ),
                        )
                      ],
                    )

                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height/31),
                Container(
                  padding: EdgeInsets.all(MediaQuery.of(context).size.height/100),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color:Colors.white,
                      boxShadow: [BoxShadow(
                          offset: Offset(0,4),
                          blurRadius: 40,
                          color: kShadowColor
                      )]
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Counter(
                          color:kInfectedColor,
                          title:"Infectés",
                          number:album.cases
                      ),
                      Counter(
                          color:kDeathColor,
                          title:"Morts",
                          number:album.deaths
                      ),
                      Counter(
                          color:kRecovercolor,
                          title:"Guéris",
                          number:album.recovered
                      ),
                      Counter(
                          color:kActivercolor,
                          title:"Actives",
                          number:album.active
                      )
                    ],
                  ),
                ),

                SizedBox(height: MediaQuery.of(context).size.height/50),
                Container(
                  height: MediaQuery.of(context).size.height/4,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            offset: Offset(0,10),
                            blurRadius: 30,
                            color: kShadowColor
                        )
                      ]
                  ),
                  child: Image.asset("assets/images/map.png",fit: BoxFit.cover,),
                )
              ],
            ),
          )


        ],
      ),
    );
  }


  void month(var m) {

    switch(mois){
      case 1:
        mois= "janvier";
        break;
      case 2:
        mois= "Fevrier";
        break;
      case 3:
        mois= "Mars";
        break;
      case 4:
        mois= "Avril";
        break;
      case 5:
        mois= "Mai";
        break;
      case 6:
        mois= "Juin";
        break;
      case 7:
        mois= "Juillet";
        break;
      case 8:
        mois= "Aoû";
        break;
      case 9:
        mois= "Septembre";
        break;
      case 10:
        mois= "Octobre";
        break;
      case 11:
        mois= "Novembre";
        break;
      case 12:
        mois= "Decembre";
        break;
    }

  }



  Future<void> appelApi() async {
    final response = await http.get(urlApi);
    if(response.statusCode==200){
      setState(() {
        album =  Album.fromJson(json.decode(response.body));
        cas=album.todaycases;
        todaydeaths = album.todaydeaths;
      });
    }
  }

  Future<void> pays() async {
    String urlApi = "https://coronavirus-19-api.herokuapp.com/countries";
    List<String> pays = [];
    final response = await http.get(urlApi);
    if(response.statusCode==200){
      for(int i=0 ; i<json.decode(response.body).length;i++){
        pays.add(json.decode(response.body)[i]['country'].toLowerCase());
      }
      setState(() {
        listepays=pays;
      });
    }
  }

}



class Album {
  final int cases;
  final int  deaths;
  final int  recovered;
  final int  active;
  final int  todaycases;
  final int  todaydeaths;

  Album(  {this.cases=0, this.deaths=0, this.recovered=0, this.active=0,this.todaycases=0,this.todaydeaths=0 });

  factory Album.fromJson(Map<String, dynamic> response) {
    return Album(
        cases: response['cases'],
        deaths: response['deaths'],
        recovered: response['recovered'],
        active:response['active'],
        todaycases:response['todayCases'],
        todaydeaths:response['todayDeaths']
    );
  }
}
