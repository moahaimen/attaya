import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../consts/consts.dart';
import '../../consts/loading.dart';
import '../../services/size_config.dart';
import '../../services/auth_service.dart';

class ValidateNumberPage extends StatefulWidget {
  final UserType userType;

  const ValidateNumberPage({
    @required this.userType,
  });
  @override
  _ValidateNumberPageState createState() => _ValidateNumberPageState();
}

class _ValidateNumberPageState extends State<ValidateNumberPage> {
  final _formkey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    const title = 'تسجيل الدخول';
    return Scaffold(
      appBar: apBar(
          widget.userType == UserType.admin ? 'مرحبا بك' : title, context),
      body: SingleChildScrollView(
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
                  const SizedBox(height: 30),
                  SizedBox(
                    // height: 60.0,
                    child: Form(
                      key: _formkey,
                      child: CrdTxtFrmFld(
                        cntrTxt: _phoneController,
                        hinttxt: 'رقم الهاتف',
                        largerElseValue: 12,
                        smallerValue: 11,
                        validationifText: 'رقم الهاتف غير صحيح ادخل 11 رقما',
                        validationElseText: 'رقم الهاتف كبير جدا',
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        width: SizeConfig.screenWidth * 0.7,
                        child: buttonBlueShape(
                          'تسجيل الدخول',
                          context,
                          () async {
                            if (_formkey.currentState.validate()) {
                              _formkey.currentState.save();
                              final number =
                                  '+964${_phoneController.text.substring(1)}';

                              await AuthService.instantiate(
                                phoneNumber: number,
                                type: widget.userType,
                              );
                              Navigator.of(context).pushReplacement(
                                CupertinoPageRoute(
                                  builder: (_) => PhoneAuthVerify(
                                    phoneNumber: _phoneController.text,
                                  ),
                                ),
                              );
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
    );
  }
}

class PhoneAuthVerify extends StatefulWidget {
  final String phoneNumber;

  const PhoneAuthVerify({@required this.phoneNumber});

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
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: _getColumnBody(),
          ),
        ),
      ),
    );
  }

  Widget _getColumnBody() {
    return Column(
      children: <Widget>[
        Text(
          'تاكيد الحساب',
          style: textStyle.copyWith(fontSize: 40),
        ),
        Text(
          'سوف تستلم رسالة على الرقم',
          style: textStyle.copyWith(
            fontSize: 18,
            color: Colors.pink,
          ),
        ),
        Text(
          widget.phoneNumber,
          style: textStyle.copyWith(fontSize: 18),
        ),
        SizedBox(height: SizeConfig.screenHeight * 0.1),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            getPinField(key: "1", focusNode: focusNode1),
            const SizedBox(width: 5.0),
            getPinField(key: "2", focusNode: focusNode2),
            const SizedBox(width: 5.0),
            getPinField(key: "3", focusNode: focusNode3),
            const SizedBox(width: 5.0),
            getPinField(key: "4", focusNode: focusNode4),
            const SizedBox(width: 5.0),
            getPinField(key: "5", focusNode: focusNode5),
            const SizedBox(width: 5.0),
            getPinField(key: "6", focusNode: focusNode6),
            const SizedBox(width: 5.0),
          ],
        ),
        const SizedBox(height: 32.0),
        SizedBox(
          width: SizeConfig.screenWidth * 0.3,
          child: buttonBlueShape(
            'تاكيد',
            context,
            loading
                ? null
                : () async {
                    setState(() {
                      loading = true;
                    });
                    try {
                      await AuthService.signInWithPhoneNumber(smsCode: code);
                    } catch (e) {
                      showCostumeAuthErrorNotif(e);
                    }
                  },
          ),
        ),
        const SizedBox(height: 20.0),

        loading
            ? const SizedBox(
                width: 50,
                height: 50,
                child: Loading(),
              )
            : Container(),
      ],
    );
  }

  // This will return pin field - it accepts only single char
  Widget getPinField({String key, FocusNode focusNode}) => SizedBox(
        height: 40.0,
        width: 35.0,
        child: TextField(
          key: Key(key),
          expands: false,
          autofocus: key.contains("1") ? true : false,
          focusNode: focusNode,
          onChanged: (value) {
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
          cursorColor: Colors.black,
          keyboardType: TextInputType.number,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      );
}
