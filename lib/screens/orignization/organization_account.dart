import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts/consts.dart';
import '../../consts/loading.dart';
import '../../services/data_base.dart';
import '../../models/organization.dart';
import '../../screens/shared/about.dart';
import './edit_orgnization_account.dart';


class OrganizationAccount extends StatelessWidget {
  final String uid;

  const OrganizationAccount({this.uid});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: apBar('حساب المنظمة', context),
      body: StreamBuilder<Organization>(
          stream: DatabaseService(uid).organizatioData,
          builder: (context, snapshot) {
            final org = snapshot.data;
            if (org == null) {
              return const Loading();
            } else {
              return Directionality(
                textDirection: TextDirection.rtl,
                child: ListView(
                  children: <Widget>[
                    const SizedBox(height: 25),
                    Text(
                      org.name,
                      style: textStyle.copyWith(
                        fontSize: 25,
                        color: const Color.fromRGBO(19, 15, 64, 1),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFF2356C7).withOpacity(0.86),
                            width: 3),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.all(20),
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
                          Text(
                            'اسم المدير: ${org.managerName}',
                            style: textStyle,
                          ),
                          const SizedBox(height: 25),
                          Text(
                            'رقم المدير: ${org.managerPhoneNo}',
                            style: textStyle,
                          ),
                          const SizedBox(height: 25),
                          Text(
                            'رقم المنظمة: ${org.phoneNumber}',
                            style: textStyle,
                          ),
                          const SizedBox(height: 25),
                          Text(
                            'المحافظة: ${org.province}',
                            style: textStyle,
                          ),
                          const SizedBox(height: 25),
                          Text(
                            'مناطق التوزيع: ${org.distributionArea}',
                            style: textStyle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => EditOrganizationAccount(
                                    orgData: org,
                                  ),
                                ),
                              );
                            },
                            child: Text(
                              'تعديل المعلومات',
                              style: textStyle.copyWith(color: Colors.black),
                            ),
                          ),
                          FlatButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (_) =>
                                      const About(isAboutApp: false),
                                ),
                              );
                            },
                            child: Text(
                              'حول المبادرة',
                              style: textStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
    );
  }
}

