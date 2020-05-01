import 'package:attayairaq/consts/loading.dart';
import 'package:attayairaq/functions/show_overlay.dart';
import 'package:attayairaq/models/organization.dart';
import 'package:attayairaq/models/request.dart';
import 'package:attayairaq/services/send_request.dart';
import 'package:flutter/material.dart';

import 'package:attayairaq/consts/consts.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:attayairaq/models/family.dart';

class RequestDelete extends StatefulWidget {
  final Family family;
  const RequestDelete({
    this.family,
  });

  @override
  _RequestDeleteState createState() => _RequestDeleteState();
}

class _RequestDeleteState extends State<RequestDelete> {
  bool isLoading = false;
  final deleteReasonController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: apBar('حذف عائلة', context),
      body: isLoading
          ? Loading()
          : SingleChildScrollView(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF2356C7).withOpacity(0.86),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: EdgeInsets.all(10),
                        alignment: Alignment.center,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'اسم العائلة:${widget.family.headOfFamily}',
                              style: textStyle,
                            ),
                            Text(
                              'المحافظة: ${widget.family.province}',
                              style: textStyle,
                            ),
                            Text(
                              'المنطقة: ${widget.family.city}',
                              style: textStyle,
                            ),
                            Text(
                              'اقرب نقطة دالة: ${widget.family.nearestKnownPoint}',
                              style: textStyle,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Form(
                        key: _formKey,
                        child: CrdTxtFrmFld(
                          hinttxt: 'سبب حذف العائلة',
                          isBlue: false,
                          largerElseValue: 30,
                          smallerValue: 5,
                          validationifText: 'الرجاء كتابة وصف اكثر',
                          validationElseText: 'الوصف طويل جدا',
                          cntrTxt: deleteReasonController,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      buttonRedShape('حذف العائلة', context, () async {
                        setState(() {
                          isLoading = true;
                        });

                        await sendDeleteRequestByOrg(
                          request: Request(
                            id: Uuid().v4(),
                            orgThatRequested: 'blah',
                            theFamily: widget.family,
                            deleteReason: deleteReasonController.text,
                            isDeleteRequest: true,
                          ),
                        );
                        setState(() {
                          isLoading = false;
                        });
                        showOverlay(text: 'تم ارسال الطلب', context: context);
                      })
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
