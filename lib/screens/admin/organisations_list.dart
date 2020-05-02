import 'package:attayairaq/consts/consts.dart';
import 'package:attayairaq/consts/loading.dart';
import 'package:attayairaq/functions/send_message.dart';
import 'package:attayairaq/models/organization.dart';
import 'package:attayairaq/screens/admin/delete.dart';
import 'package:attayairaq/screens/orignization/organization_details.dart';
import 'package:attayairaq/services/data_base.dart';
import 'package:attayairaq/services/organization_srvices.dart';
import 'package:flutter/material.dart';

class OrganizationsList extends StatelessWidget {
  final bool isAdmin;

  const OrganizationsList({@required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    // List<Organization> organizationsListw = [
    //   Organization(
    //     id: '0',
    //     name: 'منظمة امل',
    //     phoneNumber: '07721304321',
    //     province: 'بغداد',
    //     distributionArea: 'حي اكد-النورين',
    //     managerName: 'محمد عباس',
    //     description:
    //         "منظمة خيرية تعمل من اجل العراق والشعب العراقي تاسست سنة 2003 تقوم بتوزيع المعونات الشهرية  للعوائل",
    //     location: Location(longitude: null, latitude: null),
    //     managerPhoneNo: '07781273773',
    //   ),
    //   Organization(
    //     id: '1',
    //     name: 'منظمة امل',
    //     phoneNumber: '07721304321',
    //     province: 'بغداد',
    //     distributionArea: 'حي اكد-النورين',
    //     managerName: 'محمد عباس',
    //     description:
    //         "منظمة خيرية تعمل من اجل العراق والشعب العراقي تاسست سنة 2003 تقوم بتوزيع المعونات الشهرية  للعوائل",
    //     location: Location(longitude: null, latitude: null),
    //     managerPhoneNo: '07781273773',
    //   ),
    //   Organization(
    //     id: '2',
    //     name: 'منظمة امل',
    //     phoneNumber: '07721304321',
    //     province: 'بغداد',
    //     distributionArea: 'حي اكد-النورين',
    //     managerName: 'محمد عباس',
    //     description:
    //         "منظمة خيرية تعمل من اجل العراق والشعب العراقي تاسست سنة 2003 تقوم بتوزيع المعونات الشهرية  للعوائل",
    //     location: Location(longitude: null, latitude: null),
    //     managerPhoneNo: '07781273773',
    //   ),
    //   Organization(
    //     id: '3',
    //     name: 'منظمة امل',
    //     phoneNumber: '07721304321',
    //     province: 'بغداد',
    //     distributionArea: 'حي اكد-النورين',
    //     managerName: 'محمد عباس',
    //     description:
    //         "منظمة خيرية تعمل من اجل العراق والشعب العراقي تاسست سنة 2003 تقوم بتوزيع المعونات الشهرية  للعوائل",
    //     location: Location(longitude: null, latitude: null),
    //     managerPhoneNo: '07781273773',
    //   ),
    // ];
    TextStyle textStyle = TextStyle(
      fontSize: 18,
      fontFamily: 'Changa',
      fontWeight: FontWeight.bold,
      color: deepTxtBlue,
    );
    return Scaffold(
      appBar: apBar('المنظمات والجمعيات', context),
      body: StreamBuilder<List<Organization>>(
        stream: DatabaseService('').organizations,
        builder: (context, snapshot) {
          final organizationsList = snapshot.data;
          return Directionality(
            textDirection: TextDirection.rtl,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: organizationsList == null
                  ? Loading()
                  : Container(
                      // height: SizeConfig.screenHeight * 0.5,
                      child: organizationsList.isEmpty
                          ? Center(
                              child:
                                  Text('لايوجد منظمات حاليا', style: textStyle))
                          : ListView.builder(
                              itemCount: organizationsList.length,
                              itemBuilder: (BuildContext context, int i) {
                                return Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color:
                                            Color.fromRGBO(35, 68, 199, 0.86),
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
                                            organizationsList[i].name,
                                            style: textStyle.copyWith(
                                                fontSize: 30),
                                          ),
                                          isAdmin
                                              ? IconButton(
                                                  icon: Image.asset(
                                                    'assets/icons/delete_icon.png',
                                                    color: Colors.red,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                        builder: (_) =>
                                                            ConformDelete(
                                                          deleteType: 'المنظمة',
                                                          deleteFunction:
                                                              () async {
                                                            await deleteOrganization(
                                                              organizationsList[
                                                                      i]
                                                                  .id,
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                )
                                              : Container(),
                                        ],
                                      ),
                                      Text(
                                        'رقم التواصل: ${organizationsList[i].phoneNumber}',
                                        style: textStyle,
                                      ),
                                      Text(
                                        'المحافظة: ${organizationsList[i].province}',
                                        style: textStyle,
                                      ),
                                      Text(
                                        'مناطق التوزيع: ${organizationsList[i].distributionArea}',
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
                                              sendMessage(organizationsList[i]
                                                  .phoneNumber);
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
                                                  builder: (_) =>
                                                      OrganizationDetails(
                                                    org: organizationsList[i],
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
            ),
          );
        },
      ),
    );
  }
}
