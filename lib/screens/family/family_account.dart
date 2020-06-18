import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../consts/consts.dart';
import '../../models/family.dart';
import '../../consts/loading.dart';
import '../../models/location.dart';
import '../../services/data_base.dart';
import '../../functions/show_overlay.dart';
import '../shared/costume_province_dropdwon.dart';

class FamilyAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final familyData = Provider.of<Family>(context);

    return familyData == null
        ? const Loading()
        : ListView(
            children: <Widget>[
              const SizedBox(height: 25),
              Text(
                familyData.headOfFamily,
                style: textStyle.copyWith(
                  fontSize: 25,
                  color: const Color.fromRGBO(19, 15, 64, 1),
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: const Color.fromRGBO(35, 68, 199, 0.86), width: 3),
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: const EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Text(
                      'رب الاسرة: ${familyData.headOfFamily}',
                      style: textStyle,
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'رقم التواصل: ${familyData.phoneNo}',
                      style: textStyle,
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'عدد افراد العائلة: ${familyData.noOfMembers} اشخاص',
                      style: textStyle,
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'المحافظة: ${familyData.province}',
                      style: textStyle,
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'المنطقة: ${familyData.city}',
                      style: textStyle,
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'اقرب نقطة دالة: ${familyData.nearestKnownPoint}',
                      style: textStyle,
                    ),
                    const SizedBox(height: 25),
                    Text(
                      'حالة العائلة: ${familyData.isNeedHelp ? 'تطلب مساعدة' : 'لا  تطلب مساعدة'}',
                      style: textStyle,
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Image.asset(
                            'assets/icons/edit_icon.png',
                            width: 25,
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => EditFamilyAccount(
                                  familyData: familyData,
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          );
  }
}

class EditFamilyAccount extends StatefulWidget {
  final Family familyData;
  const EditFamilyAccount({@required this.familyData});

  @override
  _EditFamilyAccountState createState() => _EditFamilyAccountState();
}

class _EditFamilyAccountState extends State<EditFamilyAccount> {
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  bool locationIsEmpty = false;
  bool dataLoaded = false;
  String _selectedProvince = '';
  LatLng _location;

  TextEditingController headOfFamilyController;
  TextEditingController cityController;
  TextEditingController nearPointController;
  TextEditingController phoneNoController;
  TextEditingController familyCountController;

  @override
  void didChangeDependencies() {
    if (!dataLoaded) {
      headOfFamilyController =
          TextEditingController(text: widget.familyData.headOfFamily);
      cityController = TextEditingController(text: widget.familyData.city);
      _selectedProvince = widget.familyData.province;
      nearPointController =
          TextEditingController(text: widget.familyData.nearestKnownPoint);
      familyCountController =
          TextEditingController(text: widget.familyData.noOfMembers.toString());
      phoneNoController =
          TextEditingController(text: widget.familyData.phoneNo);

      _location = LatLng(widget.familyData.location.latitude,
          widget.familyData.location.longitude);
    }

    dataLoaded = true;

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
      appBar: apBar('تعديل معلومات العائلة', context),
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
                                    largerElseValue: 22,
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
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  buttonBlueShape(
                                    'تحديث المعلومات',
                                    context,
                                    onUpdatePressed,
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

  void onUpdatePressed() async {
    if (_selectedProvince.isEmpty) {
      showOverlay(context: context, text: 'الرجاء اختيار المحافظة');
    }
    if (_formkey.currentState.validate()) {
      final _family = Family(
        id: widget.familyData.id,
        headOfFamily: headOfFamilyController.text,
        province: _selectedProvince,
        city: cityController.text,
        phoneNo: phoneNoController.text,
        location: Location(
          longitude: _location.longitude,
          latitude: _location.latitude,
        ),
        timeStamp: DateTime.now(),
        isNeedHelp: widget.familyData.isNeedHelp,
        noOfMembers: int.parse(familyCountController.text),
        nearestKnownPoint: nearPointController.text,
      );
      setState(() {
        loading = true;
      });
      try {
        await DatabaseService(_family.id).updateFamilyData(_family);

        showOverlay(context: context, text: 'تم تحديث معلومات العائلة');
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
