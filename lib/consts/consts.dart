// import 'package:attayairaq/services/size_config.dart';
import 'package:attayairaq/services/auth_service.dart';
import 'package:flutter/material.dart';

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
Card crdTxtOldFrmFld({
  String hinttxt,
  TextEditingController cntrTxt,
  String valTxt,
  String validationifText,
  String validationElseText,
  int largerElseValue,
  int smallerValue,
  bool password,
}) {
  return Card(
    elevation: 5,
    child: TextFormField(
      obscureText: password,
      textAlign: TextAlign.right,
      textAlignVertical: TextAlignVertical.center,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        focusedBorder: InputBorder.none,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide.none),
        hintText: "$hinttxt",
        hintStyle: TextStyle(
            fontSize: 16.0,
            fontFamily: 'Changa',
            fontWeight: FontWeight.bold,
            color: const Color(0xffA5D5EB)),
      ),
      controller: cntrTxt,
      validator: (val) {
        if (val.trim().length < smallerValue || val.isEmpty) {
          return validationifText;
        } else if (val.trim().length > largerElseValue) {
          return validationElseText;
        } else {
          return null;
        }
      },
      onSaved: (val) => valTxt = val,
    ),
  );
}

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
  color: const Color(0xFF2356C7),
);

const emptyBlackTextWithShadows = TextStyle(
  shadows: [
    Shadow(
      blurRadius: 20.0,
      color: const Color(0xff130f40),
      offset: Offset(1.0, 5.0),
    ),
  ],

  fontSize: 28.0,
  fontFamily: 'Changa',
  fontWeight: FontWeight.w800,
  color: const Color(0xFF130f40),
// shadows: Colors.black
);

const emptyRedText = TextStyle(
  fontSize: 30.0,
  fontFamily: 'Changa',
  fontWeight: FontWeight.w900,
  color: const Color(0xFFC95555),
);

const emptyTallRedText = TextStyle(
  fontSize: 23.0,
  fontFamily: 'Changa',
  fontWeight: FontWeight.w900,
  color: const Color(0xFFC95555),
);

const navText = TextStyle(
  fontSize: 14.0,
  fontFamily: 'Changa',
  fontWeight: FontWeight.w800,
);

// ignore: non_constant_identifier_names
Card buttonBlueShape(String titleOfButton, context, Function function) {
  return Card(
    child: Container(
      height: 50.0,
      width: double.infinity,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: const Color(0xFF2356C7),
        child: Text(
          '$titleOfButton',
          textAlign: TextAlign.center,
          style: buttonWhiteText,
        ),
        onPressed: function,
      ),
    ),
  );
}

Card buttonBlueOldShape(String titleOfButton, context, Function function) {
  return Card(
    child: Container(
      height: 50.0,
      width: double.infinity,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: const Color(0xFF2356C7),
        child: Text(
          '$titleOfButton',
          textAlign: TextAlign.center,
          style: buttonWhiteText,
        ),
        onPressed: function,
      ),
    ),
  );
}

