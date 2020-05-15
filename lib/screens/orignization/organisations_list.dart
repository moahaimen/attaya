import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts/consts.dart';
import '../../consts/loading.dart';
import '../../services/data_base.dart';
import '../../models/organization.dart';
import '../../screens/admin/delete.dart';
import '../../functions/send_message.dart';
import '../../screens/orignization/organization_details.dart';

class OrganizationsList extends StatelessWidget {
  final bool isAdmin;

  const OrganizationsList({@required this.isAdmin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: apBar('المنظمات والجمعيات', context),
      body: StreamBuilder<List<Organization>>(
        stream: DatabaseService('').organizations,
        builder: (context, snapshot) {
          final organizationsList = snapshot.data;
          return organizationsList == null
              ? const Loading()
              : Directionality(
                  textDirection: TextDirection.rtl,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Container(
                      // height: SizeConfig.screenHeight * 0.5,
                      child: organizationsList.isEmpty
                          ? Center(
                              child: Text(
                                'لايوجد منظمات حاليا',
                                style: textStyle,
                              ),
                            )
                          : ListView.builder(
                              itemCount: organizationsList.length,
                              itemBuilder: (context, i) {
                                return Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: const Color.fromRGBO(
                                            35, 68, 199, 0.86),
                                        width: 3),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  margin: const EdgeInsets.all(20),
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
                                                      CupertinoPageRoute(
                                                        builder: (_) =>
                                                            ConformDelete(
                                                          deleteType: 'المنظمة',
                                                          deleteFunction:
                                                              () async {
                                                            try {
                                                              await DatabaseService(
                                                                organizationsList[
                                                                        i]
                                                                    .id,
                                                              ).deleteOrg();
                                                            } catch (e) {
                                                              await showCostumeDatabaseErrorNotif(
                                                                  e);
                                                            }
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
                                            onPressed: () {
                                              sendMessage(organizationsList[i]
                                                  .phoneNumber);
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
                                                      OrganizationDetails(
                                                    org: organizationsList[i],
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
                  ),
                );
        },
      ),
    );
  }
}
