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
        child: Center(
          child: ListView(
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Image.asset(
                      "assets/icons/team.png",
                      height: 140.0,
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side:
                                const BorderSide(color: Colors.blue, width: 2),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 30),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: Text(
                                  widget.org.name,
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  style: textStyle.copyWith(fontSize: 25),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 10.0, bottom: 20),
                                child: Text(
                                  "رقم التواصل: ${widget.org.phoneNumber}",
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  style: cardBorderTextstyle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 10.0, bottom: 20),
                                child: Text(
                                  "المحافظة: ${widget.org.province}",
                                  textAlign: TextAlign.right,
                                  textDirection: TextDirection.rtl,
                                  style: cardBorderTextstyle,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    right: 10.0, bottom: 20),
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
                  )
                ],
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 50,
                      // width: 280,
                      child: buttonBlueShape(
                        'ارسال رسالة للمنظمة',
                        context,
                        () {
                          sendMessage(widget.org.phoneNumber);
                        },
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                          left: 10, right: 10.0, top: 28, bottom: 5),
                      child: Text(
                        "نبذه عن المنظمة",
                        style: TextStyle(
                          color: Color(0xFF130f40),
                          fontWeight: FontWeight.bold,
                          fontSize: 23.0,
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10.0, bottom: 5),
                      child: Text(
                        widget.org.description,
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                        style: const TextStyle(
                          color: Color(0xFFC95555),
                          fontWeight: FontWeight.bold,
                          // fontSize: 18.0,
                          fontFamily: 'Cairo',
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
    );
  }
}
