import 'package:attayairaq/Test/verify.dart';
import 'package:attayairaq/consts/consts.dart';
import 'package:attayairaq/functions/show_overlay.dart';
import 'package:attayairaq/services/auth_service.dart';
import 'package:attayairaq/services/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:attayairaq/screens/HomeScreen.dart';

class ValidateNumberPage extends StatefulWidget {
  final UserType userType;
  final bool isRegister;

  const ValidateNumberPage({
    this.userType,
    this.isRegister,
  });
  @override
  _ValidateNumberPageState createState() => _ValidateNumberPageState();
}

class _ValidateNumberPageState extends State<ValidateNumberPage> {
  final _formkey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final title = widget.isRegister ? 'انشاء حساب' : 'تسجيل الدخول';
    return Scaffold(
      appBar: apBar(
          widget.userType == UserType.admin ? 'مرحبا بك' : title, context),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: SizeConfig.screenHeight * 0.2,
                ),
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
                          validationifText: 'رقم الهاتف غير صحيح ادخل 11 رقما',
                          validationElseText: 'رقم الهاتف كبير جدا',
                          password: false,
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          width: SizeConfig.screenWidth * 0.7,
                          child: buttonBlueShape(
                            'تسجيل الدخول',
                            context,
                            () async {
                              print(_phoneController.text);

                              if (_formkey.currentState.validate()) {
                                _formkey.currentState.save();
                                String number =
                                    '+964' + _phoneController.text.substring(1);
                                print('number phone is $number ');
                                try {
                                  await AuthService.instantiate(
                                    phoneNumber: number,
                                    type: widget.userType,
                                  );
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (_) => PhoneAuthVerify(),
                                    ),
                                  );

                                  // await AuthService().verifyNumber(
                                  //     number, context, widget.userType);
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
                                        context: context,
                                      );
                                      break;

                                    default:
                                  }
                                }
                              }
                            },
                          ),
                        )
                      ],
                    )
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
