import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../consts/consts.dart';
import '../../services/size_config.dart';
import '../../screens/authentication/Validate_number.dart';

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          textDirection: TextDirection.rtl,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.only(top: 90.0),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Image.asset(
                    "assets/icons/sign_up.png",
                    height: 100.0,
                  ),
                ),
                const Text("يرجى اختيار نوع الحساب", style: emptyRedText),
              ],
            ),
            const SizedBox(height: 90),
            SizedBox(
              width: SizeConfig.screenWidth * 0.7,
              child: buttonRedShape(
                'التسجيل كعائلة',
                context,
                () {
                  //navige to family sign up
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const ValidateNumberPage(
                        userType: UserType.family,
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 50.0),
            SizedBox(
              width: SizeConfig.screenWidth * 0.7,
              child: buttonRedShape(
                'التسجيل كمنظمة',
                context,
                () {
                  // navige to Organization page
                  Navigator.of(context).push(
                    CupertinoPageRoute(
                      builder: (context) => const ValidateNumberPage(
                        userType: UserType.organisation,
                      ),
                    ),
                  );
                },
              ),
            ),
            const Spacer(),
            RichText(
              text: TextSpan(
                text: 'تسجيل دخول كأدمن؟ ',
                style: textStyle,
                children: [
                  TextSpan(
                    text: 'اضغط هنا',
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).push(
                          CupertinoPageRoute(
                            builder: (context) => const ValidateNumberPage(
                              userType: UserType.admin,
                            ),
                          ),
                        );
                      },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'اذا لم يكن لديك حساب سيتم \nتوجيهك لانشاء حساب جديد',
              style: textStyle.copyWith(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
