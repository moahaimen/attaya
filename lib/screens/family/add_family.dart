import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../models/family.dart';
import '../../consts/consts.dart';
import '../../models/request.dart';
import '../../consts/loading.dart';
import '../../models/location.dart';
import '../../services/data_base.dart';
import '../../services/send_request.dart';
import '../../functions/show_overlay.dart';
import '../shared/costume_province_dropdwon.dart';

class AddFamily extends StatefulWidget {
  final bool isAdmin;
  final LatLng location;

  const AddFamily({
    @required this.isAdmin,
    this.location,
  });

  @override
  _AddFamilyState createState() => _AddFamilyState();
}

class _AddFamilyState extends State<AddFamily> {
  var _selectedProvince = "";
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  bool locationIsEmpty = false;
  LatLng _location;

  final TextEditingController headOfFamilyController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController nearPointController = TextEditingController();
  final TextEditingController phoneNoController = TextEditingController();
  final TextEditingController familyCountController = TextEditingController();

  @override
  void didChangeDependencies() {
    if (widget.location != null) _location = widget.location;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    familyCountController.dispose();
    cityController.dispose();
    headOfFamilyController.dispose();
    nearPointController.dispose();
    phoneNoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: apBar('معلومات العائلة', context),
      body: loading
          ? const Loading()
          : Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                padding: const EdgeInsets.all(6.0),
                child: Center(
                  child: ListView(
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(top: 10.0),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 10, right: 10.0, top: 28, bottom: 5),
                            child: Text(
                              "أضافة عائلة جديدة",
                              style: emptyBlackTextWithShadows,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Form(
                              key: _formkey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                textDirection: TextDirection.rtl,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const SizedBox(height: 30),
                                  CrdTxtFrmFld(
                                    cntrTxt: headOfFamilyController,
                                    hinttxt: 'اسم رب الاسرة',
                                    largerElseValue: 22,
                                    smallerValue: 5,
                                    validationifText: 'الاسم قصير جدا',
                                    validationElseText: 'الاسم طويل جدا',
                                  ),
                                  const SizedBox(height: 4),
                                  CrdTxtFrmFld(
                                    cntrTxt: phoneNoController,
                                    hinttxt: 'رقم الهاتف',
                                    isNumber: true,
                                    largerElseValue: 12,
                                    smallerValue: 11,
                                    validationifText: 'الرقم غير صحيح',
                                    validationElseText: 'رجاءا ادخل رقم الهاتف',
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
                                  ),
                                  const SizedBox(height: 4),
                                  SelectProvinceDropDwon(
                                    initialValue: _selectedProvince,
                                    onSelectedProvince: (newValue) => setState(
                                        () => _selectedProvince = newValue),
                                    isBlue: true,
                                  ),
                                  const SizedBox(height: 4),
                                  CrdTxtFrmFld(
                                    cntrTxt: cityController,
                                    hinttxt: 'المنطقة',
                                    largerElseValue: 22,
                                    smallerValue: 4,
                                    validationElseText:
                                        'اسم النقطة الدالة كبير جدا ',
                                    validationifText: 'ادخل النقطة الدالة',
                                  ),
                                  const SizedBox(height: 4),
                                  CrdTxtFrmFld(
                                    cntrTxt: nearPointController,
                                    hinttxt: 'اقرب نقطة دالة للمنزل',
                                    largerElseValue: 100,
                                    smallerValue: 5,
                                    validationElseText:
                                        'اسم النقطة الدالة كبير جدا ',
                                    validationifText: 'الاسم قصير جدا',
                                  ),
                                  const SizedBox(height: 30),
                                  FlatButton.icon(
                                      onPressed: () => onSelectLocation(
                                            context,
                                            newLocation: (location) {
                                              setState(() {
                                                _location = location;
                                              });
                                            },
                                          ),
                                      icon: Image.asset(
                                        'assets/icons/map_pin_1.png',
                                        color: Colors.red,
                                      ),
                                      label: Text(
                                        _location == null
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
                                  const SizedBox(height: 30),
                                  buttonBlueShape(
                                    'اضافة العائلة',
                                    context,
                                    onAddPressed,
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

  void onAddPressed() async {
    if (_selectedProvince.isEmpty) {
      showOverlay(context: context, text: 'الرجاء اختيار المحافظة');
    }
    if (_formkey.currentState.validate() && _location != null) {
      final _family = Family(
        id: Uuid().v4(),
        headOfFamily: headOfFamilyController.text,
        province: _selectedProvince,
        city: cityController.text,
        phoneNo: phoneNoController.text,
        location: Location(
          longitude: _location.longitude,
          latitude: _location.latitude,
        ),
        timeStamp: DateTime.now(),
        isNeedHelp: true,
        noOfMembers: int.parse(familyCountController.text),
        nearestKnownPoint: nearPointController.text,
      );
      setState(() {
        loading = true;
      });
      try {
        if (widget.isAdmin) {
          await DatabaseService(_family.id).updateFamilyData(_family);

          showOverlay(context: context, text: 'تم اضافة العائلة');
        } else {
          final org = await DatabaseService('').getOrganizationData();

          await requestAddFamily(
            Request(
              id: Uuid().v4(),
              orgThatRequested: org.name,
              deleteReason: null,
              theFamily: _family,
              isDeleteRequest: false,
            ),
          );
          showOverlay(context: context, text: 'تم ارسال طلب الى الادمن');
        }
      } catch (e) {
        await showCostumeDatabaseErrorNotif(e);
      }

      Navigator.of(context).pop();
    } else if (_location == null) {
      setState(() {
        locationIsEmpty = true;
      });
    }
  }
}
