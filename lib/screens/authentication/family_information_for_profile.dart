import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../models/user.dart';
import '../../models/family.dart';
import '../../consts/consts.dart';
import '../../consts/loading.dart';
import '../../models/location.dart';
import '../../services/data_base.dart';
import '../../screens/HomeScreen.dart';
import '../../services/size_config.dart';
import '../../screens/shared/map_screen.dart';
import '../../services/shered_Preference.dart';
import '../../screens/authentication/authenticate.dart';

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

  final TextEditingController familyCountController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController nearPointController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController fullFamilyaNameController =
      TextEditingController();

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
                  padding: const EdgeInsets.all(6.0),
                  child: ListView(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(top: 10.0),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 15),
                                    child: Image.asset(
                                      "assets/icons/family_icon.png",
                                      //color: const Color(0xFF2356C7),
                                      height: 150.0,
                                    ),
                                  ),
                                  const Text(
                                    "اكمال تسجيل معلومات العائلة",
                                    style: emptyTallRedText,
                                  ),
                                ],
                              )
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Form(
                              key: _formkey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                textDirection: TextDirection.rtl,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const SizedBox(height: 30),
                                  CrdTxtFrmFld(
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
                                  const SizedBox(height: 4),
                                  CrdTxtFrmFld(
                                    cntrTxt: familyCountController,
                                    hinttxt: 'عدد افراد الاسرة',
                                    isNumber: true,
                                    largerElseValue: 2,
                                    smallerValue: 1,
                                    validationifText: 'الرقم غير صحيح',
                                    validationElseText: 'رجاءا ادخل  رقم صحيح',
                                    isBlue: false,
                                  ),
                                  const SizedBox(height: 4),
                                  CrdTxtFrmFld(
                                    cntrTxt: provinceController,
                                    hinttxt: 'المحافظة',
                                    largerElseValue: 12,
                                    smallerValue: 3,
                                    validationifText: 'اسم المحافظة كبير جد',
                                    validationElseText: 'ادخل اسم المحافظة',
                                    isBlue: false,
                                  ),
                                  const SizedBox(height: 4),
                                  CrdTxtFrmFld(
                                    cntrTxt: cityController,
                                    hinttxt: 'المنطقة',
                                    largerElseValue: 22,
                                    smallerValue: 3,
                                    validationifText: 'اسم المنطقة كبير جدا ',
                                    validationElseText: 'ادخل المنطقة',
                                    isBlue: false,
                                  ),
                                  const SizedBox(height: 4),
                                  CrdTxtFrmFld(
                                    cntrTxt: nearPointController,
                                    hinttxt: 'اقرب نقطة دالة للمنزل',
                                    largerElseValue: 22,
                                    smallerValue: 3,
                                    validationifText:
                                        'اسم النقطة دالة  للمنزل كبير جدا',
                                    validationElseText:
                                        ' ادخل النقطة  دالة للمنزل',
                                    isBlue: false,
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const SizedBox(height: 30),
                                  FlatButton.icon(
                                    onPressed: () async {
                                      location =
                                          await Navigator.of(context).push(
                                        CupertinoPageRoute(
                                          builder: (c) => const MapScreen(
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
                                  const SizedBox(
                                    height: 20,
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
                                              final newFamily = Family(
                                                id: widget.user.uid,
                                                headOfFamily:
                                                    fullFamilyaNameController
                                                        .text,
                                                province:
                                                    provinceController.text,
                                                city: cityController.text,
                                                phoneNo:
                                                    widget.phoneNo.substring(4),
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
                                              try {
                                                await DatabaseService(
                                                        widget.user.uid)
                                                    .updateFamilyData(
                                                        newFamily);
                                                // navige to the home page
                                                await SharedPrefs().setUser(
                                                  widget.phoneNo,
                                                  widget.user.uid,
                                                  'family',
                                                );
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  CupertinoPageRoute(
                                                    builder: (_) => Wrapper(
                                                      child: HomeScreen(
                                                        user: User(
                                                          uid: widget.user.uid,
                                                          phoneNo:
                                                              widget.phoneNo,
                                                          userType:
                                                              UserType.family,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } catch (e) {
                                                await showCostumeDatabaseErrorNotif(
                                                    e);
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  CupertinoPageRoute(
                                                    builder: (_) => Wrapper(
                                                      child: Authenticate(),
                                                    ),
                                                  ),
                                                );
                                              }
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
