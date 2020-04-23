import 'package:attayairaq/services/size_config.dart';
import 'package:flutter/material.dart';

const shadowTxtBlueFillFld =Color(0xffDDDDDD);
const  TxtFldStyle =Color(0xffA5D5EB);
const DeepTxtBlue = Color(0xFF130f40);


const SmallCarText = TextStyle(
  fontSize: 10.0,
  fontFamily: 'Changa',
  fontWeight: FontWeight.w800,

);

const headerWhiteText = TextStyle(
  fontSize: 24.0,
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'Changa',


);
const emptyBlackTextWithShadows= TextStyle(
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
Card crdTxtOldFrmFld({String hinttxt,
  TextEditingController cntrTxt,
  String valTxt,
  String validationifText ,
  String validationElseText,
  int LargerElseValue,
  int SmallerValue,
  bool Passwrd,

}) {
  return Card(
    elevation: 5,
    child: TextFormField(
      obscureText:Passwrd ,

      textAlign: TextAlign.right,
      textAlignVertical: TextAlignVertical.center ,
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
        if (val
            .trim()
            .length < SmallerValue || val.isEmpty) {
          return validationifText;
        } else if (val
            .trim()
            .length > LargerElseValue) {
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
  color:DeepTxtBlue,
  fontWeight: FontWeight.bold,
  fontSize: 20.0,
  fontFamily: 'Changa',
);
const CardBorderTextstyle = TextStyle(
  color:Colors.black,
  fontWeight: FontWeight.bold,
  fontSize: 16.0,
  fontFamily: 'Changa',
);

Card ButtonBlueOldShape(String titleOfButton, context, Function) {
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
          Function;
        },
      ),
    ),
  );
}


AppBar ApBar (String ttl, context  ){
  return AppBar (
    centerTitle: true,
    title: Text('$ttl',textAlign: TextAlign.center,
        style: headerWhiteText        )  ,
    backgroundColor: const Color(0xFF2356C7),
    elevation: 5,
    leading: IconButton(icon:Icon(Icons.arrow_back_ios),
      onPressed:() => Navigator.pop(context, false),
    ),

  );
}






const headerText = TextStyle(
  fontSize: 24.0,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const headerTextblue = TextStyle(
  fontSize: 24.0,
  color: Colors.blue,
  fontWeight: FontWeight.bold,
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

const NavText = TextStyle(
  fontSize: 14.0,
  fontFamily: 'Changa',
  fontWeight: FontWeight.w800,
);

// ignore: non_constant_identifier_names
Card ButtonBlueShape(String titleOfButton, context, Function onTap) {
  SizeConfig().init(context);
  return Card(
    child: Container(
      height: SizeConfig.screenHeight*0.095,
      width: SizeConfig.screenWidth*0.6,
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: const Color(0xFF2356C7),
        child: Text('$titleOfButton',
            textAlign: TextAlign.center, style: buttonWhiteText),
        onPressed: onTap
        //() {
         // Navigator.push(context,
         //     MaterialPageRoute(builder: (context) => stringNavigation));

     //   },
      ),
    ),
  );
}

Card ButtonRedShape(String titleOfButton, context,Function ontap) {
  SizeConfig().init(context);
  return Card(
    child: Container(
         height: SizeConfig.screenHeight*0.095,
      width: SizeConfig.screenWidth*0.6,
      child: RaisedButton(
        elevation: 10.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        color: const Color(0xFFC95555),
        child: Text('$titleOfButton',
            textAlign: TextAlign.center, style: buttonWhiteText),
        onPressed:ontap

      ),
    ),
  );
}

//Form Fields Constants



 const kTxtInptDecrtion= InputDecoration(
   filled: true,
   fillColor: shadowTxtBlueFillFld,
   border: OutlineInputBorder(
     borderRadius: BorderRadius.all(
       Radius.circular(10)
     ),
     borderSide: BorderSide.none,
   )
 );


 const txtHintstyle = TextStyle(
   color:TxtFldStyle,
   fontWeight: FontWeight.bold,
   fontSize: 22.0,
   fontFamily: 'Changa',
 );


const TxtWritingFldForm = TextStyle(
  color:TxtFldStyle,
  fontWeight: FontWeight.bold,
  fontSize: 22.0,
  fontFamily: 'Changa',
);



  Card crdTxtFrmFld({String hinttxt,
    TextEditingController cntrTxt,
    String valTxt,
    String validationifText ,
    String validationElseText,
    int LargerElseValue,
    int SmallerValue,
    bool Passwrd,

  }) {
    return Card(
      elevation: 5,
      child: TextFormField(
        obscureText:Passwrd ,

        textAlign: TextAlign.right,
        textAlignVertical: TextAlignVertical.center ,
        textDirection: TextDirection.rtl,
        decoration: InputDecoration(
          focusedBorder: InputBorder.none,
          filled: true,
          fillColor: Colors.grey.shade100,
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
          if (val
              .trim()
              .length < SmallerValue || val.isEmpty) {
            return validationifText;
          } else if (val
              .trim()
              .length > LargerElseValue) {
            return validationElseText;

          } else {
            return null;
          }
        },
        onSaved: (val) =>valTxt=val
      ),
    );

  }

Card crdRedTxtFrmFld({String hinttxt,
  TextEditingController cntrTxt,
  String valTxt,
  String validationifText ,
  String validationElseText,
  int largerElseValue,
  int smallerValue,
  bool passwrd,

}) {
  return Card(
    elevation: 5,
    child: TextFormField(
      obscureText:passwrd ,

      textAlign: TextAlign.right,
      textAlignVertical: TextAlignVertical.center ,
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
        if (val
            .trim()
            .length < smallerValue || val.isEmpty) {
          return validationElseText;
        } else if (val
            .trim()
            .length > largerElseValue) {
          return validationifText;

        } else {
          return null;
        }
      },
      onSaved: (val) => valTxt = val,
    ),
  );

}

