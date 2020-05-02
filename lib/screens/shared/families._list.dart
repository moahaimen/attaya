import 'package:attayairaq/consts/consts.dart';
import 'package:attayairaq/consts/loading.dart';
import 'package:attayairaq/functions/send_message.dart';
import 'package:attayairaq/models/family.dart';
import 'package:attayairaq/screens/admin/delete.dart';
import 'package:attayairaq/screens/orignization/send_request_delete.dart';
import 'package:attayairaq/screens/shared/add_family.dart';
import 'package:attayairaq/screens/shared/family_details.dart';
import 'package:attayairaq/services/data_base.dart';
import 'package:attayairaq/services/family_sevices.dart';
import 'package:attayairaq/services/size_config.dart';
import 'package:flutter/material.dart';

class FamiliesList extends StatelessWidget {
  final bool isAdmin;
  

  const FamiliesList({@required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    // List<Family> familyList2 = [
    //   Family(
    //     location: Location(longitude: 12, latitude: 34),
    //     id: '0',
    //     city: "حي اكد",
    //     headOfFamily: 'حسين اسامة عبود',
    //     phoneNo: '07716100805',
    //     province: "بغداد",
    //     timeStamp: DateTime.now(),
    //     isNeedHelp: true,
    //     nearestKnownPoint: 'اسواق عباس',
    //     noOfMembers: 6,
    //   ),
    //   Family(
    //     id: '1',
    //     location: Location(longitude: 12, latitude: 34),
    //     city: "الدورة",
    //     headOfFamily: 'جاسم محمد علي',
    //     phoneNo: '07821457541',
    //     province: "بغداد",
    //     timeStamp: DateTime.now(),
    //     isNeedHelp: true,
    //     nearestKnownPoint: 'شارع المصافي',
    //     noOfMembers: 4,
    //   ),
    // ];
    TextStyle textStyle = TextStyle(
      fontSize: 18,
      fontFamily: 'Changa',
      fontWeight: FontWeight.bold,
      color: deepTxtBlue,
    );
    return Scaffold(
      appBar: apBar('العوائل', context),
      body: StreamBuilder<List<Family>>(
          stream: DatabaseService('').families,
          builder: (context, snapshot) {
            final familyList = snapshot.data;

            return familyList == null 
                ? Loading()
                : Directionality(
                    textDirection: TextDirection.rtl,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height: SizeConfig.screenHeight * 0.7,
                            child:familyList.isEmpty
                          ? Center(child: Text('لاتوجد عوائل حاليا',style: textStyle,))
                          : ListView.builder(
                              itemCount: familyList.length,
                              itemBuilder: (BuildContext context, int i) {
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            Color(0xFF2356C7).withOpacity(0.86),
                                        width: 3),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  margin: EdgeInsets.all(20),
                                  alignment: Alignment.center,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            familyList[i].headOfFamily,
                                            style: textStyle.copyWith(
                                                fontSize:
                                                    SizeConfig.screenWidth *
                                                        0.07),
                                          ),
                                          IconButton(
                                            icon: Image.asset(
                                              'assets/icons/delete_icon.png',
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (_) => isAdmin
                                                      ? ConformDelete(
                                                          deleteType: 'المنظمة',
                                                          deleteFunction:
                                                              () async {
                                                            await deleteFamily(
                                                              familyList[i].id,
                                                            );
                                                          },
                                                        )
                                                      : RequestDelete(
                                                          family: familyList[i],
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
                                        'حالة العائلة: ${familyList[i].isNeedHelp ? 'تطلعب مساعدة' : 'لا  تطلب مساعدة'}',
                                        style: textStyle,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          FlatButton(
                                            child: Text(
                                              'ارسال رسالة',
                                              style: textStyle.copyWith(
                                                  fontSize: 12),
                                            ),
                                            onPressed: () {
                                              sendMessage(
                                                  familyList[i].phoneNo);
                                            },
                                          ),
                                          FlatButton(
                                            child: Text(
                                              'قرائة المزيد',
                                              style: textStyle.copyWith(
                                                  fontSize: 12),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (_) => FamilyDetails(
                                                    isAdmin: isAdmin,
                                                    familyId: familyList[i].id,
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
                                builder: (_) => AddFamily(
                                  isAdmin: isAdmin,
                                ),
                              ),
                            );
                          }),
                        ],
                      ),
                    ),
                  );
          }),
    );
  }
}
