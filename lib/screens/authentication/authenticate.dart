import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts/consts.dart';
import '../../services/size_config.dart';
import '../../screens/shared/about.dart';
import '../../screens/authentication/sign_up.dart';

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
            const Padding(
              padding: EdgeInsets.only(top: 40.0),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 85),
                child: Image.asset(
                  "assets/icons/logo_icon.png",
                  height: 250.0,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 40),
              child: Text("تطبيق عطايا", style: emptyblueText),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: <Widget>[
                  const SizedBox(
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
            const SizedBox(
              height: 10.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (_) => const About(isAboutApp: false),
                        ),
                      );
                    },
                    child: Text(
                      'حول المبادرة',
                      style: textStyle.copyWith(fontSize: 14.0),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        CupertinoPageRoute(
                          builder: (_) => const About(isAboutApp: true),
                        ),
                      );
                    },
                    child: Text(
                      'حول التطبيق',
                      style: textStyle.copyWith(fontSize: 14.0),
                    ),
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
