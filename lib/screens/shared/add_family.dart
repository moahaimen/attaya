import 'package:attayairaq/models/family.dart';
import 'package:attayairaq/models/location.dart';
import 'package:attayairaq/services/family_sevices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attayairaq/consts/consts.dart';
import 'package:uuid/uuid.dart';

class AddFamily extends StatefulWidget {
  final bool isAdmin;

  const AddFamily({this.isAdmin});

  @override
  _AddFamilyState createState() => _AddFamilyState();
}

class _AddFamilyState extends State<AddFamily> {
  final _formkey = GlobalKey<FormState>();
  String headOfFamily, province, city, phoneno, nearPoint, gelocation;
  int familycount;
  TextEditingController familyCountController,
      headOfFamilyController,
      prvinceController,
      cityController,
      nearPointController,
      phoneNoController,
      passwordController,
      gloc = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: apBar('معلومات العائلة', context, false),
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
                        key: _formkey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          textDirection: TextDirection.rtl,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            SizedBox(height: 30),
                            crdTxtFrmFld(
                              valTxt: phoneno,
                              cntrTxt: phoneNoController,
                              hinttxt: 'اسم رب الاسرة',
                              largerElseValue: 22,
                              smallerValue: 5,
                              validationifText: 'الاسم قصير جدا',
                              validationElseText: 'الاسم طويل جدا',
                              password: false,
                            ),
                            SizedBox(height: 4),
                            crdTxtFrmFld(
                              valTxt: phoneno,
                              cntrTxt: phoneNoController,
                              hinttxt: 'رقم الهاتف',
                              largerElseValue: 12,
                              smallerValue: 11,
                              validationifText: 'الرقم غير صحيح',
                              validationElseText: 'رجاءا ادخل رقم الهاتف',
                              password: false,
                            ),
                            SizedBox(height: 4),
                            crdTxtFrmFld(
                              valTxt: phoneno,
                              cntrTxt: phoneNoController,
                              hinttxt: 'عدد افراد الاسرة',
                              largerElseValue: 2,
                              smallerValue: 1,
                              validationifText: 'الرقم غير صحيح',
                              validationElseText: 'رجاءا ادخل  رقم صحيح',
                              password: false,
                            ),
                            SizedBox(height: 4),
                            crdTxtFrmFld(
                              valTxt: province,
                              cntrTxt: prvinceController,
                              hinttxt: 'المحافظة',
                              largerElseValue: 12,
                              smallerValue: 4,
                              validationElseText: 'اسم المحافظة كبير جدا ',
                              validationifText: 'الاسم غير صحيح',
                              password: false,
                            ),
                            SizedBox(height: 4),
                            crdTxtFrmFld(
                              valTxt: city,
                              cntrTxt: cityController,
                              hinttxt: 'المنطقة',
                              largerElseValue: 22,
                              smallerValue: 4,
                              validationElseText: 'اسم النقطة الدالة كبير جدا ',
                              validationifText: 'ادخل النقطة الدالة',
                              password: false,
                            ),
                            SizedBox(height: 4),
                            crdTxtFrmFld(
                              valTxt: nearPoint,
                              cntrTxt: nearPointController,
                              hinttxt: 'اقرب نقطة دالة للمنزل',
                              largerElseValue: 22,
                              smallerValue: 5,
                              validationElseText: 'اسم النقطة الدالة كبير جدا ',
                              validationifText: 'الاسم قصير جدا',
                              password: false,
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            buttonBlueOldShape(
                              'اضافة العائلة',
                              context,
                              () async {
                                if (_formkey.currentState.validate()) {
                                  await addFamily(
                                    Family(
                                      id: Uuid().v4(),
                                      headOfFamily: headOfFamily,
                                      province: province,
                                      city: city,
                                      phoneNo: phoneno,
                                      location: Location(
                                          longitude: null, latitude: null),
                                      timeStamp: DateTime.now(),
                                      isNeedHelp: true,
                                      isApprovedFromAdmin:
                                          widget.isAdmin ? true : false,
                                      noOffamilyMembers: familycount,
                                      nearestKnownPoint: nearPoint,
                                    ),
                                  );
                                }
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
