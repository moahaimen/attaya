import 'package:attayairaq/models/family.dart';
import 'package:attayairaq/models/location.dart';
import 'package:flutter/material.dart';

class FamilyAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final f = Family(
      id: '0',
      city: "حي اكد",
      headOfFamily: 'حسين اسامة عبود',
      phoneNo: '07716100805',
      province: "بغداد",
      timeStamp: DateTime.now(),
      isNeedHelp: true,
      nearestKnownPoint: 'fgh fgh',
      noOffamilyMembers: 7,
      isApprovedFromAdmin: true,
      location: Location(longitude: 43, latitude: 221),
    );
    TextStyle textStyle = TextStyle(
      fontSize: 18,
      fontFamily: 'Changa',
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(201, 85, 85, 1),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'حساب العائلة',
          style: textStyle.copyWith(color: Colors.white),
        ),
      ),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 25),
          Text(
            f.headOfFamily,
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
                  'رب الاسرة: ${f.headOfFamily}',
                  style: textStyle,
                ),
                SizedBox(height: 25),
                Text(
                  'رقم التواصل: ${f.phoneNo}',
                  style: textStyle,
                ),
                SizedBox(height: 25),
                Text(
                  'عدد افراد العائلة: ${f.noOffamilyMembers} اشخاص',
                  style: textStyle,
                ),
                SizedBox(height: 25),
                Text(
                  'المحافظة: ${f.province}',
                  style: textStyle,
                ),
                SizedBox(height: 25),
                Text(
                  'المنطقة: ${f.city}',
                  style: textStyle,
                ),
                SizedBox(height: 25),
                Text(
                  'اقرب نقطة دالة: ${f.nearestKnownPoint}',
                  style: textStyle,
                ),
                SizedBox(height: 25),
                Text(
                  'حالة العائلة: ${f.isNeedHelp ? 'تطلعب مساعدة' : 'لا  تطلب مساعدة'}',
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
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        height: 50,
        color: Color.fromRGBO(35, 68, 199, 1),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            IconButton(
              icon: Image.asset(
                'assets/icons/user_icon.png',
                width: 25,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Image.asset(
                'assets/icons/map_pin_1.png',
                width: 25,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
            IconButton(
              icon: Image.asset(
                'assets/icons/family.png',
                width: 25,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
