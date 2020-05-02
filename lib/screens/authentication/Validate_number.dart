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

class PhoneAuthVerify extends StatefulWidget {
  @override
  _PhoneAuthVerifyState createState() => _PhoneAuthVerifyState();
}

class _PhoneAuthVerifyState extends State<PhoneAuthVerify> {

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();
  FocusNode focusNode4 = FocusNode();
  FocusNode focusNode5 = FocusNode();
  FocusNode focusNode6 = FocusNode();
  String code = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              height: SizeConfig.screenHeight * 8 / 10,
              width: SizeConfig.screenWidth * 8 / 10,
              child: _getColumnBody(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _getColumnBody() => Column(
        children: <Widget>[
          SizedBox(height: 20.0),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              getPinField(key: "1", focusNode: focusNode1),
              SizedBox(width: 5.0),
              getPinField(key: "2", focusNode: focusNode2),
              SizedBox(width: 5.0),
              getPinField(key: "3", focusNode: focusNode3),
              SizedBox(width: 5.0),
              getPinField(key: "4", focusNode: focusNode4),
              SizedBox(width: 5.0),
              getPinField(key: "5", focusNode: focusNode5),
              SizedBox(width: 5.0),
              getPinField(key: "6", focusNode: focusNode6),
              SizedBox(width: 5.0),
            ],
          ),
          SizedBox(height: 32.0),
          SizedBox(
            width: SizeConfig.screenWidth * 0.3,
            child: buttonBlueShape(
              'تاكيد',
              context,
              () {
                AuthService.signInWithPhoneNumber(smsCode: code);
              },
            ),
          ),
        ],
      );

  // This will return pin field - it accepts only single char
  Widget getPinField({String key, FocusNode focusNode}) => SizedBox(
        height: 40.0,
        width: 35.0,
        child: TextField(
          key: Key(key),
          expands: false,
          autofocus: key.contains("1") ? true : false,
          focusNode: focusNode,
          onChanged: (String value) {
            if (value.length == 1) {
              code += value;
              switch (code.length) {
                case 1:
                  FocusScope.of(context).requestFocus(focusNode2);
                  break;
                case 2:
                  FocusScope.of(context).requestFocus(focusNode3);
                  break;
                case 3:
                  FocusScope.of(context).requestFocus(focusNode4);
                  break;
                case 4:
                  FocusScope.of(context).requestFocus(focusNode5);
                  break;
                case 5:
                  FocusScope.of(context).requestFocus(focusNode6);
                  break;
                default:
                  FocusScope.of(context).requestFocus(FocusNode());
                  break;
              }
            }
          },
          maxLengthEnforced: false,
          textAlign: TextAlign.center,
          cursorColor: Colors.white,
          keyboardType: TextInputType.number,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      );
}
