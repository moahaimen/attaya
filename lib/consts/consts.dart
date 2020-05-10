// import 'package:attayairaq/services/size_config.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';

const headerWhiteText = TextStyle(
  fontSize: 24.0,
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'Changa',
);

const headerTextblue = TextStyle(
  fontSize: 24.0,
  color: Colors.blue,
  fontWeight: FontWeight.bold,
);

const DeepBlueText = TextStyle(
  color: deepTxtBlue,
  fontWeight: FontWeight.bold,
  fontSize: 20.0,
  fontFamily: 'Changa',
);
const cardBorderTextstyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 16.0,
  fontFamily: 'Changa',
);

const buttonWhiteText = TextStyle(
    fontSize: 20.0,
    fontFamily: 'Changa',
    fontWeight: FontWeight.w800,
    color: Colors.white);
const emptyblueText = TextStyle(
  fontSize: 34.0,
  fontFamily: 'Changa',
  fontWeight: FontWeight.w800,
  color: Color(0xFF2356C7),
);

const emptyBlackTextWithShadows = TextStyle(
  shadows: [
    Shadow(
      blurRadius: 20.0,
      color: Color(0xff130f40),
      offset: Offset(1.0, 5.0),
    ),
  ],
  fontSize: 28.0,
  fontFamily: 'Changa',
  fontWeight: FontWeight.w800,
  color: Color(0xFF130f40),
// shadows: Colors.black
);

const emptyRedText = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Changa',
  fontWeight: FontWeight.w900,
  color: Color(0xFFC95555),
);

const emptyTallRedText = TextStyle(
  fontSize: 23.0,
  fontFamily: 'Changa',
  fontWeight: FontWeight.w900,
  color: Color(0xFFC95555),
);

const navText = TextStyle(
  fontSize: 14.0,
  fontFamily: 'Changa',
  fontWeight: FontWeight.w800,
);

// ignore: non_constant_identifier_names
Card buttonBlueShape(
    String titleOfButton, BuildContext context, Function function) {
  return Card(
    child: Container(
      height: 50.0,
      width: double.infinity,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: const Color(0xFF2356C7),
        onPressed: () => function,
        child: Text(
          titleOfButton,
          textAlign: TextAlign.center,
          style: buttonWhiteText,
        ),
      ),
    ),
  );
}

Card buttonRedShape(
  String titleOfButton,
  BuildContext context,
  Function function,
) {
  return Card(
    child: Container(
      height: 50.0,
      width: double.infinity,
      child: RaisedButton(
        elevation: 10.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: const Color(0xFFC95555),
        onPressed: () => function,
        child: Text(
          titleOfButton,
          textAlign: TextAlign.center,
          style: buttonWhiteText,
        ),
      ),
    ),
  );
}

//Form Fields Constants

const shadowTxtBlueFillFld = Color(0xffDDDDDD);
const txtFldStyle = Color(0xffA5D5EB);
const deepTxtBlue = Color(0xFF130f40);

const kTxtInptDecrtion = InputDecoration(
    filled: true,
    fillColor: shadowTxtBlueFillFld,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide.none,
    ));

const txtHintstyle = TextStyle(
  color: txtFldStyle,
  fontWeight: FontWeight.bold,
  fontSize: 22.0,
  fontFamily: 'Changa',
);
const aboutTextstyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 18.0,
  fontFamily: 'Changa',
);

TextStyle textStyle = const TextStyle(
  fontSize: 18,
  fontFamily: 'Changa',
  fontWeight: FontWeight.bold,
  color: deepTxtBlue,
);

const deepBlueTextStyle = TextStyle(
  color: deepTxtBlue,
  fontWeight: FontWeight.bold,
  fontSize: 20.0,
  fontFamily: 'Changa',
);

const txtWritingFldForm = TextStyle(
  color: txtFldStyle,
  fontWeight: FontWeight.bold,
  fontSize: 22.0,
  fontFamily: 'Changa',
);

final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(15),
  borderSide: const BorderSide(color: Colors.white),
);

class CrdTxtFrmFld extends StatelessWidget {
  final String hinttxt;
  final String validationifText;
  final String validationElseText;
  final int largerElseValue;
  final int smallerValue;
  final bool password;
  final bool isNumber;
  final bool isBlue;

  const CrdTxtFrmFld({
    @required TextEditingController cntrTxt,
    this.hinttxt,
    this.validationifText,
    this.validationElseText,
    this.largerElseValue,
    this.smallerValue,
    this.password = false,
    this.isNumber = false,
    this.isBlue = true,
  }) : _cntrTxt = cntrTxt;

  final TextEditingController _cntrTxt;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: TextFormField(
          obscureText: password,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          textAlign: TextAlign.right,
          textAlignVertical: TextAlignVertical.center,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            focusColor: Colors.white,
            border: InputBorder.none,
            disabledBorder: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            errorBorder: outlineInputBorder,
            focusedErrorBorder: outlineInputBorder,
            hintText: hinttxt,
            hintStyle: TextStyle(
              fontSize: 16.0,
              fontFamily: 'Changa',
              fontWeight: FontWeight.bold,
              color: isBlue ? const Color(0xffA5D5EB) : const Color(0xffDC9292),
            ),
          ),
          controller: _cntrTxt,
          validator: (val) {
            if (val.trim().length > largerElseValue) {
              return validationElseText;
            } else if (val.trim().isEmpty) {
              return 'يرجى ملئ الحقل';
            } else if (val.trim().length < smallerValue) {
              return validationifText;
            } else if (isNumber) {
              return int.tryParse(val) != null ? null : 'الرجاء ادخال رقم';
            } else {
              return null;
            }
          },
        ),
      ),
    );
  }
}

AppBar apBar(String ttl, BuildContext context, {bool isNotsubScreen = false}) {
  return AppBar(
    centerTitle: true,
    title: Text(
      ttl,
      textAlign: TextAlign.center,
      style: headerWhiteText,
    ),
    backgroundColor: const Color(0xFF2356C7),
    elevation: 5,
    leading: isNotsubScreen
        ? Container()
        : IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
    actions: <Widget>[
      isNotsubScreen
          ? FlatButton(
              onPressed: () {
                AuthService().signOut();
              },
              child: Text(
                'تسجيل الخروج',
                style: textStyle.copyWith(fontSize: 10, color: Colors.white),
              ),
            )
          : Container(),
    ],
  );
}

const smallCarText = TextStyle(
  fontSize: 10.0,
  fontFamily: 'Changa',
  fontWeight: FontWeight.w800,
);

const headerText = TextStyle(
  fontSize: 24.0,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

// ignore: non_constant_identifier_names

//Form Fields Constants
