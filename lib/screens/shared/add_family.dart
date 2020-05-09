import 'package:attayairaq/consts/loading.dart';
import 'package:attayairaq/functions/show_overlay.dart';
import 'package:attayairaq/models/family.dart';
import 'package:attayairaq/models/location.dart';
import 'package:attayairaq/models/request.dart';
import 'package:attayairaq/screens/shared/map_screen.dart';
import 'package:attayairaq/services/family_sevices.dart';
import 'package:attayairaq/services/organization_srvices.dart';
import 'package:attayairaq/services/send_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attayairaq/consts/consts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class AddFamily extends StatefulWidget {
  final bool isAdmin;

  const AddFamily({this.isAdmin});

  @override
  _AddFamilyState createState() => _AddFamilyState();
}

class _AddFamilyState extends State<AddFamily> {
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  bool locationIsEmpty = false;
  LatLng location;

  final headOfFamilyController = TextEditingController();
  final provinceController = TextEditingController();
  final cityController = TextEditingController();
  final nearPointController = TextEditingController();
  final phoneNoController = TextEditingController();
  final familyCountController = TextEditingController();

  @override
  void dispose() {
    familyCountController.dispose();
    cityController.dispose();
    headOfFamilyController.dispose();
    nearPointController.dispose();
    phoneNoController.dispose();
    provinceController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: apBar('معلومات العائلة', context),
      body: loading
          ? Loading()
          : Directionality(
              textDirection: TextDirection.rtl,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                textDirection: TextDirection.rtl,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SizedBox(height: 30),
                                  CrdTxtFrmFld(
                                    cntrTxt: headOfFamilyController,
                                    hinttxt: 'اسم رب الاسرة',
                                    largerElseValue: 22,
                                    smallerValue: 5,
                                    validationifText: 'الاسم قصير جدا',
                                    validationElseText: 'الاسم طويل جدا',
                                    password: false,
                                  ),
                                  SizedBox(height: 4),
                                  CrdTxtFrmFld(
                                    cntrTxt: phoneNoController,
                                    hinttxt: 'رقم الهاتف',
                                    isNumber: true,
                                    largerElseValue: 12,
                                    smallerValue: 11,
                                    validationifText: 'الرقم غير صحيح',
                                    validationElseText: 'رجاءا ادخل رقم الهاتف',
                                    password: false,
                                  ),
                                  SizedBox(height: 4),
                                  CrdTxtFrmFld(
                                    cntrTxt: familyCountController,
                                    hinttxt: 'عدد افراد الاسرة',
                                    isNumber: true,
                                    largerElseValue: 2,
                                    smallerValue: 1,
                                    validationifText: 'الرقم غير صحيح',
                                    validationElseText: 'رجاءا ادخل  رقم صحيح',
                                    password: false,
                                  ),
                                  SizedBox(height: 4),
                                  CrdTxtFrmFld(
                                    cntrTxt: provinceController,
                                    hinttxt: 'المحافظة',
                                    largerElseValue: 12,
                                    smallerValue: 4,
                                    validationElseText:
                                        'اسم المحافظة كبير جدا ',
                                    validationifText: 'الاسم غير صحيح',
                                    password: false,
                                  ),
                                  SizedBox(height: 4),
                                  CrdTxtFrmFld(
                                    cntrTxt: cityController,
                                    hinttxt: 'المنطقة',
                                    largerElseValue: 22,
                                    smallerValue: 4,
                                    validationElseText:
                                        'اسم النقطة الدالة كبير جدا ',
                                    validationifText: 'ادخل النقطة الدالة',
                                    password: false,
                                  ),
                                  SizedBox(height: 4),
                                  CrdTxtFrmFld(
                                    cntrTxt: nearPointController,
                                    hinttxt: 'اقرب نقطة دالة للمنزل',
                                    largerElseValue: 22,
                                    smallerValue: 5,
                                    validationElseText:
                                        'اسم النقطة الدالة كبير جدا ',
                                    validationifText: 'الاسم قصير جدا',
                                    password: false,
                                  ),
                                  SizedBox(height: 30),
                                  FlatButton.icon(
                                      onPressed: () async {
                                        location =
                                            await Navigator.of(context).push(
                                          CupertinoPageRoute(
                                            builder: (c) {
                                              return MapScreen(
                                                isNotSupScreen: false,
                                                isSelectLocation: true,
                                                isOrg: false,
                                              );
                                            },
                                          ),
                                        );
                                        print(location);
                                      },
                                      icon: Image.asset(
                                        'assets/icons/map_pin_1.png',
                                        color: Colors.red,
                                      ),
                                      label: Text(
                                        location == null
                                            ? 'تحديد على الخريطة'
                                            : 'تحديد مرة اخرى',
                                        style: textStyle,
                                      )),
                                  locationIsEmpty
                                      ? Center(
                                          child: Text(
                                            'الرجاء تحديد الموقع',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        )
                                      : Container(),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  buttonBlueOldShape(
                                    'اضافة العائلة',
                                    context,
                                    () async {
                                      if (_formkey.currentState.validate() &&
                                          location != null) {
                                        final _family = Family(
                                          id: Uuid().v4(),
                                          headOfFamily:
                                              headOfFamilyController.text,
                                          province: provinceController.text,
                                          city: cityController.text,
                                          phoneNo: phoneNoController.text,
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
                                        if (widget.isAdmin) {
                                          await addFamily(_family);
                                          showOverlay(
                                              context: context,
                                              text: 'تم اضافة العائلة');
                                        } else {
                                          final org =
                                              await getOrganizationData();

                                          await requestAddFamily(
                                            Request(
                                              id: Uuid().v4(),
                                              orgThatRequested: org.name,
                                              deleteReason: null,
                                              theFamily: _family,
                                              isDeleteRequest: false,
                                            ),
                                          );
                                          showOverlay(
                                              context: context,
                                              text: 'تم ارسال طلب الى الادمن');
                                        }
                                        Navigator.of(context).pop();
                                      } else if (location == null) {
                                        setState(() {
                                          locationIsEmpty = true;
                                        });
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
