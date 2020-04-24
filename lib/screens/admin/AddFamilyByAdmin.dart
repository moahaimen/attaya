import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attayairaq/consts/consts.dart';
import 'package:geolocator/geolocator.dart';

class AddFamilyByAdmin extends StatefulWidget {
  @override
  _AddFamilyByAdminState createState() => _AddFamilyByAdminState();
}

class _AddFamilyByAdminState extends State<AddFamilyByAdmin> {
  final _formkey = GlobalKey<FormState>();
  String fulfamilyName,
      province,
      city,
      phoneno,
      password,
      nearPoint,
      gelocation;
  int familycount;
  TextEditingController familyCount,
      fullfamilyaname,
      prv,
      cty,
      nearPnt,
      phno,
      pswd,
      gloc = TextEditingController();

  sendInofrmationToFireStore() async {
    _formkey.currentState.save();
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    print('Geolocation = ');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: apBar('معلومات العائلة', context),
      body: SafeArea(
        child: Container(
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
                    Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10.0, top: 28, bottom: 5),
                      child: Text(
                        "أضافة عائلة جديدة",
                        style: emptyBlackTextWithShadows,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Form(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 30),
                            SizedBox(
                              height: 60.0,
                              child: crdTxtFrmFld(
                                valTxt: fulfamilyName,
                                cntrTxt: fullfamilyaname,
                                hinttxt: 'اسم العائلة',
                                largerElseValue: 30,
                                smallerValue: 11,
                                validationifText:
                                    'يرجى ادخال الاسم الثلاثي بالكامل',
                                validationElseText: 'الاسم طويل جدا',
                                password: true,
                              ),
                            ),
                            SizedBox(height: 4),
                            SizedBox(
                              height: 60.0,
                              child: crdTxtOldFrmFld(
                                valTxt: province,
                                cntrTxt: prv,
                                hinttxt: 'المحافظة',
                                largerElseValue: 12,
                                smallerValue: 0,
                                validationifText: 'اسم المحافظة كبير جدا ',
                                validationElseText: 'ادخل اسم المحافظة',
                                password: false,
                              ),
                            ),
                            SizedBox(height: 4),
                            SizedBox(
                              height: 60.0,
                              child: crdTxtFrmFld(
                                  valTxt: city,
                                  cntrTxt: cty,
                                  hinttxt: 'المنطقة',
                                  largerElseValue: 22,
                                  smallerValue: 0,
                                  validationifText:
                                      'اسم النقطة الدالة كبير جدا ',
                                  validationElseText: 'ادخل النقطة الدالة',
                                  password: false),
                            ),
                            SizedBox(height: 4),
                            SizedBox(
                              height: 60.0,
                              child: crdTxtFrmFld(
                                  valTxt: nearPoint,
                                  cntrTxt: nearPnt,
                                  hinttxt: 'اقرب نقطة دالة للمنزل',
                                  largerElseValue: 22,
                                  smallerValue: 0,
                                  validationifText:
                                      'اسم النقطة الدالة كبير جدا ',
                                  validationElseText: 'ادخل النقطة الدالة',
                                  password: false),
                            ),
                            SizedBox(
                              height: 120,
                            ),
                            buttonBlueOldShape(
                              'اضافة العائلة',
                              context,
                              sendInofrmationToFireStore(),
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
