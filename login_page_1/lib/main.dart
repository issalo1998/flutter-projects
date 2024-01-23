import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'FormCard.dart';
import 'SocialIcon.dart';
import 'CustomIcons.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.

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

  bool  isSelected = false;




  Widget build(BuildContext context) {
    ScreenUtil.init(context,width: 750,height: 1334,allowFontScaling: true);
    return Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: true,
        body:new Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top:20.0),
                  child: new Image.asset("assets/image_01.png"),
                ),
                Expanded(
                  child: new Container(),
                ),
                Image.asset("assets/image_02.png")
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(left: 28.0,right: 28.0,top: 60.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Image.asset("assets/logo.png",
                          width: ScreenUtil().setWidth(110),
                          height: ScreenUtil().setHeight(110),
                        ),
                        Text("LOGO",style: TextStyle(
                            fontFamily: "Poppins-Bold",
                            fontSize: ScreenUtil().setSp(46),
                            letterSpacing: 0.6,
                            fontWeight: FontWeight.bold
                        ),)
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(180),
                    ),
                    FormCard(),
                    SizedBox(height: ScreenUtil().setHeight(30)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 12.0,
                            ),
                            GestureDetector(
                              onTap: radio,
                              child:radioButton(isSelected),
                            ),
                            SizedBox(width: 8.0),
                            Text("Remember Me", style: TextStyle(fontSize: 12,fontFamily: "Poppins-Medium"),)
                          ],
                        ),
                        InkWell(
                          onTap: (){
                          },
                          child: Container(
                            width: ScreenUtil().setWidth(330),
                            height: ScreenUtil().setHeight(100),
                            decoration:BoxDecoration(
                                gradient: LinearGradient(
                                    colors: [Color(0xFF17ead9),Color(0xFF6078ea)]
                                ),
                                borderRadius: BorderRadius.circular(6.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color(0xFF6078ea).withOpacity(0.3),
                                      offset: Offset(0.0,0.8),
                                      blurRadius: 8.0
                                  )
                                ]
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                child: Center(
                                    child:  Text("SIGNIN",
                                        style:TextStyle(
                                            color: Colors.white,
                                            fontFamily: "Poppins-Bold",
                                            fontSize: 18,
                                            letterSpacing: 1.0
                                        )
                                    )
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(40)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        horizontalLine(),
                        Text("Social Login",style: TextStyle(
                          fontSize: 16.0,
                          fontFamily: "Poppins-Medium"
                        )),
                        horizontalLine()
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(40)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SocialIcon(
                          colors: [
                            Color(0xFF102397),
                            Color(0xFF187adf),
                            Color(0xFF00eaf8)
                          ],
                          iconData:CustomIcons.facebook,
                        ),
                        SocialIcon(
                          colors: [
                            Color(0xFFff4f38),
                            Color(0xFFff355d)
                          ],
                          iconData: CustomIcons.googlePlus,
                          onPressed: (){

                          },
                        ),
                        SocialIcon(
                          colors: [
                            Color(0xFF17ead9),
                            Color(0xFF6078ea)
                          ],
                          iconData: CustomIcons.twitter,
                          onPressed: (){

                          },
                        ),
                        SocialIcon(
                          colors: [
                            Color(0xFF00c6fb),
                            Color(0xFF005bea)
                          ],
                          iconData: CustomIcons.linkedin,
                          onPressed: (){

                          },
                        ),
                      ],
                    ),
                    SizedBox(height: ScreenUtil().setHeight(40)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("New User ?",style: TextStyle(fontFamily: "Poppins-Medium"),),
                        InkWell(
                          onTap: (){

                          },
                          child: Text(
                            "Sign Up",
                            style: TextStyle(color: Color(0xFF5d74e3),fontFamily: "Poppins-Bold"),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )

          ],
        )

    );
  }

  void radio(){
    setState(() {
      print(isSelected);
      isSelected = !isSelected;
    });
  }

  Widget radioButton(bool isSelected) => Container(
      width: 16.0,
      height: 16.0,
      padding: EdgeInsets.all(2.0),
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2.0,color: Colors.black)
      ),
      child:  isSelected ? Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.black),
      ) : Container()
  );

  Widget horizontalLine() => Padding(
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    child: Container(
      width: ScreenUtil().setWidth(120),
      height: 1.0,
      color: Colors.black26.withOpacity(0.2),
    ),
  );


}
