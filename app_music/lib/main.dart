import 'dart:async';
import 'package:flutter/material.dart';
import 'musique.dart';
import 'package:audioplayer/audioplayer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Coda music',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Coda Music'),
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

  List<Musique> maListeDeMusiques = [
    new Musique('Theme Swift', 'Coda Bee', 'assets/01.jpg', 'https://codabee.com/wp-content/uploads/2018/06/un.mp3'),
    new Musique('Theme Flutter', 'Coda Bee', 'assets/02.jpg', 'https://codabee.com/wp-content/uploads/2018/06/deux.mp3')
  ];

  AudioPlayer audioPlayer;
  StreamSubscription positionSub;
  StreamSubscription stateSubscription;
  Musique MaMusiqueActuelle;
  Duration position = new Duration(seconds: 0) ;
  Duration duree = new Duration(seconds:10);
  PlayerState statut = PlayerState.stopped;
  int index = 0 ;

  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    MaMusiqueActuelle=maListeDeMusiques[index];
    configurationAudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Card(
              elevation: 9.0,
              child: new Container(
                width: MediaQuery.of(context).size.height/2.5,
                child: new Image.asset(MaMusiqueActuelle.imagePath),
              ),
            ),
            textAvecStyle(MaMusiqueActuelle.titre, 1.5),
            textAvecStyle(MaMusiqueActuelle.artiste, 1.0),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                bouton(Icons.fast_rewind, 30.0, ActionMusic.rewind),
                bouton((statut == PlayerState.playing) ? Icons.pause : Icons.play_arrow, 45.0,(statut==PlayerState.playing) ? ActionMusic.pause : ActionMusic.play),
                bouton(Icons.fast_forward, 30.0, ActionMusic.forward)
              ],
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                textAvecStyle(fromDuration(position), 0.8),
                textAvecStyle(fromDuration(duree), 0.8),
              ],
            ),
            new Slider(
                value: position.inSeconds.toDouble(),
                min: 0.0,
                max:30.0,
                inactiveColor: Colors.white,
                activeColor: Colors.red,
                onChanged:(double d){
                 setState(() {
                   audioPlayer.seek(d);
                 });
                }
            )
          ],
        ),
      ),

    );
  }

  Text textAvecStyle(String data , double scale){
      return Text(
        data,
        textScaleFactor: scale,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontStyle: FontStyle.italic
        ),
      );
  }

  Future play() async {
    await audioPlayer.play(MaMusiqueActuelle.urlSong);
    setState(() {
      statut = PlayerState.playing;
    });
  }

  Future pause() async {
    await audioPlayer.pause();
    setState(() {
      statut = PlayerState.paused;
    });
  }

  void forward (){
    if(index==maListeDeMusiques.length-1){
      index=0;
    }else{
      index++;
    }
    MaMusiqueActuelle = maListeDeMusiques[index];
    audioPlayer.stop();
    configurationAudioPlayer();
    play();
  }

  void rewind(){
    if(position > Duration(seconds : 3)){
      audioPlayer.seek(0.0);
    }else{
      if(index==0){
        index = maListeDeMusiques.length-1;
      }else{
        index--;
      }
      MaMusiqueActuelle=maListeDeMusiques[index];
      audioPlayer.stop();
      configurationAudioPlayer();
      play();
    }
  }

  void configurationAudioPlayer (){
    audioPlayer = new AudioPlayer();
    positionSub = audioPlayer.onAudioPositionChanged.listen(
        (pos) => setState(() => position=pos)
    );

    stateSubscription = audioPlayer.onPlayerStateChanged.listen((state){
      if(state == AudioPlayerState.PLAYING){
        setState(() {
          duree = audioPlayer.duration;
        });
      }else if(state == AudioPlayerState.STOPPED) {
          setState(() {
              statut = PlayerState.stopped;
          });
      }
    },onError: (message){
      print('erreur: $message');
      setState(() {
        statut = PlayerState.stopped;
        duree = new Duration(seconds: 0);
        position=new Duration(seconds: 0);
      });
    }

    );

  }

  String fromDuration(Duration duree){
    print(duree);
    return duree.toString().split('.').first;
  }



  IconButton bouton(IconData icone , double taille , ActionMusic action){
    return new IconButton(icon:new Icon(icone),
        iconSize:taille,
        color:Colors.white,
        onPressed: (){
            switch(action){
              case ActionMusic.play:
                play();
                print('play');
              break;
              case ActionMusic.forward:
                print('forward');
                forward();
                break;
              case ActionMusic.pause:
                pause();
                print('pause');
                break;
              case ActionMusic.rewind:
                print('rewind');
                rewind();
                break;
              }
        }
    );
  }

}

enum ActionMusic {
  play,pause,rewind,forward
}

enum PlayerState {
  playing ,
  stopped,
  paused
}
