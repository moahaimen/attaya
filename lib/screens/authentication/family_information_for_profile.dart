import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../models/family.dart';
import '../../consts/consts.dart';
import '../../consts/loading.dart';
import '../../models/location.dart';
import '../../services/data_base.dart';
import '../../services/size_config.dart';
import '../../functions/show_overlay.dart';
import '../../services/shered_Preference.dart';
import '../shared/costume_province_dropdwon.dart';

class FamilySignup extends StatefulWidget {
  final FirebaseUser user;
  final String phoneNo;

  const FamilySignup({this.user, this.phoneNo});
  @override
  _FamilySignupState createState() => _FamilySignupState();
}

class _FamilySignupState extends State<FamilySignup> {
  var _selectedProvince = "";
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  bool locationIsEmpty = false;
  LatLng _location;

  final _familyCountController = TextEditingController();
  final _cityController = TextEditingController();
  final _nearPointController = TextEditingController();
  final _fullFamilyaNameController = TextEditingController();

  @override
  void dispose() {
    _familyCountController.dispose();
    _cityController.dispose();
    _nearPointController.dispose();
    _fullFamilyaNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: loading
          ? const Loading()
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
                                      height: 150.0,
                                    ),
                                  ),
                                  Text(
                                    "اكمال تسجيل معلومات العائلة",
                                    style:
                                        emptyRedText.copyWith(fontSize: 23.0),
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
                                    cntrTxt: _fullFamilyaNameController,
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
                                    cntrTxt: _familyCountController,
                                    hinttxt: 'عدد افراد الاسرة',
                                    isNumber: true,
                                    largerElseValue: 2,
                                    smallerValue: 1,
                                    validationifText: 'الرقم غير صحيح',
                                    validationElseText: 'رجاءا ادخل  رقم صحيح',
                                    isBlue: false,
                                  ),
                                  const SizedBox(height: 4),
                                  SelectProvinceDropDwon(
                                    initialValue: _selectedProvince,
                                    onSelectedProvince: (newValue) => setState(
                                        () => _selectedProvince = newValue),
                                  ),
                                  const SizedBox(height: 4),
                                  CrdTxtFrmFld(
                                    cntrTxt: _cityController,
                                    hinttxt: 'المنطقة',
                                    largerElseValue: 22,
                                    smallerValue: 3,
                                    validationifText: 'اسم المنطقة كبير جدا ',
                                    validationElseText: 'ادخل المنطقة',
                                    isBlue: false,
                                  ),
                                  const SizedBox(height: 4),
                                  CrdTxtFrmFld(
                                    cntrTxt: _nearPointController,
                                    hinttxt: 'اقرب نقطة دالة للمنزل',
                                    largerElseValue: 22,
                                    smallerValue: 3,
                                    validationifText:
                                        'اسم النقطة دالة  للمنزل كبير جدا',
                                    validationElseText:
                                        ' ادخل النقطة  دالة للمنزل',
                                    isBlue: false,
                                  ),
                                  const SizedBox(height: 20),
                                  const SizedBox(height: 30),
                                  FlatButton.icon(
                                    onPressed: () => onSelectLocation(
                                      context,
                                      newLocation: (location) {
                                        setState(() {
                                          _location = location ?? _location;
                                        });
                                      },
                                    ),
                                    icon: Image.asset(
                                      'assets/icons/map_pin_1.png',
                                      color: Colors.red,
                                    ),
                                    label: Text(
                                      'تحديد على الخريطة',
                                      style: textStyle,
                                    ),
                                  ),
                                  locationIsEmpty
                                      ? Center(
                                          child: Text(
                                            'الرجاء تحديد الموقع',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )
                                      : Container(),
                                  const SizedBox(height: 20),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        width: SizeConfig.screenWidth * 0.7,
                                        child: buttonRedShape(
                                          'انشاء الحساب',
                                          context,
                                          submmitNewAccount,
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

  void submmitNewAccount() async {
    if (_selectedProvince.isEmpty) {
      showOverlay(context: context, text: 'الرجاء اختيار المحافظة');
    }
    if (_formkey.currentState.validate() && _location != null) {
      final newFamily = Family(
        id: widget.user.uid,
        headOfFamily: _fullFamilyaNameController.text,
        province: _selectedProvince,
        city: _cityController.text,
        phoneNo: widget.phoneNo.replaceAll('+964', '0'),
        location: Location(
          longitude: _location.longitude,
          latitude: _location.latitude,
        ),
        timeStamp: DateTime.now(),
        isNeedHelp: true,
        noOfMembers: int.parse(_familyCountController.text),
        nearestKnownPoint: _nearPointController.text,
      );
      setState(() {
        loading = true;
      });
      try {
        await DatabaseService(widget.user.uid).updateFamilyData(newFamily);
        // navige to the home page
        await SharedPrefs().setUser(
          widget.phoneNo,
          widget.user.uid,
          'family',
        );
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (_) => const Wrapper(isLogedIn: true),
          ),
        );
      } catch (e) {
        await showCostumeDatabaseErrorNotif(e);
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(
            builder: (_) => const Wrapper(isLogedIn: false),
          ),
        );
      }
    } else if (_location == null) {
      setState(() {
        locationIsEmpty = true;
      });
    }
  }
}
