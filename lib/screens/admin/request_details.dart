import 'package:flutter/material.dart';

import '../../consts/consts.dart';
import '../../models/request.dart';
import '../../services/data_base.dart';
import '../../services/send_request.dart';
import '../../functions/show_overlay.dart';

class RequestDetails extends StatefulWidget {
  final Request request;

  const RequestDetails({this.request});

  @override
  _RequestDetailsState createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final type = widget.request.isDeleteRequest ? 'حذف' : 'اضافة';
    return Scaffold(
      appBar: apBar('$type عائلة بطلب من المنظمة', context),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'الموافقة على $type عائلة',
                  style: textStyle.copyWith(fontSize: 30),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: const Color(0xFF2356C7).withOpacity(0.86),
                        width: 2),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'اسم العائلة: ${widget.request.theFamily.headOfFamily}',
                        style: textStyle,
                      ),
                      Text(
                        'المحافظة: ${widget.request.theFamily.province}',
                        style: textStyle,
                      ),
                      Text(
                        'المنطقة: ${widget.request.theFamily.city}',
                        style: textStyle,
                      ),
                      Text(
                        'اقرب نقطة دالة: ${widget.request.theFamily.nearestKnownPoint}',
                        style: textStyle,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                widget.request.isDeleteRequest
                    ? Text(
                        'سبب الحذف: ${widget.request.deleteReason}',
                        style: textStyle.copyWith(
                          color: Colors.red,
                          fontSize: 22,
                        ),
                      )
                    : Container(),
                const SizedBox(height: 30),
                buttonBlueShape(
                  'الموافقة على ال$type',
                  context,
                  loading
                      ? null
                      : () async {
                          setState(() {
                            loading = true;
                          });
                          try {
                            if (widget.request.isDeleteRequest) {
                              await DatabaseService(widget.request.theFamily.id)
                                  .deleteFamily();
                            } else {
                              await DatabaseService(widget.request.theFamily.id)
                                  .updateFamilyData(widget.request.theFamily);
                            }
                            await deleteRequest(widget.request.id);
                            setState(() {
                              loading = false;
                            });
                            showOverlay(
                                text: 'تم الموافقة على الطلب',
                                context: context);
                          } catch (e) {
                            await showCostumeDatabaseErrorNotif(e);
                          }
                          Navigator.of(context).pop();
                        },
                ),
                const SizedBox(height: 30),
                buttonBlueShape(
                  'رفض ال$type',
                  context,
                  loading
                      ? null
                      : () async {
                          setState(() {
                            loading = true;
                          });
                          await deleteRequest(widget.request.id);
                          setState(() {
                            loading = false;
                          });
                          Navigator.of(context).pop();
                          showOverlay(text: 'تم رفض الطلب ', context: context);
                        },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
