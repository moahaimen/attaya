//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:attayairaq/consts/consts.dart';
//import 'package:attayairaq/Home.dart';
//class FamilyAddAprrov extends StatefulWidget {
//  @override
//  _FamilyAddAprrovState createState() => _FamilyAddAprrovState();
//}
//
//class _FamilyAddAprrovState extends State<FamilyAddAprrov> {
//txt () {
//  print ("family added");
//}
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(backgroundColor: Colors.white,
//        appBar: ApBar('معلومات العائلة',context),
//    body: SafeArea(
//      child: Container(
//        padding: EdgeInsets.all(6.0),
//         child: Center(
//           child: ListView(
//              children: <Widget>[
//                Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//
//                    children: <Widget>[
//                      Padding(
//                        padding: EdgeInsets.only(top:10.0),
//
//                              ),
//                      Padding(
//                        padding: EdgeInsets.only(left:10,right: 10.0,
//                            top: 28,bottom: 5),
//                            child: Text("الموافقة على اضافة عائلة جديدة",style:aboutTextstyle),
//                            ),
//          Padding(
//              padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 40),
//              child: Column(
////                  crossAxisAlignment: CrossAxisAlignment.start,
////                  textDirection: TextDirection.rtl,
////                  mainAxisAlignment: MainAxisAlignment.end,
//                  children: <Widget>[
//                    Container(
////                      width: 320,
//                        child: Card(
//
//                          shape: RoundedRectangleBorder(
//                            side: BorderSide(color: Colors.blue, width: 1),
//                            borderRadius: BorderRadius.circular(10.0),
//
//                          ),
//                          margin: EdgeInsets.all(30.0),
//
//                                child: Column(
////                                  mainAxisAlignment: MainAxisAlignment.end,
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: <Widget>[
//
//                                     Padding(
//                                       padding: const EdgeInsets.all(4.0),
//                                       child: Text("اسم العائلة:عائلة ابوحسين",
//                                           textAlign: TextAlign.right,
//                                           textDirection: TextDirection.rtl,
//                                           style:CardBorderTextstyle),
//                                     ),
//                                          Padding(
//                                            padding: const EdgeInsets.all(4.0),
//                                            child: Text("اسم المحافظة:بغداد",
//                                                  textAlign: TextAlign.right,
//                                                  textDirection: TextDirection.rtl,
//                                                  style:CardBorderTextstyle),
//                                          ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(4.0),
//                                       child: Text("اسم المنطقة : حي اكد",
//                                           textAlign: TextAlign.right,
//                                           textDirection: TextDirection.rtl,
//                                           style:CardBorderTextstyle),
//                                     ),
//                                     Padding(
//                                       padding: const EdgeInsets.all(4.0),
//                                       child: Text("اقرب نقطة دالة:سوبر ماركت البركة",
//                                           textAlign: TextAlign.right,
//                                           textDirection: TextDirection.rtl,
//                                           style:CardBorderTextstyle),
//                                     ),
//                                   ],
//                                )
//
//
//
//
//                        )
//
//
//                    ) ],
//
//    )
//
//          )
//                    ]
//    ),
//                SizedBox(height: 80,),
//
//                ButtonBlueShape('اضافة العائلة',context,Home(),
//                    txt()
//                ),
//                SizedBox(height: 20,),
//
//                ButtonBlueShape('رفض العائلة',context,Home(),
//                    txt()
//                )
//     ]
//       )
//    )
//    )
//    )
//    );
//  }
//}
