import 'package:attayairaq/Test/verify.dart';
import 'package:attayairaq/functions/show_overlay.dart';
import 'package:attayairaq/screens/HomeScreen.dart';
import 'package:attayairaq/services/auth_service.dart';
import 'package:attayairaq/services/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  String status = '';
  UserType userType = UserType.family;

  String transUserTyp(UserType u) {
    switch (u) {
      case UserType.family:
        return 'عائلة';
        break;
      case UserType.organisation:
        return 'منظمة';

        break;

      default:
        return 'ادمن';
    }
  }

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
                    SizedBox(
                      width: 142,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(30)),
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 10, bottom: 5),
                        child: DropdownButton<UserType>(
                          value: userType,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          onChanged: (newValue) {
                            setState(() {
                              userType = newValue;
                            });
                          },
                          underline: Container(),
                          items: [
                            UserType.admin,
                            UserType.family,
                            UserType.organisation,
                          ].map<DropdownMenuItem<UserType>>((val) {
                            return DropdownMenuItem<UserType>(
                              value: val,
                              child: Text(
                                transUserTyp(val),
                                style: textStyle,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        textDirection: TextDirection.rtl,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SizedBox(height: 30),
                          SizedBox(
                            height: 60.0,
                            child: Form(
                              key: _formkey,
                              child: CrdTxtFrmFld(
                                cntrTxt: _phoneController,
                                hinttxt: 'رقم الهاتف',
                                largerElseValue: 12,
                                smallerValue: 11,
                                validationifText:
                                    'رقم الهاتف غير صحيح ادخل 11 رقما',
                                validationElseText: 'رقم الهاتف كبير جدا',
                                password: false,
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          SizedBox(
                            width: SizeConfig.screenWidth * 0.7,
                            child: buttonBlueShape(
                              'تسجيل الدخول',
                              context,
                              () async {
                                print(_phoneController.text);

                                if (_formkey.currentState.validate()) {
                                  _formkey.currentState.save();
                                  String number = '+964' +
                                      _phoneController.text.substring(1);
                                  print('number phone is $number ');
                                  try {
                                    await AuthService.instantiate(
                                      phoneNumber: number,
                                      type: userType,
                                    );
                                    Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                        builder: (_) => PhoneAuthVerify(),
                                      ),
                                    );
                                    // await AuthService().verifyNumber(
                                    //     number, context, userType);
                                  } on AuthException catch (e) {
                                    switch (e.message) {
                                      case 'ERROR_INVALID_CREDENTIAL':
                                        return showOverlay(
                                            text: 'الرقم غير صحيح',
                                            context: context);
                                        break;
                                      case 'ERROR_USER_NOT_FOUND':
                                        return showOverlay(
                                            text: 'لا يوجد حساب بهذا الرقم',
                                            context: context);
                                        break;

                                      default:
                                    }
                                  }
                                }
                              },
                            ),
                          )
                        ],
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
