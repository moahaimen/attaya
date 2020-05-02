import 'package:attayairaq/screens/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:attayairaq/consts/consts.dart';
import 'package:attayairaq/consts/loading.dart';
import 'package:attayairaq/functions/show_overlay.dart';
import 'package:attayairaq/models/location.dart';
import 'package:attayairaq/models/organization.dart';
import 'package:attayairaq/models/user.dart';
import 'package:attayairaq/screens/HomeScreen.dart';
import 'package:attayairaq/services/data_base.dart';
import 'package:attayairaq/services/shered_Preference.dart';
import 'package:attayairaq/services/size_config.dart';
import 'package:attayairaq/wrapper.dart';

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

  final orgName = TextEditingController();
  final managerNameController = TextEditingController();
  final managerPhoneNoController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final provinceController = TextEditingController();
  final distributionAreaController = TextEditingController();
  final descriptionController = TextEditingController();

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
    SizeConfig().init(context);
    return Scaffold(
      body: loading
          ? Loading()
          : SafeArea(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  width: SizeConfig.screenWidth * 1,
                  height: SizeConfig.screenHeight * 1,
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
                            Row(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 85, right: 50),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: 10, right: 10.0, top: 28, bottom: 5),
                              child: Text("اكمال تسجيل المعلومات",
                                  style: emptyTallRedText),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Form(
                                child: Form(
                                  key: _formkey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    textDirection: TextDirection.rtl,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(height: 30),
                                      SizedBox(
                                        height: 60.0,
                                        child: CrdTxtFrmFld(
                                          cntrTxt: orgName,
                                          hinttxt:
                                              'اسم المنظمة او الفريق التطوعي',
                                          largerElseValue: 30,
                                          smallerValue: 3,
                                          validationifText:
                                              'يرجى ادخال الاسم بالكامل',
                                          validationElseText: 'الاسم طويل جدا',
                                          password: false,
                                          isBlue: false,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      SizedBox(height: 4),
                                      SizedBox(
                                        height: 60.0,
                                        child: CrdTxtFrmFld(
                                          cntrTxt: managerNameController,
                                          hinttxt: 'اسم المدير الثلاثي',
                                          largerElseValue: 50,
                                          smallerValue: 3,
                                          validationifText: 'الاسم طويل جدا',
                                          validationElseText: 'الاسم قصير جدا',
                                          password: false,
                                          isBlue: false,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      SizedBox(
                                        height: 60.0,
                                        child: CrdTxtFrmFld(
                                          cntrTxt: managerPhoneNoController,
                                          hinttxt:
                                              'رقم مدير المنظمة او الفريق التطوعي',
                                          largerElseValue: 12,
                                          smallerValue: 11,
                                          validationifText: 'الرقم صغير ',
                                          validationElseText:
                                              'رقم الهاتف غير صحيح. يجب ان يتكون من 11 رقم',
                                          password: false,
                                          isBlue: false,
                                          isNumber: true,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      SizedBox(
                                        height: 60.0,
                                        child: CrdTxtFrmFld(
                                          cntrTxt: phoneNumberController,
                                          hinttxt:
                                              'رقم التواصل مع المنظمة او الفريق التطوعي',
                                          largerElseValue: 12,
                                          smallerValue: 11,
                                          validationifText: 'الرقم صغير جدا',
                                          validationElseText:
                                              'ادخل الرقم غير صحيح',
                                          password: false,
                                          isBlue: false,
                                          isNumber: true,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      SizedBox(
                                        height: 60.0,
                                        child: CrdTxtFrmFld(
                                          cntrTxt: provinceController,
                                          hinttxt: 'المحافظة',
                                          largerElseValue: 11,
                                          smallerValue: 4,
                                          validationifText:
                                              'اسم المحافظة قصير جدت',
                                          validationElseText:
                                              'يرجى ادخال اسم صحيح',
                                          password: false,
                                          isBlue: false,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      SizedBox(
                                        height: 60.0,
                                        child: CrdTxtFrmFld(
                                          cntrTxt: distributionAreaController,
                                          hinttxt:
                                              'اماكن التوزيع داخل المحافظة',
                                          largerElseValue: 100,
                                          smallerValue: 4,
                                          validationifText: "الاسم قصير جدا",
                                          validationElseText: 'الاسم طويل جدا',
                                          password: false,
                                          isBlue: false,
                                        ),
                                      ),
                                      SizedBox(height: 4),
                                      SizedBox(
                                        height: 60.0,
                                        child: CrdTxtFrmFld(
                                          cntrTxt: descriptionController,
                                          hinttxt: 'وصف قصير عن المنظمة',
                                          largerElseValue: 1000,
                                          smallerValue: 5,
                                          validationifText: 'الوصف قصير جدا',
                                          validationElseText:
                                              ' يجب ان يكون الوصف اقل من 20 كلمة',
                                          password: false,
                                          isBlue: false,
                                        ),
                                      ),
                                      SizedBox(height: 30),
                                      FlatButton.icon(
                                        onPressed: () {
                                          //TODO: Implement select location Widget
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
                                      SizedBox(
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
                                                  longitude: 1000,
                                                  latitude: 2000,
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
                                                  MaterialPageRoute(
                                                    builder: (_) => Wrapper(
                                                      child: HomeScreen(
                                                        user: User(
                                                          uid: widget.user.uid,
                                                          phoneNo:
                                                              widget.phoneNo,
                                                          userType: UserType
                                                              .organisation,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              } catch (e) {
                                                showOverlay(
                                                  text: e.message,
                                                  context: context,
                                                );
                                                Navigator.of(context)
                                                    .pushReplacement(
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          Authenticate()),
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
