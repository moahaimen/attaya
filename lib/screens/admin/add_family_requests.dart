import 'package:attayairaq/models/family.dart';
import 'package:attayairaq/models/location.dart';
import 'package:attayairaq/models/request.dart';
import 'package:attayairaq/screens/shared/request_details.dart';
import 'package:attayairaq/services/data_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:attayairaq/consts/consts.dart';

class AddFamilyRequests extends StatelessWidget {
  final List<Request> requestList2 = [
    Request(
      orgThatRequested: 'منظمة امل',
      id: '0',
      theFamily: Family(
        id: '1',
        location: Location(longitude: 12, latitude: 34),
        city: "الدورة",
        headOfFamily: 'جاسم محمد علي',
        phoneNo: '07821457541',
        province: "بغداد",
        timeStamp: DateTime.now(),
        isNeedHelp: true,
        nearestKnownPoint: 'شارع المصافي',
        noOfMembers: 4,
      ),
      deleteReason: '',
      isDeleteRequest: false,
    ),
    Request(
      id: '1',
      orgThatRequested: 'منظمة امل',
      theFamily: Family(
        id: '1',
        location: Location(longitude: 12, latitude: 34),
        city: "الدورة",
        headOfFamily: 'جاسم محمد علي',
        phoneNo: '07821457541',
        province: "بغداد",
        timeStamp: DateTime.now(),
        isNeedHelp: true,
        nearestKnownPoint: 'شارع المصافي',
        noOfMembers: 4,
      ),
      deleteReason: '',
      isDeleteRequest: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: apBar('طلبات الحذف من الجمعيات', context),
      body: StreamBuilder<List<Request>>(
          stream: DatabaseService('').requests,
          builder: (context, snapshot) {
            final requestList = snapshot.data;
            return requestList == null
                ? Center(
                    child: Text(
                      'لايوجد طلبات',
                      style: textStyle,
                    ),
                  )
                : Directionality(
                    textDirection: TextDirection.rtl,
                    child: ListView.builder(
                      itemCount: requestList.length,
                      itemBuilder: (BuildContext context, int i) {
                        return Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                CupertinoPageRoute(
                                  builder: (_) => RequestDetails(
                                    request: requestList[i],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              height: 60,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Color(0xFF2356C7).withOpacity(0.86),
                                  width: 1,
                                ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              // margin: EdgeInsets.all(20),
                              padding: EdgeInsets.all(10),
                              child: Row(
                                children: <Widget>[
                                  RichText(
                                    text: TextSpan(
                                      text:
                                          '${requestList[i].orgThatRequested}  ',
                                      style: textStyle.copyWith(
                                        color: Color(0xFF2356C7),
                                      ),
                                      children: [
                                        TextSpan(
                                          text: requestList[i].isDeleteRequest
                                              ? 'قامت بطلب حذف عائلة'
                                              : 'قامت بطلب اضافة عائلة',
                                          style: textStyle.copyWith(
                                            color: Colors.black,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(Icons.arrow_forward_ios),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
          }),
    );
  }
}
