import 'package:attayairaq/screens/HomeScreen.dart';
import 'package:attayairaq/screens/authentication/Validate_number.dart';
import 'package:attayairaq/services/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:attayairaq/consts/consts.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    // for initiliaze size config
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        width: SizeConfig.screenWidth * 1,
        height: SizeConfig.screenHeight * 1,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            textDirection: TextDirection.rtl,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 90.0),
              ),
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
              ),
              SizedBox(
                height: 90,
              ),
              SizedBox(
                width: SizeConfig.screenWidth * 0.7,
                child: buttonRedShape(
                  'التسجيل كعائلة',
                  context,
                  () {
                    //navige to family sign up
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => ValidateNumberPage(
                          isRegister: true,
                          userType: UserType.family,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              SizedBox(
                width: SizeConfig.screenWidth * 0.7,
                child: buttonRedShape(
                  'التسجيل كمنظمة',
                  context,
                  () {
                    // navige to Organization page
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => ValidateNumberPage(
                          isRegister: true,
                          userType: UserType.organisation,
                        ),
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: SizeConfig.screenHeight * 0.2,
              ),
              
              RichText(
                text: TextSpan(
                  text: 'تسجيل دخول كأدمن؟ ',
                  style: textStyle,
                  children: [
                    TextSpan(
                      text: 'اضغط هنا',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ValidateNumberPage(
                                isRegister: true,
                                userType: UserType.admin,
                              ),
                            ),
                          );
                        },
                    ),
                  ],
                ),
                
              ),
              SizedBox(height: 20),
              Text(
                'اذا لم يكن لديك حساب سيتم \nتوجيهك لانشاء حساب جديد',
                style: textStyle.copyWith(fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