Card crdRedTxtFrmFldforInteger({String hinttxt,
  TextEditingController cntrTxt,
  String valTxt,
  String validationifText ,
  String validationElseText,
  int largerElseValue,
  int smallerValue,

  bool passwrd,

}) {
  return Card(
    elevation: 5,
    child: TextFormField(
      obscureText:passwrd ,

      textAlign: TextAlign.right,
      textAlignVertical: TextAlignVertical.center ,
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
        if (val.toString()
            .trim()
            .length < smallerValue || val.isEmpty) {
          return validationifText;
        } else if (val.toString()
            .trim()
            .length > largerElseValue) {
          return validationElseText;

        } else {
          return null;
        }
      },
      onSaved: (val) => valTxt = val  ,
    ),
  );

}


Card crdRedTxtFrmFldforIntegerorg({String hinttxt,
  TextEditingController cntrTxt,
  int valTxt,
  String validationifText ,
  String validationElseText,
  int LargerElseValue,
  int SmallerValue,

  bool Passwrd,

}) {
  return Card(
    elevation: 5,
    child: TextFormField(
      obscureText:Passwrd ,

      textAlign: TextAlign.right,
      textAlignVertical: TextAlignVertical.center ,
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
        if (val
            .trim()
            .length < SmallerValue || val.isEmpty) {
          return validationifText;
        } else if (val
            .trim()
            .length > LargerElseValue) {
          return validationElseText;

        } else {
          return null;
        }
      },
      onSaved: (val) => valTxt = val as int,
    ),
  );

}





Card crdRedTxtFrmFldorg({String hinttxt,
  TextEditingController cntrTxt,
  String valTxt,
  String validationifText ,
  String validationElseText,
  int LargerElseValue,
  int SmallerValue,
  bool Passwrd } ) {
  return Card(
    elevation: 5,
    child: TextFormField(
      obscureText: Passwrd,

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
        if (val
            .trim()
            .length < SmallerValue || val.isEmpty) {
          return validationifText;
        } else if (val
            .trim()
            .length > LargerElseValue) {
          return validationElseText;
        } else {
          return null;
        }
      },
      onSaved: (val) => valTxt = val,
    ),
  );
}