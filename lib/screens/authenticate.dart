import 'package:attayairaq/consts/consts.dart';
import 'package:attayairaq/screens/authentication/sign_up.dart';
import 'package:attayairaq/services/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              textDirection: TextDirection.rtl,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 100.0),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 85),
                      child: Image.asset(
                        "assets/icons/logo_icon.png",
                        height: 250.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
                  child: Text("تطبيق عطايا", style: emptyblueText),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 15.0,
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.7,
                            child: buttonRedShape(
                              'التسجيل',
                              context,
                              () {
                                Navigator.of(context).push(
                                  CupertinoPageRoute(
                                    builder: (_) => SignUp(),
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'حول المبادرة',
                        style: navText,
                      ),
                      Text(
                        'حول التطبيق',
                        style: navText,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
