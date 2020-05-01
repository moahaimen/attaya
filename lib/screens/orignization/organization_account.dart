import 'package:attayairaq/consts/consts.dart';
import 'package:attayairaq/models/organization.dart';
import 'package:flutter/material.dart';

class OrganizationAccount extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final org = Organization(
      id: '0',
      name: 'منظمة امل',
      phoneNumber: '07721304321',
      province: 'بغداد',
      distributionArea: 'حي اكد-النورين',
      managerName: 'محمد عباس',
      managerPhoneNo: '07823232323',
    );
    TextStyle textStyle = TextStyle(
      fontSize: 18,
      fontFamily: 'Changa',
      fontWeight: FontWeight.bold,
      color: Color.fromRGBO(201, 85, 85, 1),
    );

    return Scaffold(
      appBar: apBar('حساب المنظمة', context),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: <Widget>[
            SizedBox(height: 25),
            Text(
              org.name,
              style: textStyle.copyWith(
                fontSize: 25,
                color: Color.fromRGBO(19, 15, 64, 1),
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color(0xFF2356C7).withOpacity(0.86), width: 3),
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.all(20),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  Text(
                    'اسم المدير: ${org.managerName}',
                    style: textStyle,
                  ),
                  SizedBox(height: 25),
                  Text(
                    'رقم المدير: ${org.managerPhoneNo}',
                    style: textStyle,
                  ),
                  SizedBox(height: 25),
                  Text(
                    'رقم المنظمة: ${org.phoneNumber}',
                    style: textStyle,
                  ),
                  SizedBox(height: 25),
                  Text(
                    'المحافظة: ${org.province}',
                    style: textStyle,
                  ),
                  SizedBox(height: 25),
                  Text(
                    'مناطق التوزيع: ${org.distributionArea}',
                    style: textStyle,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    child: Text(
                      'تعديل المعلومات',
                      style: textStyle.copyWith(color: Colors.black),
                    ),
                    onPressed: () {},
                  ),
                  FlatButton(
                    child: Text(
                      'حول المبادرة',
                      style: textStyle.copyWith(color: Colors.black),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
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
