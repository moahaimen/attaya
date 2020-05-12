import 'package:flutter/material.dart';

import '../../models/family.dart';
import '../../consts/consts.dart';
import '../../consts/loading.dart';
import '../../models/request.dart';
import '../../services/data_base.dart';
import '../../services/send_request.dart';
import '../../functions/show_overlay.dart';

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
  final TextEditingController deleteReasonController = TextEditingController();
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
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF2356C7).withOpacity(0.86),
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        margin: const EdgeInsets.all(10),
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
                      const SizedBox(
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
                      const SizedBox(
                        height: 40,
                      ),
                      buttonRedShape('حذف العائلة', context, () async {
                        setState(() {
                          isLoading = true;
                        });
                        final org =
                            await DatabaseService('').getOrganizationData();
                        await sendDeleteRequestByOrg(
                          request: Request(
                            id: org.id,
                            orgThatRequested: org.name,
                            theFamily: widget.family,
                            deleteReason: deleteReasonController.text,
                            isDeleteRequest: true,
                          ),
                        );
                        setState(() {
                          isLoading = false;
                        });
                        showOverlay(text: 'تم ارسال الطلب', context: context);
                        Navigator.of(context).pop();
                      }),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