Card buttonLoginBlueShape(String titleOfButton, context, Function function) {
  return Card(
    child: Container(
      height: 50.0,
      width: 300.0,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: const Color(0xFF2356C7),
        child: Text('$titleOfButton',
            textAlign: TextAlign.center, style: buttonWhiteText),
        onPressed: () {
//          Navigator.push(context,
//              MaterialPageRoute(builder: (context) => stringNavigation));
          function();
        },
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
        child: Text('$titleOfButton',
            textAlign: TextAlign.center, style: buttonWhiteText),
        onPressed: function,
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

TextStyle textStyle = TextStyle(
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

final outlineInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(0),
  borderSide: BorderSide(color: Colors.white),
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
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        elevation: 5,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: Colors.white,
              width: 2,
            )),
        child: TextFormField(
          obscureText: password,
          keyboardType: isNumber ? TextInputType.number : TextInputType.text,
          textAlign: TextAlign.right,
          textAlignVertical: TextAlignVertical.center,
          textDirection: TextDirection.rtl,
          decoration: InputDecoration(
            // focusedBorder: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            focusColor: Colors.white,
            border: outlineInputBorder,
            disabledBorder: outlineInputBorder,
            enabledBorder: outlineInputBorder,
            errorBorder: outlineInputBorder,
            focusedErrorBorder: outlineInputBorder,
            hintText: "$hinttxt",
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

Card crdRedTxtFrmFldforInteger({
  String hinttxt,
  TextEditingController cntrTxt,
  int valTxt,
  String validationifText,
  String validationElseText,
  int largerElseValue,
  int smallerValue,
  bool passwrd,
}) {
  return Card(
    elevation: 5,
    child: TextFormField(
      obscureText: passwrd,
      textAlign: TextAlign.right,
      textAlignVertical: TextAlignVertical.center,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        focusedBorder: InputBorder.none,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide.none),
        hintText: "$hinttxt",
        hintStyle: TextStyle(
            fontSize: 16.0,
            fontFamily: 'Changa',
            fontWeight: FontWeight.bold,
            color: const Color(0xffDC9292)),
      ),
      controller: cntrTxt,
      validator: (val) {
        if (val.trim().length < smallerValue || val.isEmpty) {
          return validationifText;
        } else if (val.trim().length > largerElseValue) {
          return validationElseText;
        } else {
          return null;
        }
      },
      onSaved: (val) => valTxt = val as int,
    ),
  );
}

Card crdRedTxtFrmFldforIntegerorg({
  String hinttxt,
  TextEditingController cntrTxt,
  int valTxt,
  String validationifText,
  String validationElseText,
  int largerElseValue,
  int smallerValue,
  bool password,
}) {
  return Card(
    elevation: 5,
    child: TextFormField(
      obscureText: password,
      textAlign: TextAlign.right,
      textAlignVertical: TextAlignVertical.center,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        focusedBorder: InputBorder.none,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide.none),
        hintText: "$hinttxt",
        hintStyle: TextStyle(
            fontSize: 13.0,
            fontFamily: 'Changa',
            fontWeight: FontWeight.bold,
            color: const Color(0xffDC9292)),
      ),
      controller: cntrTxt,
      validator: (val) {
        if (val.trim().length < smallerValue || val.isEmpty) {
          return validationifText;
        } else if (val.trim().length > largerElseValue) {
          return validationElseText;
        } else {
          return null;
        }
      },
      onSaved: (val) => valTxt = val as int,
    ),
  );
}

Card crdRedTxtFrmFldorg(
    {String hinttxt,
    TextEditingController cntrTxt,
    String valTxt,
    String validationifText,
    String validationElseText,
    int largerElseValue,
    int smallerValue,
    bool password}) {
  return Card(
    elevation: 5,
    child: TextFormField(
      obscureText: password,
      textAlign: TextAlign.right,
      textAlignVertical: TextAlignVertical.center,
      textDirection: TextDirection.rtl,
      decoration: InputDecoration(
        focusedBorder: InputBorder.none,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            borderSide: BorderSide.none),
        hintText: "$hinttxt",
        hintStyle: TextStyle(
            fontSize: 14.0,
            fontFamily: 'Changa',
            fontWeight: FontWeight.bold,
            color: const Color(0xffDC9292)),
      ),
      controller: cntrTxt,
      validator: (val) {
        if (val.trim().length < smallerValue || val.isEmpty) {
          return validationifText;
        } else if (val.trim().length > largerElseValue) {
          return validationElseText;
        } else {
          return null;
        }
      },
      onSaved: (val) => valTxt = val,
    ),
  );
}

AppBar apBar(String ttl, context, {bool isNotsubScreen = false}) {
  return AppBar(
    centerTitle: true,
    title: Text('$ttl', textAlign: TextAlign.center, style: headerWhiteText),
    backgroundColor: const Color(0xFF2356C7),
    elevation: 5,
    leading: isNotsubScreen
        ? Container()
        : IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () => Navigator.of(context).pop(),
          ),
    actions: <Widget>[
      isNotsubScreen? FlatButton(
        onPressed: () {
          AuthService().signOut();
        },
        child: Text(
          'تسجيل الخروج',
          style: textStyle.copyWith(fontSize: 10, color: Colors.white),
        ),
      ): Container(),
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
