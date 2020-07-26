import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../consts/consts.dart';
import '../../models/family.dart';
import './editFamilt_account.dart';
import '../../consts/loading.dart';

class FamilyAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final familyData = Provider.of<Family>(context);

    return familyData == null
        ? const Loading()
        : ListView(
            children: <Widget>[
              const SizedBox(height: 25),
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
