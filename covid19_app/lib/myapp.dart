
import 'package:covid_19/splash_screen.dart';

import 'package:flutter/material.dart';

import 'constant.dart';


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Covid19',
        theme: ThemeData(

            scaffoldBackgroundColor: kBackgroundColor,
            fontFamily: "Poppins",
            textTheme: TextTheme(

            )
        ),
        home: SplashScreen()
    );
  }
}