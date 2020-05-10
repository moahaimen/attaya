import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../consts/consts.dart';
import '../../models/organization.dart';
import '../../functions/send_message.dart';

class OrganizationDetails extends StatefulWidget {
  final Organization org;

  const OrganizationDetails({this.org});
  @override
  _OrganizationDetailsState createState() => _OrganizationDetailsState();
}

class _OrganizationDetailsState extends State<OrganizationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: apBar('معلومات المنظمة', context),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(6.0),
          child: Center(
            child: ListView(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    const Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 20),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 350,
                            height: 250,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              margin: const EdgeInsets.symmetric(
                                  vertical: 55, horizontal: 30),
                              child: Column(
//                                  mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      widget.org.name,
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: DeepBlueText,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      "رقم التواصل: ${widget.org.phoneNumber}",
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: cardBorderTextstyle,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      "المحافظة: ${widget.org.province}",
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: cardBorderTextstyle,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text(
                                      "مناطق التوزيع: ${widget.org.distributionArea}",
                                      textAlign: TextAlign.right,
                                      textDirection: TextDirection.rtl,
                                      style: cardBorderTextstyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                  width: 200,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                        width: 280,
                        child: buttonBlueShape(
                          'ارسال رسالة للمنظمة',
                          context,
                          () {
                            sendMessage(widget.org.phoneNumber);
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: 10.0, top: 28, bottom: 5),
                        child: Text(
                          "نبذه عن المنظمة",
                          style: TextStyle(
                            color: Color(0xFF130f40),
                            fontWeight: FontWeight.bold,
                            fontSize: 26.0,
                            fontFamily: 'Changa',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10.0, top: 28, bottom: 5),
                        child: Text(
                          widget.org.description,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            color: Color(0xFFC95555),
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            fontFamily: 'Changa',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
