import 'package:attayairaq/consts/loading.dart';
import 'package:attayairaq/models/family.dart';
import 'package:attayairaq/models/location.dart';
import 'package:attayairaq/models/user.dart';
import 'package:attayairaq/screens/HomeScreen.dart';
import 'package:attayairaq/screens/shared/map_screen.dart';
import 'package:attayairaq/services/data_base.dart';
import 'package:attayairaq/services/shered_Preference.dart';
import 'package:attayairaq/services/size_config.dart';
import 'package:attayairaq/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attayairaq/consts/consts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FamilySignup extends StatefulWidget {
  final FirebaseUser user;
  final String phoneNo;

  const FamilySignup({this.user, this.phoneNo});
  @override
  _FamilySignupState createState() => _FamilySignupState();
}

class _FamilySignupState extends State<FamilySignup> {
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  LatLng location;

  final familyCountController = TextEditingController();
  final cityController = TextEditingController();
  final nearPointController = TextEditingController();
  final provinceController = TextEditingController();
  final fullFamilyaNameController = TextEditingController();

  @override
  void dispose() {
    familyCountController.dispose();
    cityController.dispose();
    nearPointController.dispose();
    provinceController.dispose();
    fullFamilyaNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // for initiliaze size config
    SizeConfig().init(context);
    return Scaffold(
      body: loading
          ? Loading()
          : SafeArea(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  width: SizeConfig.screenWidth * 1,
                  height: SizeConfig.screenHeight * 1,
                  padding: EdgeInsets.all(6.0),
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
                                    padding: EdgeInsets.only(bottom: 15),
                                    child: Image.asset(
                                      "assets/icons/family_icon.png",
                                      //color: const Color(0xFF2356C7),
                                      height: 150.0,
                                    ),
                                  ),
                                  Text(
                                    "اكمال تسجيل معلومات العائلة",
                                    style: emptyTallRedText,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 40),
                            child: Form(
                              key: _formkey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                textDirection: TextDirection.rtl,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 30),
                                  SizedBox(
                                    height: 60.0,
                                    child: CrdTxtFrmFld(
                                      cntrTxt: fullFamilyaNameController,
                                      hinttxt: 'اسم رب العائلة: الاسم الثلاثي',
                                      largerElseValue: 30,
                                      smallerValue: 11,
                                      validationifText:
                                          'يرجى ادخال الاسم الثلاثي بالكامل',
                                      validationElseText: 'الاسم طويل جدا',
                                      isBlue: false,
                                      isNumber: false,
                                      password: false,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  SizedBox(
                                    height: 60.0,
                                    child: CrdTxtFrmFld(
                                      cntrTxt: familyCountController,
                                      hinttxt: 'عدد افراد العائلة',
                                      largerElseValue: 5,
                                      smallerValue: 0,
                                      validationifText: 'عدد الافراد كبير جدا ',
                                      validationElseText: 'اكتب عدد الافراد',
                                      isBlue: false,
                                      isNumber: true,
                                      password: false,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  SizedBox(
                                    height: 60.0,
                                    child: CrdTxtFrmFld(
                                      cntrTxt: provinceController,
                                      hinttxt: 'المحافظة',
                                      largerElseValue: 12,
                                      smallerValue: 3,
                                      validationifText: 'اسم المحافظة كبير جد',
                                      validationElseText: 'ادخل اسم المحافظة',
                                      isBlue: false,
                                      isNumber: false,
                                      password: false,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  SizedBox(
                                    height: 60.0,
                                    child: CrdTxtFrmFld(
                                      cntrTxt: cityController,
                                      hinttxt: 'المنطقة',
                                      largerElseValue: 22,
                                      smallerValue: 3,
                                      validationifText: 'اسم المنطقة كبير جدا ',
                                      validationElseText: 'ادخل المنطقة',
                                      password: false,
                                      isBlue: false,
                                      isNumber: false,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  SizedBox(
                                    height: 60.0,
                                    child: CrdTxtFrmFld(
                                      cntrTxt: nearPointController,
                                      hinttxt: 'اقرب نقطة دالة للمنزل',
                                      largerElseValue: 22,
                                      smallerValue: 3,
                                      validationifText:
                                          'اسم النقطة دالة  للمنزل كبير جدا',
                                      validationElseText:
                                          ' ادخل النقطة  دالة للمنزل',
                                      password: false,
                                      isBlue: false,
                                      isNumber: false,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  SizedBox(height: 30),
                                  FlatButton.icon(
                                    onPressed: () async {
                                      location =
                                          await Navigator.of(context).push(
                                        CupertinoPageRoute(
                                          builder: (c) => MapScreen(
                                            isNotSupScreen: false,
                                            isSelectLocation: true,
                                            isOrg: false,
                                          ),
                                        ),
                                      );
                                    },
                                    icon: Image.asset(
                                      'assets/icons/map_pin_1.png',
                                      color: Colors.red,
                                    ),
                                    label: Text(
                                      'تحديد على الخريطة',
                                      style: textStyle,
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        width: SizeConfig.screenWidth * 0.7,
                                        child: buttonRedShape(
                                          'انشاء الحساب',
                                          context,
                                          () async {
                                            if (_formkey.currentState
                                                .validate()) {
                                              final Family newFamily = Family(
                                                id: widget.user.uid,
                                                headOfFamily:
                                                    fullFamilyaNameController
                                                        .text,
                                                province:
                                                    provinceController.text,
                                                city: cityController.text,
                                                phoneNo: widget.phoneNo,
                                                location: Location(
                                                  longitude: location.longitude,
                                                  latitude: location.latitude,
                                                ),
                                                timeStamp: DateTime.now(),
                                                isNeedHelp: true,
                                                noOfMembers: int.parse(
                                                    familyCountController.text),
                                                nearestKnownPoint:
                                                    nearPointController.text,
                                              );
                                              setState(() {
                                                loading = true;
                                              });

                                              await DatabaseService(
                                                      widget.user.uid)
                                                  .updateFamilyData(newFamily);
                                              // navige to the home page
                                              await SharedPrefs().setUser(
                                                widget.phoneNo,
                                                widget.user.uid,
                                                'family',
                                              );
                                              print('ctx');
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                CupertinoPageRoute(
                                                  builder: (_) => Wrapper(
                                                    child: HomeScreen(
                                                      user: User(
                                                        uid: widget.user.uid,
                                                        phoneNo: widget.phoneNo,
                                                        userType:
                                                            UserType.family,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
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
