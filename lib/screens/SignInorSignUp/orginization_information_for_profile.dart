import 'package:attayairaq/services/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attayairaq/consts/consts.dart';

class OrgiziationsSignup extends StatefulWidget {
  @override
  _OrgiziationsSignupState createState() => _OrgiziationsSignupState();
}

class _OrgiziationsSignupState extends State<OrgiziationsSignup> {
  final _formkey = GlobalKey<FormState>();
  String orginizationName,
      directorname,
      directorPhoneNo,
      chiefPhoneNo,
      callingOrgCenter,
      province,
      placesDistiribution;

  int orgWorkersNo;
  TextEditingController orgName,
      drctName,
      drctPhoneNo,
      chefPhoNo,
      callOrgCntr,
      prov,
      plsDist,
      orgWrksNo = TextEditingController();
  txt() {
    print("org completed");
  }

  @override
  Widget build(BuildContext context) {
    // for initiliaze size config
    SizeConfig().init(context);
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: SizeConfig.screenWidth * 1,
          height: SizeConfig.screenHeight * 1,
          padding: EdgeInsets.all(6.0),
          child: Center(
            child: ListView(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 85, right: 50),
//                                  child: SvgPicture.asset("assets/icons/family_icon.svg",
////                                    color: const Color(0xFF2356C7),
//                                    height: 150.0,
//                                  ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10.0, top: 28, bottom: 5),
                      child: Text("اكمال تسجيل المعلومات",
                          style: emptyTallRedText),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 30),
                            SizedBox(
                              height: 60.0,
                              child: crdRedTxtFrmFldorg(
                                  valTxt: orginizationName,
                                  cntrTxt: orgName,
                                  hinttxt: 'اسم المنظمة او الفريق التطوعي',
                                  largerElseValue: 30,
                                  smallerValue: 3,
                                  validationifText: 'يرجى ادخال الاسم بالكامل',
                                  validationElseText: 'الاسم طويل جدا',
                                  password: false),
                            ),
                            SizedBox(height: 4),
                            SizedBox(height: 4),
                            SizedBox(
                              height: 60.0,
                              child: crdRedTxtFrmFldorg(
                                valTxt: directorname,
                                cntrTxt: drctName,
                                hinttxt: 'اسم مسؤول المنظمة او الفريق التطوعي',
                                largerElseValue: 12,
                                smallerValue: 0,
                                validationifText: 'اسم المسؤول كبير جدا ',
                                validationElseText: 'ادخل اسم المسؤول',
                                password: false,
                              ),
                            ),
                            SizedBox(height: 4),
                            SizedBox(
                              height: 60.0,
                              child: crdRedTxtFrmFldorg(
                                valTxt: directorPhoneNo,
                                cntrTxt: drctPhoneNo,
                                hinttxt: 'رقم مدير المنظمة او الفريق التطوعي',
                                largerElseValue: 12,
                                smallerValue: 0,
                                validationifText: 'الرقم كبير جدا ',
                                validationElseText: 'ادخل الرقم',
                                password: false,
                              ),
                            ),
                            SizedBox(height: 4),
                            SizedBox(
                              height: 60.0,
                              child: crdRedTxtFrmFldorg(
                                valTxt: callingOrgCenter,
                                cntrTxt: callOrgCntr,
                                hinttxt:
                                    'رقم التواصل مع المنظمة او الفريق التطوعي',
                                largerElseValue: 11,
                                smallerValue: 0,
                                validationifText: 'الرقم كبير جدا ',
                                validationElseText: 'ادخل الرقم',
                                password: false,
                              ),
                            ),
                            SizedBox(height: 4),
                            SizedBox(
                              height: 60.0,
                              child: crdRedTxtFrmFldorg(
                                valTxt: province,
                                cntrTxt: prov,
                                hinttxt: 'المحافظة',
                                largerElseValue: 11,
                                smallerValue: 0,
                                validationifText: 'اسم المحافظة كبير',
                                validationElseText: 'يرجى ادخال اسم المحافظة',
                                password: false,
                              ),
                            ),
                            SizedBox(height: 4),
                            SizedBox(
                              height: 60.0,
                              child: crdRedTxtFrmFldorg(
                                valTxt: placesDistiribution,
                                cntrTxt: plsDist,
                                hinttxt: 'اماكن التوزيع داخل المحافظة',
                                largerElseValue: 22,
                                smallerValue: 0,
                                validationifText:
                                    'يرجى ادخال الاسماء باقل من 22 حرف',
                                validationElseText: 'يرجى ادخال اماكن التوزيع',
                                password: false,
                              ),
                            ),
                            SizedBox(height: 4),
                            SizedBox(
                              height: 60.0,
                              child: crdRedTxtFrmFldforIntegerorg(
                                valTxt: orgWorkersNo,
                                cntrTxt: orgWrksNo,
                                hinttxt: 'عدد افراد المنظمة او الفريق التطوعي',
                                largerElseValue: 22,
                                smallerValue: 0,
                                validationifText: 'الرقم كبير جدا ',
                                validationElseText: 'ادخل الرقم',
                                password: false,
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            buttonRedShape(
                              'انشاء الحساب',
                              context,
                              () {
                                print('object');
                              },
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
