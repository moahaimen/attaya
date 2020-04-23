//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_svg/flutter_svg.dart';
//import 'package:attayairaq/consts/consts.dart';
//import 'package:geolocator/geolocator.dart';
//import 'package:attayairaq/Home.dart';
//
//
//class addFamilyByOrg extends StatefulWidget {
//  @override
//  _addFamilyByOrgState createState() => _addFamilyByOrgState();
//}
//
//class _addFamilyByOrgState extends State<addFamilyByOrg> {
//  final _formkey = GlobalKey <FormState>();
//  String fulfamily_name,province,city,phoneno,password,nearPoint,gelocation;
//  int familycount ;
//  TextEditingController  familyCount,fullfamilyaname,prv,cty,nearPnt,phno,pswd,gloc =TextEditingController();
//
//  sendInofrmationToFireStore () async{
//    _formkey.currentState.save();
//    Position position = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//
//    print('Geolocation = ');
//  }
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: ApBar('معلومات العائلة',context),
//        body: SafeArea(
//          child: Container(
//              padding: EdgeInsets.all(6.0),
//              child: Center(
//                child: ListView(
//                    children: <Widget>[
//                      Column(
//                          crossAxisAlignment: CrossAxisAlignment.center,
//
//                          children: <Widget>[
//                            Padding(
//                              padding: EdgeInsets.only(top:10.0),
//
//                            ),
//                            Padding(
//                              padding: EdgeInsets.only(left:10,right: 10.0,
//                                  top: 28,bottom: 5),
//                              child: Text("أضافة عائلة جديدة",style:emptyBlackTextWithShadows),
//                            ),
//                            Padding(
//                              padding:  EdgeInsets.symmetric(horizontal: 10),
//                              child: Form(
//                                child: Column(
//                                  crossAxisAlignment: CrossAxisAlignment.start,
//                                  textDirection: TextDirection.rtl,
//                                  mainAxisAlignment: MainAxisAlignment.center,
//                                  children: <Widget>[
//
//                                    SizedBox(height: 30),
//
//                                    SizedBox(
//                                      height: 60.0,
//
//                                      child:
//                                      crdTxtFrmFld(
//                                          valTxt: fulfamily_name,
//                                          cntrTxt: fullfamilyaname,
//                                          hinttxt: 'اسم العائلة',
//                                          LargerElseValue: 30,
//                                          SmallerValue: 11,
//                                          validationifText: 'يرجى ادخال الاسم الثلاثي بالكامل',
//                                          validationElseText: 'الاسم طويل جدا',
//                                          Passwrd: false
//                                      ),
//                                    ),
//
//                                    SizedBox(height: 4),
//
//
//                                    SizedBox(
//                                      height: 60.0,
//
//                                      child:
//                                      crdTxtFrmFld(
//                                          valTxt: province,
//                                          cntrTxt: prv,
//                                          hinttxt: 'المحافظة',
//                                          LargerElseValue: 12,
//                                          SmallerValue: 0,
//                                          validationifText: 'اسم المحافظة كبير جدا ',
//                                          validationElseText: 'ادخل اسم المحافظة',
//                                          Passwrd: false
//                                      ),
//                                    ),
//                                    SizedBox(height: 4),
//                                    SizedBox(
//                                      height: 60.0,
//
//                                      child:
//                                      crdTxtFrmFld(                                          valTxt: city,
//                                          cntrTxt: cty,
//                                          hinttxt: 'المنطقة',
//                                          LargerElseValue: 22,
//                                          SmallerValue: 0,
//                                          validationifText: 'اسم النقطة الدالة كبير جدا ',
//                                          validationElseText: 'ادخل النقطة الدالة',
//                                          Passwrd: false
//                                      ),
//                                    ),
//                                    SizedBox(height: 4),
//                                    SizedBox(
//                                      height: 60.0,
//                                      child:
//                                      crdTxtFrmFld(
//                                          valTxt: nearPoint,
//                                          cntrTxt: nearPnt,
//                                          hinttxt: 'اقرب نقطة دالة للمنزل',
//                                          LargerElseValue: 22,
//                                          SmallerValue: 0,
//                                          validationifText: 'اسم النقطة الدالة كبير جدا ',
//                                          validationElseText: 'ادخل النقطة الدالة',
//                                          Passwrd: false
//                                      ),
//                                    ),
//                                    SizedBox(height: 120,),
//
//                                    ButtonBlueShape('اضافة العائلة',context,Home()
//                                        ,sendInofrmationToFireStore()
//                                    )
//                                  ],
//                                ),
//                              ),
//                            ),
//                          ]     ),
//                    ] ),
//              )
//          ),
//        ));
//  }
//}