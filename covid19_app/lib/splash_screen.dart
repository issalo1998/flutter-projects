import 'package:covid_19/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:shimmer/shimmer.dart';



class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();

    _mockCheckForSession().then(
        (status) => _navigateToHome()
    );
  }


  Future<bool> _mockCheckForSession() async {
    await Future.delayed(Duration(milliseconds: 6000), () {});

    return true;
  }

  void _navigateToHome(){
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (BuildContext context) => MyHomePage()
        )
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration:new BoxDecoration(
                image: new DecorationImage(
                    image: new AssetImage('assets/images/covid.jpg') , fit: BoxFit.fitHeight
                )
            ),
            ),
            Shimmer.fromColors(
              period: Duration(milliseconds: 500),
              baseColor:  Colors.blue[900],
              highlightColor: Colors.blue[50],
              child: Container(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  "LÔ - DEV ",
                  style:GoogleFonts.pacifico(fontSize:50.0,fontStyle: FontStyle.italic)
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


}