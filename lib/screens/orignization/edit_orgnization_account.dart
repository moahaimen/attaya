import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../consts/consts.dart';
import '../../consts/loading.dart';
import '../../models/location.dart';
import '../../services/data_base.dart';
import 'package:flutter/material.dart';
import '../../models/organization.dart';
import '../../services/size_config.dart';
import '../../functions/show_overlay.dart';
import '../../screens/shared/costume_province_dropdwon.dart';

class EditOrganizationAccount extends StatefulWidget {
  final Organization orgData;
  const EditOrganizationAccount({Key key, this.orgData}) : super(key: key);

  @override
  _EditOrganizationAccountState createState() =>
      _EditOrganizationAccountState();
}

class _EditOrganizationAccountState extends State<EditOrganizationAccount> {
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  bool dataLoaded = false;
  String _selectedProvince = '';
  LatLng _location;

  TextEditingController orgName,
      managerNameController,
      managerPhoneNoController,
      phoneNumberController,
      distributionAreaController,
      descriptionController;

  @override
  void didChangeDependencies() {
    if (!dataLoaded) {
      orgName = TextEditingController(text: widget.orgData.name);
      managerNameController =
          TextEditingController(text: widget.orgData.managerName);
      _selectedProvince = widget.orgData.province;
      managerPhoneNoController =
          TextEditingController(text: widget.orgData.managerPhoneNo);
      phoneNumberController =
          TextEditingController(text: widget.orgData.phoneNumber);
      distributionAreaController =
          TextEditingController(text: widget.orgData.distributionArea);

      descriptionController =
          TextEditingController(text: widget.orgData.description);

      _location = LatLng(
        widget.orgData.location.latitude,
        widget.orgData.location.longitude,
      );
    }

    dataLoaded = true;

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    orgName.dispose();
    managerNameController.dispose();
    managerPhoneNoController.dispose();
    phoneNumberController.dispose();
    distributionAreaController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: apBar('تعديل معلومات المنظمة', context),
      body: loading
          ? const Loading()
          : SafeArea(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  width: SizeConfig.screenWidth * 1,
                  height: SizeConfig.screenHeight * 1,
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
                            Row(
                              children: const <Widget>[
                                Padding(
                                  padding: EdgeInsets.only(left: 85, right: 50),
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Form(
                                child: Form(
                                  key: _formkey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    textDirection: TextDirection.rtl,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      const SizedBox(height: 30),
                                      CrdTxtFrmFld(
                                        cntrTxt: orgName,
                                        hinttxt:
                                            'اسم المنظمة او الفريق التطوعي',
                                        largerElseValue: 30,
                                        smallerValue: 3,
                                        validationifText:
                                            'يرجى ادخال الاسم بالكامل',
                                        validationElseText: 'الاسم طويل جدا',
                                      ),
                                      const SizedBox(height: 4),
                                      CrdTxtFrmFld(
                                        cntrTxt: managerNameController,
                                        hinttxt: 'اسم المدير الثلاثي',
                                        largerElseValue: 50,
                                        smallerValue: 3,
                                        validationifText: 'الاسم طويل جدا',
                                        validationElseText: 'الاسم قصير جدا',
                                      ),
                                      const SizedBox(height: 4),
                                      CrdTxtFrmFld(
                                        cntrTxt: managerPhoneNoController,
                                        hinttxt:
                                            'رقم مدير المنظمة او الفريق التطوعي',
                                        largerElseValue: 12,
                                        smallerValue: 11,
                                        validationifText: 'الرقم صغير ',
                                        validationElseText:
                                            'رقم الهاتف غير صحيح. يجب ان يتكون من 11 رقم',
                                        isNumber: true,
                                      ),
                                      const SizedBox(height: 4),
                                      CrdTxtFrmFld(
                                        cntrTxt: phoneNumberController,
                                        hinttxt:
                                            'رقم التواصل مع المنظمة او الفريق التطوعي',
                                        largerElseValue: 12,
                                        smallerValue: 11,
                                        validationifText: 'الرقم صغير جدا',
                                        validationElseText:
                                            'ادخل الرقم غير صحيح',
                                        isNumber: true,
                                      ),
                                      const SizedBox(height: 4),
                                      SelectProvinceDropDwon(
                                        initialValue: _selectedProvince,
                                        onSelectedProvince: (newValue) =>
                                            setState(() =>
                                                _selectedProvince = newValue),
                                        isBlue: true,
                                      ),
                                      const SizedBox(height: 4),
                                      CrdTxtFrmFld(
                                        cntrTxt: distributionAreaController,
                                        hinttxt: 'اماكن التوزيع داخل المحافظة',
                                        largerElseValue: 100,
                                        smallerValue: 4,
                                        validationifText: "الاسم قصير جدا",
                                        validationElseText: 'الاسم طويل جدا',
                                      ),
                                      const SizedBox(height: 4),
                                      CrdTxtFrmFld(
                                        cntrTxt: descriptionController,
                                        hinttxt: 'وصف قصير عن المنظمة',
                                        largerElseValue: 1000,
                                        smallerValue: 5,
                                        validationifText: 'الوصف قصير جدا',
                                        validationElseText:
                                            ' يجب ان يكون الوصف اقل من 20 كلمة',
                                      ),
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
                                          _location == null
                                              ? 'تحديد على الخريطة'
                                              : 'تحديد مرة اخرى',
                                          style: textStyle,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      SizedBox(
                                        width: SizeConfig.screenWidth * 0.7,
                                        child: buttonBlueShape(
                                          'تحديث المعلومات',
                                          context,
                                          onUpdatePressed,
                                        ),
                                      )
                                    ],
                                  ),
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
            ),
    );
  }

  void onUpdatePressed() async {
    if (_location == null) {
      showOverlay(context: context, text: 'الرجاء اختيار الموقع');
    }
    if (_selectedProvince.isEmpty) {
      showOverlay(context: context, text: 'الرجاء اختيار المحافظة');
    }
    if (_formkey.currentState.validate()) {
      final org = Organization(
        id: widget.orgData.id,
        name: orgName.text,
        managerName: managerNameController.text,
        province: _selectedProvince,
        description: descriptionController.text,
        distributionArea: distributionAreaController.text,
        managerPhoneNo: managerPhoneNoController.text,
        phoneNumber: phoneNumberController.text,
        location: Location(
          longitude: _location.longitude,
          latitude: _location.latitude,
        ),
      );
      setState(() {
        loading = true;
      });
      try {
        await DatabaseService(widget.orgData.id).updateOrganizationData(org);
      } catch (e) {
        await showCostumeDatabaseErrorNotif(e);
      }

      Navigator.of(context).pop();
    }
  }
}
