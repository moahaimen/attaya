import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts/consts.dart';
import '../../consts/loading.dart';
import '../../models/request.dart';
import '../../services/data_base.dart';
import '../../screens/admin/request_details.dart';

class RequestsList extends StatelessWidget {
  final bool showDeleteRequests;

  const RequestsList({Key key, @required this.showDeleteRequests})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    final requestType = showDeleteRequests ? 'الحذف' : 'الاضافة';
    return Scaffold(
      appBar: apBar('طلبات $requestType من الجمعيات', context),
      body: StreamBuilder<List<Request>>(
        stream: DatabaseService('').requests,
        builder: (context, snapshot) {
          final requestList = snapshot.data;
          if(requestList != null) {
            requestList.removeWhere(
            (r) => showDeleteRequests ? !r.isDeleteRequest : r.isDeleteRequest,
          );
          }
          return requestList == null
              ? Loading()
              : requestList.isEmpty
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
                        itemBuilder: (context, i) {
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
                                    color: const Color(0xFF2356C7)
                                        .withOpacity(0.86),
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                // margin: EdgeInsets.all(20),
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: <Widget>[
                                    RichText(
                                      text: TextSpan(
                                        text:
                                            '${requestList[i].orgThatRequested}  ',
                                        style: textStyle.copyWith(
                                          color: const Color(0xFF2356C7),
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
                                    const Spacer(),
                                    Icon(Icons.arrow_forward_ios),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
        },
      ),
    );
  }
}
