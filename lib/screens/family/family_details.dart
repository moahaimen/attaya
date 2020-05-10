import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/family.dart';
import '../../consts/consts.dart';
import '../../consts/loading.dart';
import '../../services/data_base.dart';
import '../../screens/admin/delete.dart';
import '../../functions/send_message.dart';
import '../../services/family_sevices.dart';
import '../../screens/orignization/send_request_delete.dart';

class FamilyDetails extends StatefulWidget {
  final String familyId;
  final bool isAdmin;

  const FamilyDetails({
    this.familyId,
    this.isAdmin,
  });

  @override
  _FamilyDetailsState createState() => _FamilyDetailsState();
}

class _FamilyDetailsState extends State<FamilyDetails> {
  bool _loading = false;
  bool _changeStateloading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: apBar('معلومات العائلة', context),
      body: _loading
          ? Loading()
          : StreamBuilder<Family>(
              stream: DatabaseService(widget.familyId).familyData,
              builder: (context, snapshot) {
                final familyObj = snapshot.data;
                return familyObj == null
                    ? Loading()
                    : Directionality(
                        textDirection: TextDirection.rtl,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: <Widget>[
                              Container(
                                padding:const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color:
                                          const Color(0xFF2356C7).withOpacity(0.86),
                                      width: 3),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                margin:const EdgeInsets.all(20),
                                alignment: Alignment.center,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      familyObj.headOfFamily,
                                      style: textStyle.copyWith(fontSize: 30),
                                    ),
                                    Text(
                                      'رقم التواصل: ${familyObj.phoneNo}',
                                      style: textStyle,
                                    ),
                                    Text(
                                      'عدد افراد العائلة: ${familyObj.noOfMembers} اشخاص',
                                      style: textStyle,
                                    ),
                                    Text(
                                      'المحافظة: ${familyObj.province}',
                                      style: textStyle,
                                    ),
                                    Text(
                                      'المنطقة: ${familyObj.city}',
                                      style: textStyle,
                                    ),
                                    Text(
                                      'اقرب نقطة دالة: ${familyObj.nearestKnownPoint}',
                                      style: textStyle,
                                    ),
                                    Text(
                                      'حالة العائلة: ${familyObj.isNeedHelp ? 'تطلعب مساعدة' : 'لا  تطلب مساعدة'}',
                                      style: textStyle,
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  buttonBlueShape(
                                      'ارسال رسالة للعائلة', context, () {
                                    sendMessage(familyObj.phoneNo);
                                  }),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  FlatButton.icon(
                                    icon: Image.asset(
                                      'assets/icons/map_pin_1.png',
                                      width: 25,
                                      color: Colors.red,
                                    ),
                                    label: Text(
                                      'تحديد على الخريطة',
                                      style: textStyle,
                                    ),
                                    onPressed: () {},
                                  ),
                                  _changeStateloading
                                      ? const CircularProgressIndicator()
                                      : FlatButton.icon(
                                          icon: Image.asset(
                                            'assets/icons/change_status.png',
                                            width: 25,
                                          ),
                                          label: Text(
                                            'تغيير حالة العائلة',
                                            style: textStyle,
                                          ),
                                          onPressed: () async {
                                            setState(() {
                                              _changeStateloading = true;
                                            });
                                            await changeFamilyState(familyObj);
                                            setState(() {
                                              _changeStateloading = false;
                                            });
                                          },
                                        ),
                                  buttonRedShape(
                                    'حذف العائلة',
                                    context,
                                    () {
                                      Navigator.of(context).push(
                                        CupertinoPageRoute(
                                          builder: (_) {
                                            return widget.isAdmin
                                                ? ConformDelete(
                                                    deleteType: 'العائلة',
                                                    deleteFunction: () async {
                                                      setState(() {
                                                        _loading = true;
                                                      });
                                                      await DatabaseService(
                                                              familyObj.id)
                                                          .deleteFamily();
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                  )
                                                : RequestDelete(
                                                    family: familyObj);
                                          },
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
              },
            ),
    );
  }
}