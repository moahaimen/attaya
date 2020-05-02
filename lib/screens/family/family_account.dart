import 'package:attayairaq/consts/loading.dart';
import 'package:attayairaq/models/family.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class FamilyAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final familyData = Provider.of<Family>(context);

    TextStyle textStyle = TextStyle(
      fontSize: 18,
      fontFamily: 'Changa',
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(201, 85, 85, 1),
    );

    return familyData == null
        ? Loading()
        : ListView(
            children: <Widget>[
              SizedBox(height: 25),
              Text(
                familyData.headOfFamily,
                style: textStyle.copyWith(
                  fontSize: 25,
                  color: Color.fromRGBO(19, 15, 64, 1),
                ),
                textAlign: TextAlign.center,
              ),
              Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromRGBO(35, 68, 199, 0.86), width: 3),
                  borderRadius: BorderRadius.circular(15),
                ),
                margin: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Text(
                      'رب الاسرة: ${familyData.headOfFamily}',
                      style: textStyle,
                    ),
                    SizedBox(height: 25),
                    Text(
                      'رقم التواصل: ${familyData.phoneNo}',
                      style: textStyle,
                    ),
                    SizedBox(height: 25),
                    Text(
                      'عدد افراد العائلة: ${familyData.noOfMembers} اشخاص',
                      style: textStyle,
                    ),
                    SizedBox(height: 25),
                    Text(
                      'المحافظة: ${familyData.province}',
                      style: textStyle,
                    ),
                    SizedBox(height: 25),
                    Text(
                      'المنطقة: ${familyData.city}',
                      style: textStyle,
                    ),
                    SizedBox(height: 25),
                    Text(
                      'اقرب نقطة دالة: ${familyData.nearestKnownPoint}',
                      style: textStyle,
                    ),
                    SizedBox(height: 25),
                    Text(
                      'حالة العائلة: ${familyData.isNeedHelp ? 'تطلعب مساعدة' : 'لا  تطلب مساعدة'}',
                      style: textStyle,
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        IconButton(
                          icon: Image.asset(
                            'assets/icons/edit_icon.png',
                            width: 25,
                          ),
                          onPressed: () {},
                        ),
                        FlatButton.icon(
                          icon: Image.asset(
                            'assets/icons/change_status.png',
                            width: 25,
                          ),
                          label: Text(
                            'تغيير حالة العائلة',
                            style: textStyle.copyWith(fontSize: 12),
                          ),
                          onPressed: () {},
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
