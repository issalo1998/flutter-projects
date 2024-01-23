class Temps {

  String name;
  String main;
  String description;
  String icon;
  var temp;
  var pressure;
  var humidity;
  var temps_min;
  var temps_max;

  void fromJson(Map map){
    this.name = map["name"];

    List weather = map["weather"];
    Map mapWeather = weather[0];

    this.main=mapWeather["main"];
    this.description=mapWeather["description"];
    String monicone = mapWeather["icon"];
    this.icon="assets/${monicone.replaceAll("d", "").replaceAll("n", "")}.png";

    Map main = map["main"];
    this.temp = main["temp"];
    this.pressure=main["pressure"];
    this.temps_min=main["temps_min"];
    this.temps_max = main["temps_max"];
  }


}