import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'consts/consts.dart';
import 'screens/SignInorSignUp/signUpChoice.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  txt () {
    print("completed");
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
//      backgroundColor: Colors.blue,
//      appBar:AppBar(
//          title: Text("ggg")
//      ),

      body: SafeArea(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top:100.0),

              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 85),
                    child: SvgPicture.asset("assets/icons/logo.svg",
                      height: 250.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40,vertical: 40),
                child: Text("تطبيق عطايا",style:emptyblueText ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 20,vertical: 20),
              child: Column(
                children: <Widget>[
                  ButtonBlueShape('تسجيل الدخول',context,(){}),
                  SizedBox(
                    height: 15.0,
                  ),
                  InkWell(
                     child: ButtonRedShape('انشاء حساب جديد',context,()
                     {
                       print('object');
                      }
                       ),

                  )
                ],
              )
            ),
             ],
        ),
              SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                      flex:2,
                      child: Column(
                        mainAxisAlignment : MainAxisAlignment.center,
                        children: <Widget>[
                          Text('حول المبادرة',style: NavText,),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Column(

                        mainAxisAlignment : MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text('                     '),
                        ],
                      ),
                    ),
                    Expanded(
                      flex:2,
                      child: Column(
                        mainAxisAlignment : MainAxisAlignment.end,
                        children: <Widget>[
                          Text('حول التطبيق',style: NavText,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
