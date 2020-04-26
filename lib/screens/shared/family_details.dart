import 'package:attayairaq/consts/consts.dart';
import 'package:attayairaq/consts/loading.dart';
import 'package:attayairaq/models/family.dart';
import 'package:attayairaq/screens/admin/delete.dart';
import 'package:attayairaq/services/family_sevices.dart';
import 'package:flutter/material.dart';


class FamilyDetails extends StatefulWidget {
  final Family familyObj;

  const FamilyDetails({this.familyObj});

  @override
  _FamilyDetailsState createState() => _FamilyDetailsState();
}

class _FamilyDetailsState extends State<FamilyDetails> {
  bool _loading = false;
  bool _changeStateloading = false;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = TextStyle(
      fontSize: 18,
      fontFamily: 'Changa',
      fontWeight: FontWeight.bold,
      color: deepTxtBlue,
    );

    return Scaffold(
      appBar: apBar('معلومات العائلة', context, false),
      body: _loading
          ? Loading()
          : Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromRGBO(35, 68, 199, 0.86), width: 3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.familyObj.headOfFamily,
                            style: textStyle.copyWith(fontSize: 30),
                          ),
                          Text(
                            'رقم التواصل: ${widget.familyObj.phoneNo}',
                            style: textStyle,
                          ),
                          Text(
                            'عدد افراد العائلة: ${widget.familyObj.noOffamilyMembers} اشخاص',
                            style: textStyle,
                          ),
                          Text(
                            'المحافظة: ${widget.familyObj.province}',
                            style: textStyle,
                          ),
                          Text(
                            'المنطقة: ${widget.familyObj.city}',
                            style: textStyle,
                          ),
                          Text(
                            'اقرب نقطة دالة: ${widget.familyObj.nearestKnownPoint}',
                            style: textStyle,
                          ),
                          Text(
                            'حالة العائلة: ${widget.familyObj.isNeedHelp ? 'تطلعب مساعدة' : 'لا  تطلب مساعدة'}',
                            style: textStyle,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        buttonBlueShape('ارسال رسالة للعائلة', context, () {}),
                        SizedBox(
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
                            ? CircularProgressIndicator()
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
                                  await changeFamilyState(widget.familyObj.id);
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
                              MaterialPageRoute(
                                builder: (_) => ConformDelete(
                                  deleteType: 'العائلة',
                                  deleteFunction: () async {
                                    setState(() {
                                      _loading = true;
                                    });
                                    await deleteFamily(
                                      widget.familyObj.id,
                                    );
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
