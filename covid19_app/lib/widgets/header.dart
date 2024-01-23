
import 'package:covid_19/info_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../Home.dart';
import '../constant.dart';

class MyClipper extends CustomClipper<Path>{

  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height-80);
    path.quadraticBezierTo(size.width/2, size.height,size.width,size.height-80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

}

class MyHeader extends StatelessWidget {

  final String image;
  final String textTop;
  final String textBottom;
  final int page;


  const MyHeader({Key key, this.image, this.textTop, this.textBottom, double offset, this.page, }):super(key:key);


  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper:MyClipper(),
        child:Container(
          padding: EdgeInsets.only(left:  MediaQuery.of(context).size.height/20,top:  MediaQuery.of(context).size.height/20,right:  MediaQuery.of(context).size.height/35),
          height:  MediaQuery.of(context).size.height/2.5,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(0xFF3393CD),
                    Color(0xFF11249F)
                  ]
              ),
              image: DecorationImage(
                image: AssetImage("assets/images/virus.png"),
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Align(
                  alignment: Alignment.topRight,
                  child:GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        if(page==1){
                          return MyHomePage();
                        }else{
                          return InfoScreen();
                        }
                      }));
                    },
                      child:SvgPicture.asset("assets/icons/menu.svg")
                  )
              ),
              SizedBox(height: MediaQuery.of(context).size.height/50),
              Expanded(
                child: Stack(
                  children: <Widget>[
                    SvgPicture.asset(
                      image,
                      width: 170,
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.topCenter,
                    ),
                    Positioned(
                      top:MediaQuery.of(context).size.height/50,
                      left: MediaQuery.of(context).size.width/3.5,
                      child: Text(
                        "$textTop\n$textBottom",
                        style: kHeadingTextStyle.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Container() // I DONT KNOW WITH IT CAN'T WORK WITHOUT CONTAINER
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}