import 'package:attayairaq/consts/consts.dart';
import 'package:attayairaq/models/family.dart';
import 'package:attayairaq/models/location.dart';
import 'package:attayairaq/screens/shared/add_family.dart';
import 'package:attayairaq/screens/shared/family_details.dart';
import 'package:attayairaq/services/size_config.dart';
import 'package:flutter/material.dart';


class FamiliesList extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    List<Family> familyList = [
      Family(
        isApprovedFromAdmin: true,
        location: Location(longitude: 12, latitude: 34),
        id: '0',
        city: "حي اكد",
        headOfFamily: 'حسين اسامة عبود',
        phoneNo: '07716100805',
        province: "بغداد",
        timeStamp: DateTime.now(),
        isNeedHelp: true,
        nearestKnownPoint: 'اسواق عباس',
        noOffamilyMembers: 6,
      ),
      Family(
        id: '1',
        isApprovedFromAdmin: true,
        location: Location(longitude: 12, latitude: 34),
        city: "الدورة",
        headOfFamily: 'جاسم محمد علي',
        phoneNo: '07821457541',
        province: "بغداد",
        timeStamp: DateTime.now(),
        isNeedHelp: true,
        nearestKnownPoint: 'شارع المصافي',
        noOffamilyMembers: 4,
      ),
    ];
    TextStyle textStyle = TextStyle(
      fontSize: 18,
      fontFamily: 'Changa',
      fontWeight: FontWeight.bold,
      color: deepTxtBlue,
    );
    return Scaffold(
      appBar: apBar('العوائل', context, false),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: <Widget>[
              Container(
                height: SizeConfig.screenHeight * 0.7,
                child: ListView.builder(
                  itemCount: familyList.length,
                  itemBuilder: (BuildContext context, int i) {
                    return Container(
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
                            familyList[i].headOfFamily,
                            style: textStyle.copyWith(fontSize: 30),
                          ),
                          Text(
                            'رقم التواصل: ${familyList[i].phoneNo}',
                            style: textStyle,
                          ),
                          Text(
                            'عدد افراد العائلة: ${familyList[i].noOffamilyMembers} اشخاص',
                            style: textStyle,
                          ),
                          Text(
                            'المحافظة: ${familyList[i].province}',
                            style: textStyle,
                          ),
                          Text(
                            'المنطقة: ${familyList[i].city}',
                            style: textStyle,
                          ),
                          Text(
                            'اقرب نقطة دالة: ${familyList[i].nearestKnownPoint}',
                            style: textStyle,
                          ),
                          Text(
                            'حالة العائلة: ${familyList[i].isNeedHelp ? 'تطلعب مساعدة' : 'لا  تطلب مساعدة'}',
                            style: textStyle,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              FlatButton(
                                child: Text(
                                  'ارسال رسالة على الهاتف',
                                  style: textStyle.copyWith(fontSize: 12),
                                ),
                                onPressed: () {},
                              ),
                              FlatButton(
                                child: Text(
                                  'قرائة المزيد',
                                  style: textStyle.copyWith(fontSize: 12),
                                ),
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => FamilyDetails(
                                        familyObj: familyList[i],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 30,
              ),
              buttonBlueShape('اضافة عائلة', context, () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => AddFamily(isAdmin: true,),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
