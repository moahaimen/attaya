import 'package:attayairaq/services/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:attayairaq/consts/consts.dart';
import 'signUpChoice.dart';

class OrgiziationsSignup extends StatefulWidget {
  @override
  _OrgiziationsSignupState createState() => _OrgiziationsSignupState();
}

class _OrgiziationsSignupState extends State<OrgiziationsSignup> {
  final _formkey = GlobalKey<FormState>();
  String orginization_name,
      directorname,
      director_phoneno,
      chief_phoneno,
      calling_org_center,
      province,
      places_distiribution;

  int org_workers_no;
  TextEditingController org_name,
      drctname,
      drct_phoneno,
      chef_phono,
      call_org_cntr,
      prov,
      pls_dist,
      org_wrks_no = TextEditingController();
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
            child: ListView(children: <Widget>[
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: <
                  Widget>[
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
                  child: Text("اكمال تسجيل المعلومات", style: emptyTallRedText),
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
                              valTxt: orginization_name,
                              cntrTxt: org_name,
                              hinttxt: 'اسم المنظمة او الفريق التطوعي',
                              LargerElseValue: 30,
                              SmallerValue: 3,
                              validationifText: 'يرجى ادخال الاسم بالكامل',
                              validationElseText: 'الاسم طويل جدا',
                              Passwrd: false),
                        ),
                        SizedBox(height: 4),
                        SizedBox(height: 4),
                        SizedBox(
                          height: 60.0,
                          child: crdRedTxtFrmFldorg(
                              valTxt: directorname,
                              cntrTxt: drctname,
                              hinttxt: 'اسم مسؤول المنظمة او الفريق التطوعي',
                              LargerElseValue: 12,
                              SmallerValue: 0,
                              validationifText: 'اسم المسؤول كبير جدا ',
                              validationElseText: 'ادخل اسم المسؤول',
                              Passwrd: false),
                        ),
                        SizedBox(height: 4),
                        SizedBox(
                          height: 60.0,
                          child: crdRedTxtFrmFldorg(
                              valTxt: director_phoneno,
                              cntrTxt: drct_phoneno,
                              hinttxt: 'رقم مدير المنظمة او الفريق التطوعي',
                              LargerElseValue: 12,
                              SmallerValue: 0,
                              validationifText: 'الرقم كبير جدا ',
                              validationElseText: 'ادخل الرقم',
                              Passwrd: false),
                        ),
                        SizedBox(height: 4),
                        SizedBox(
                          height: 60.0,
                          child: crdRedTxtFrmFldorg(
                              valTxt: calling_org_center,
                              cntrTxt: call_org_cntr,
                              hinttxt:
                                  'رقم التواصل مع المنظمة او الفريق التطوعي',
                              LargerElseValue: 11,
                              SmallerValue: 0,
                              validationifText: 'الرقم كبير جدا ',
                              validationElseText: 'ادخل الرقم',
                              Passwrd: false),
                        ),
                        SizedBox(height: 4),
                        SizedBox(
                          height: 60.0,
                          child: crdRedTxtFrmFldorg(
                              valTxt: province,
                              cntrTxt: prov,
                              hinttxt: 'المحافظة',
                              LargerElseValue: 11,
                              SmallerValue: 0,
                              validationifText: 'اسم المحافظة كبير',
                              validationElseText: 'يرجى ادخال اسم المحافظة',
                              Passwrd: false),
                        ),
                        SizedBox(height: 4),
                        SizedBox(
                          height: 60.0,
                          child: crdRedTxtFrmFldorg(
                              valTxt: places_distiribution,
                              cntrTxt: pls_dist,
                              hinttxt: 'اماكن التوزيع داخل المحافظة',
                              LargerElseValue: 22,
                              SmallerValue: 0,
                              validationifText:
                                  'يرجى ادخال الاسماء باقل من 22 حرف',
                              validationElseText: 'يرجى ادخال اماكن التوزيع',
                              Passwrd: false),
                        ),
                        SizedBox(height: 4),
                        SizedBox(
                          height: 60.0,
                          child: crdRedTxtFrmFldforIntegerorg(
                              valTxt: org_workers_no,
                              cntrTxt: org_wrks_no,
                              hinttxt: 'عدد افراد المنظمة او الفريق التطوعي',
                              LargerElseValue: 22,
                              SmallerValue: 0,
                              validationifText: 'الرقم كبير جدا ',
                              validationElseText: 'ادخل الرقم',
                              Passwrd: false),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ButtonRedShape(
                            'انشاء الحساب', context, (){print('object');})
                      ],
                    ),
                  ),
                ),
              ]),
            ]),
          )),
    ));
  }
}
