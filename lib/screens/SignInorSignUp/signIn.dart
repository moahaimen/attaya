import 'package:attayairaq/screens/SignInorSignUp/signUpChoice.dart';
import 'package:attayairaq/services/shared_preferences.dart';
import 'package:attayairaq/services/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attayairaq/consts/consts.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
//final _passController = TextEditingController();
  final _codeController = TextEditingController();
  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseApp app = FirebaseApp(name: '[DEFAULT]');
    FirebaseAuth _auth = FirebaseAuth.fromApp(app);

    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential credential) async {
        Navigator.of(context).pop();

        AuthResult result = await _auth.signInWithCredential(credential);

        FirebaseUser user = result.user;

        if (user != null) {
          await SharedPreferencesOperations().storeUser(user);
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SignUpChoices()));
        } else {
          print("Error");
        }

//This callback would gets called when verification is done auto maticlly
      },
      verificationFailed: (AuthException exception) {
        print(exception.message);
      },
      codeSent: (String verificationId, [int forceResendingToken]) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text("هل استلمت الكود"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextField(
                    controller: _codeController,
                  ),
                ],
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text("Confirm"),
                  textColor: Colors.white,
                  color: Colors.blue,
                  onPressed: () async {
                    final code = _codeController.text.trim();
                    AuthCredential credential = PhoneAuthProvider.getCredential(
                        verificationId: verificationId, smsCode: code);

                    AuthResult result =
                        await _auth.signInWithCredential(credential);

                    FirebaseUser user = result.user;

                    if (user != null) {
                      await SharedPreferencesOperations().storeUser(user);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SignUpChoices(), //user: user,)
                          ));
                    } else {
                      print("Error");
                    }
                  },
                )
              ],
            );
          },
        );
      },
      codeAutoRetrievalTimeout: null,
    );

    return true;
  }

  String phoneTxt, pswdTxt = "";
//Place A
  @override
  Widget build(BuildContext context) {
// for initiliaze size config
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: SizeConfig.screenWidth * 1,
          height: SizeConfig.screenHeight * 1,
          padding: EdgeInsets.all(6.0),
          child: Center(
            child: ListView(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 10),
                              child: Image.asset(
                                "assets/icons/sign_up.png",
                                color: const Color(0xFF2356C7),
                                height: 200.0,
                              ),
                            ),
                            Text("تسجيل الدخول", style: emptyblueText),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Form(
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 30),
                            SizedBox(
                              height: 60.0,
                              child: crdTxtFrmFld(
                                  valTxt: phoneTxt,
                                  cntrTxt: _phoneController,
                                  hinttxt: 'رقم الهاتف',
                                  largerElseValue: 20,
                                  smallerValue: 10,
                                  validationifText:
                                      'رقم الهاتف غير صحيح ادخل 11 رقما',
                                  validationElseText: 'رقم الهاتف كبير جدا',
                                  password: false),
                            ),
                            SizedBox(height: 16),
/* SizedBox(
height: 60.0,
child: crdTxtFrmFld(
valTxt: pswdTxt,
cntrTxt: _passController,
hinttxt: 'كلمة السر',
LargerElseValue: 12,
SmallerValue: 8,
validationifText:
'كلمة السر يجب ان تكون اكثر من 8 ',
validationElseText: 'كلمة السر كبيرة جدا',
Passwrd: false),
),
SizedBox(
height: 20,
), */
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                buttonBlueShape('تسجيل الدخول', context, () {
                                  print(_phoneController.text);

                                  if (_formkey.currentState.validate()) {
                                    _formkey.currentState.save();
                                    String number =
                                        '+964' + _phoneController.text;
                                    print('number phone is $number ');
                                    loginUser(number, context);
                                  } else {
                                    print('not valid');
                                  }
                                })
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
