import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import './add_family.dart';
import './family_details.dart';
import '../../models/family.dart';
import '../../consts/consts.dart';
import '../../consts/loading.dart';
import '../../services/data_base.dart';
import '../../screens/admin/delete.dart';
import '../../services/size_config.dart';
import '../../functions/send_message.dart';
import '../../screens/orignization/send_request_delete.dart';

class FamiliesList extends StatelessWidget {
  final bool isAdmin;

  const FamiliesList({@required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: apBar('العوائل', context),
      body: StreamBuilder<List<Family>>(
        stream: DatabaseService('').families,
        builder: (context, snapshot) {
          final familyList = snapshot.data;

          return familyList == null
              ? const Loading()
              : Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SizedBox(
                      height: SizeConfig.screenHeight * 1,
                      child: Stack(
                        children: <Widget>[
                          Container(
                            // height: SizeConfig.screenHeight * 0.75,
                            child: familyList.isEmpty
                                ? Center(
                                    child: Text(
                                    'لاتوجد عوائل حاليا',
                                    style: textStyle,
                                  ))
                                : ListView.builder(
                                    itemCount: familyList.length,
                                    itemBuilder: (context, i) {
                                      return Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: const Color(0xFF2356C7)
                                                  .withOpacity(0.86),
                                              width: 3),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        margin: EdgeInsets.only(
                                          bottom: i + 1 == familyList.length
                                              ? 100
                                              : 30,
                                          top: 20,
                                          left: 10,
                                          right: 10,
                                        ),
                                        alignment: Alignment.center,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                SizedBox(
                                                  width:
                                                      SizeConfig.screenWidth *
                                                          0.6,
                                                  child: Text(
                                                    familyList[i].headOfFamily,
                                                    style: textStyle.copyWith(
                                                        fontSize: 23),
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: Image.asset(
                                                    'assets/icons/delete_icon.png',
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      CupertinoPageRoute(
                                                        builder: (_) => isAdmin
                                                            ? ConformDelete(
                                                                deleteType:
                                                                    'العائلة',
                                                                deleteFunction:
                                                                    () async {
                                                                  try {
                                                                    await DatabaseService(
                                                                            familyList[i].id)
                                                                        .deleteFamily();
                                                                  } catch (e) {
                                                                    await showCostumeDatabaseErrorNotif(
                                                                        e);
                                                                  }
                                                                },
                                                              )
                                                            : RequestDelete(
                                                                family:
                                                                    familyList[
                                                                        i],
                                                              ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'رقم التواصل: ${familyList[i].phoneNo}',
                                              style: textStyle,
                                            ),
                                            Text(
                                              'عدد افراد العائلة: ${familyList[i].noOfMembers} اشخاص',
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
                                              'حالة العائلة: ${familyList[i].isNeedHelp ? 'تطلب مساعدة' : 'لا  تطلب مساعدة'}',
                                              style: textStyle,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: <Widget>[
                                                FlatButton(
                                                  onPressed: () {
                                                    sendMessage(
                                                        familyList[i].phoneNo);
                                                  },
                                                  child: Text(
                                                    'ارسال رسالة',
                                                    style: textStyle.copyWith(
                                                        fontSize: 12),
                                                  ),
                                                ),
                                                FlatButton(
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      CupertinoPageRoute(
                                                        builder: (_) =>
                                                            FamilyDetails(
                                                          isAdmin: isAdmin,
                                                          familyId:
                                                              familyList[i].id,
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Text(
                                                    'قرائة المزيد',
                                                    style: textStyle.copyWith(
                                                        fontSize: 12),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                          ),
                          Column(
                            children: <Widget>[
                              const Spacer(),
                              buttonBlueShape(
                                'اضافة عائلة',
                                context,
                                () {
                                  Navigator.of(context).push(
                                    CupertinoPageRoute(
                                      builder: (_) => AddFamily(
                                        isAdmin: isAdmin,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              const SizedBox(height: 20)
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
        },
      ),
    );
  }
}
