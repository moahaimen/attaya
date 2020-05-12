import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';
import '../../models/user.dart';
import '../../consts/consts.dart';
import '../../consts/loading.dart';
import '../../models/location.dart';
import '../../services/data_base.dart';
import '../../screens/HomeScreen.dart';
import '../../models/organization.dart';
import '../../services/size_config.dart';
import '../../screens/shared/map_screen.dart';
import '../../services/shered_Preference.dart';
import '../../screens/authentication/authenticate.dart';

class OrgiziationSignup extends StatefulWidget {
  final FirebaseUser user;
  final String phoneNo;

  const OrgiziationSignup({
    this.user,
    this.phoneNo,
  });
  @override
  _OrgiziationSignupState createState() => _OrgiziationSignupState();
}

class _OrgiziationSignupState extends State<OrgiziationSignup> {
  final _formkey = GlobalKey<FormState>();
  bool loading = false;
  LatLng location;

  final TextEditingController orgName = TextEditingController();
  final TextEditingController managerNameController = TextEditingController();
  final TextEditingController managerPhoneNoController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController provinceController = TextEditingController();
  final TextEditingController distributionAreaController =
      TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    orgName.dispose();
    managerNameController.dispose();
    managerPhoneNoController.dispose();
    phoneNumberController.dispose();
    provinceController.dispose();
    distributionAreaController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // for initiliaze size config
    return Scaffold(
      body: loading
          ? Loading()
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
                            const Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10.0, top: 28, bottom: 5),
                              child: Text("اكمال تسجيل المعلومات",
                                  style: emptyTallRedText),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Form(
                                child: Form(
                                  key: _formkey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                        isBlue: false,
                                      ),
                                      const SizedBox(height: 4),
                                      CrdTxtFrmFld(
                                        cntrTxt: managerNameController,
                                        hinttxt: 'اسم المدير الثلاثي',
                                        largerElseValue: 50,
                                        smallerValue: 3,
                                        validationifText: 'الاسم طويل جدا',
                                        validationElseText: 'الاسم قصير جدا',
                                        isBlue: false,
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
                                        isBlue: false,
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
                                        isBlue: false,
                                        isNumber: true,
                                      ),
                                      const SizedBox(height: 4),
                                      CrdTxtFrmFld(
                                        cntrTxt: provinceController,
                                        hinttxt: 'المحافظة',
                                        largerElseValue: 11,
                                        smallerValue: 4,
                                        validationifText:
                                            'اسم المحافظة قصير جدت',
                                        validationElseText:
                                            'يرجى ادخال اسم صحيح',
                                        isBlue: false,
                                      ),
                                      const SizedBox(height: 4),
                                      CrdTxtFrmFld(
                                        cntrTxt: distributionAreaController,
                                        hinttxt: 'اماكن التوزيع داخل المحافظة',
                                        largerElseValue: 100,
                                        smallerValue: 4,
                                        validationifText: "الاسم قصير جدا",
                                        validationElseText: 'الاسم طويل جدا',
                                        isBlue: false,
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
                                        isBlue: false,
                                      ),
                                      const SizedBox(height: 30),
                                      FlatButton.icon(
                                        onPressed: () async {
                                          location =
                                              await Navigator.of(context).push(
                                            CupertinoPageRoute(
                                              builder: (c) => const MapScreen(
                                                isNotSupScreen: false,
                                                isSelectLocation: true,
                                                isOrg: false,
                                              ),
                                            ),
                                          );
                                        },
                                        icon: Image.asset(
                                          'assets/icons/map_pin_1.png',
                                          color: Colors.red,
                                        ),
                                        label: Text(
                                          'تحديد على الخريطة',
                                          style: textStyle,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: SizeConfig.screenWidth * 0.7,
                                        child: buttonRedShape(
                                          'انشاء الحساب',
                                          context,
                                          () async {
                                            if (_formkey.currentState
                                                .validate()) {
                                              final newOrg = Organization(
                                                id: widget.user.uid,
                                                name: orgName.text,
                                                managerName:
                                                    managerNameController.text,
                                                province:
                                                    provinceController.text,
                                                description:
                                                    descriptionController.text,
                                                distributionArea:
                                                    distributionAreaController
                                                        .text,
                                                managerPhoneNo:
                                                    managerPhoneNoController
                                                        .text,
                                                phoneNumber:
                                                    phoneNumberController.text,
                                                location: Location(
                                                  longitude: location.longitude,
                                                  latitude: location.latitude,
                                                ),
                                              );
                                              setState(() {
                                                loading = true;
                                              });
                                              try {
                                                
                                              await DatabaseService(
                                                      widget.user.uid)
                                                  .updateOrganizationData(
                                                      newOrg);

                                              await SharedPrefs().setUser(
                                                widget.phoneNo,
                                                widget.user.uid,
                                                'organisation',
                                              );
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                CupertinoPageRoute(
                                                  builder: (_) => Wrapper(
                                                    child: HomeScreen(
                                                      user: User(
                                                        uid: widget.user.uid,
                                                        phoneNo: widget.phoneNo,
                                                        userType: UserType
                                                            .organisation,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                              } catch (e) {
                                                 await showCostumeDatabaseErrorNotif(
                                                    e);
                                                    Navigator.of(context)
                                                  .pushReplacement(
                                                CupertinoPageRoute(
                                                  builder: (_) => Wrapper(
                                                    child: Authenticate(),
                                                  ),
                                                ),
                                              );
                                              }
                                            }
                                          },
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
}
