import 'package:attayairaq/screens/SignInorSignUp/family_information_for_profile.dart';
import 'package:attayairaq/screens/SignInorSignUp/orginization_information_for_profile.dart';
import 'package:attayairaq/services/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attayairaq/consts/consts.dart';

class SignUpChoices extends StatefulWidget {
  @override
  _SignUpChoicesState createState() => _SignUpChoicesState();
}

class _SignUpChoicesState extends State<SignUpChoices> {
  txt() {
    print("completed");
  }

  @override
  Widget build(BuildContext context) {
    // for initiliaze size config
    SizeConfig().init(context);
    return Scaffold(
//      backgroundColor: Colors.blue,
//      appBar:AppBar(
//          title: Text("ggg")
//      ),

      body: SafeArea(
        child: Container(
          width: SizeConfig.screenWidth * 1,
          height: SizeConfig.screenHeight * 1,
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                textDirection: TextDirection.rtl,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 90.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Image.asset(
                              "assets/icons/sign_up.png",
                              height: 100.0,
                            ),
                          ),
                          Text("يرجى اختيار نوع الحساب", style: emptyRedText),
                        ],
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 50),
                        child: Column(
                          children: <Widget>[
                            buttonRedShape(
                              'التسجيل كعائلة',
                              context,
                              () {
                                //navige to family sign up
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        FamilySignup()));
                              },
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                            buttonRedShape(
                              'التسجيل كمنظمة',
                              context,
                              () {
                                // navige to Organization page

                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        OrgiziationsSignup()));
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
