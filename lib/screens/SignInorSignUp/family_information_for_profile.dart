import 'package:attayairaq/functions/geoloacater/geo.dart';
import 'package:attayairaq/screens/SignInorSignUp/HomeScreen.dart';
import 'package:attayairaq/services/firestore_operations.dart';
import 'package:attayairaq/services/shared_preferences.dart';
import 'package:attayairaq/services/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:attayairaq/consts/consts.dart';
import 'package:geolocator/geolocator.dart';

class FamilySignup extends StatefulWidget {
  @override
  _FamilySignupState createState() => _FamilySignupState();
}

class _FamilySignupState extends State<FamilySignup> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final _formkey = GlobalKey<FormState>();
  String fulfamily_name,
      province,
      city,
      phoneno,
      password,
      nearPoint,
      gelocation = "";
  int familycount = 0;
  final familyCount = new TextEditingController();
  final cty = new TextEditingController();
  final nearPnt = new TextEditingController();
  final phno = new TextEditingController();
  final pswd = new TextEditingController();
  final gloc = new TextEditingController();
  final prv = new TextEditingController();
  final fullfamilyaname = new TextEditingController();

  sendInofrmationToFireStore() async {
    _formkey.currentState.save();
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    print('Geolocation = ');
  }

  FireStoreOperations firestore = new FireStoreOperations();
  @override
  Widget build(BuildContext context) {
    // for initiliaze size config
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
          child: Container(
        width: SizeConfig.screenWidth * 1,
        height: SizeConfig.screenHeight * 1,
        padding: EdgeInsets.all(6.0),
        child: ListView(children: <Widget>[
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
              Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: SvgPicture.asset(
                        "assets/icons/family_icon.svg",
                        //color: const Color(0xFF2356C7),
                        height: 150.0,
                      ),
                    ),
                    Text("اكمال تسجيل معلومات العائلة",
                        style: emptyTallRedText),
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
                      child: crdRedTxtFrmFld(
                          valTxt: fulfamily_name,
                          cntrTxt: fullfamilyaname,
                          hinttxt: 'اسم رب العائلة: الاسم الثلاثي',
                          largerElseValue: 30,
                          smallerValue: 11,
                          validationElseText:
                              'يرجى ادخال الاسم الثلاثي بالكامل',
                          validationifText: 'الاسم طويل جدا',
                          passwrd: false),
                    ),
                    SizedBox(height: 4),
                    SizedBox(
                      height: 60.0,
                      child: crdRedTxtFrmFldforInteger(
                          valTxt: familycount.toString(),
                          cntrTxt: familyCount,
                          hinttxt: 'عدد افراد العائلة',
                          largerElseValue: 5,
                          smallerValue: 0,
                          validationifText: 'عدد الافراد كبير جدا ',
                          validationElseText: 'اكتب عدد الافراد',
                          passwrd: false),
                    ),
                    SizedBox(height: 4),
                    SizedBox(
                      height: 60.0,
                      child: crdRedTxtFrmFld(
                          valTxt: province,
                          cntrTxt: prv,
                          hinttxt: 'المحافظة',
                          largerElseValue: 12,
                          smallerValue: 3,
                          validationifText: 'اسم المحافظة كبير جد',
                          validationElseText: 'ادخل اسم المحافظة',
                          passwrd: false),
                    ),
                    SizedBox(height: 4),
                    SizedBox(
                      height: 60.0,
                      child: crdRedTxtFrmFld(
                          valTxt: city,
                          cntrTxt: cty,
                          hinttxt: 'المنطقة',
                          largerElseValue: 22,
                          smallerValue: 3,
                          validationifText: 'اسم النقطة الدالة كبير جدا ',
                          validationElseText: 'ادخل النقطة الدالة',
                          passwrd: false),
                    ),
                    SizedBox(height: 4),
                    SizedBox(
                      height: 60.0,
                      child: crdRedTxtFrmFld(
                          valTxt: nearPoint,
                          cntrTxt: nearPnt,
                          hinttxt: 'اقرب نقطة دالة للمنزل',
                          largerElseValue: 22,
                          smallerValue: 3,
                          validationifText: 'اسم النقطة دالة  للمنزل كبير جدا',
                          validationElseText: ' ادخل النقطة  دالة للمنزل',
                          passwrd: false),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        ButtonRedShape('انشاء الحساب', context, () async {
                          if (_formkey.currentState.validate()) {
                            _formkey.currentState.save();

                            print('hello');
                            final myloc = await mylocation();

                            print(myloc.latitude);
                            final user_info =
                                await SharedPreferencesOperations().get_user();

                            Map<String, dynamic> family_data = {
                              'city': cty.text,
                              'user_id': user_info[0].toString(),
                              'phone': user_info[1].toString(),
                              'family_name': fullfamilyaname.text,
                              'near_point': nearPnt.text,
                              'longitude': myloc.longitude.toString(),
                              'latitude': myloc.latitude.toString(),
                              'family_count': familyCount.text,
                              'province': prv.text,
                            };

                            final value =
                                await firestore.createFamilyRecord(family_data);

                            // for make a snackbar for give the user a message if he is resitreg or not
                            _scaffoldKey.currentState.showSnackBar(
                              new SnackBar(
                                duration: new Duration(seconds:5),
                                content: new Text('$value'),
                              ),
                            );

                            // navige to the home page

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      HomeScreen(), //user: user,)
                                ));
                          } else {
                            print('form not valid');
                          }
                        }),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ]),
        ]),
      )),
    );
  }
}
