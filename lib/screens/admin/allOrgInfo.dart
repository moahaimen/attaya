import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attayairaq/consts/consts.dart';

class AllOrgInfoAdmin extends StatefulWidget {
  @override
  _AllOrgInfoAdminState createState() => _AllOrgInfoAdminState();
}

class _AllOrgInfoAdminState extends State<AllOrgInfoAdmin> {
  int _currentIndex = 0;
  // final List<Widget> _children = [];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: apBar('المنظمات والجمعيات', context),
      body: SafeArea(
          child: Container(
              padding: EdgeInsets.all(6.0),
              child: Center(
                  child: ListView(children: <Widget>[
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 20.0),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: 350,
//                                          height: 250,
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  side:
                                      BorderSide(color: Colors.blue, width: 1),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                margin: EdgeInsets.symmetric(
                                    vertical: 7, horizontal: 30),
                                child: Column(
//                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Text(
                                        "منظمة امل",
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                        style: DeepBlueText,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Text(
                                        "رقم التواصل:07712345678",
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                        style: CardBorderTextstyle,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Text(
                                        "المحافظة:بغداد",
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                        style: CardBorderTextstyle,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: Text(
                                        "مناطق التوزيع:حي اكد-النورين",
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                        style: CardBorderTextstyle,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 30.0,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        right: 10,
                                      ),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: <Widget>[
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: <Widget>[
                                                Text(
                                                  'قراءة المزيد',
                                                  textAlign: TextAlign.right,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: smallCarText,
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 2,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                Text(
                                                  '                     ',
                                                ),
                                              ],
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: <Widget>[
                                                Text(
                                                  'ارسال رسالة على الهاتف',
                                                  textAlign: TextAlign.right,
                                                  textDirection:
                                                      TextDirection.rtl,
                                                  style: smallCarText,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  width: 350,
//                                          height: 250,
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.blue, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      margin: EdgeInsets.symmetric(
                                          vertical: 7, horizontal: 30),
                                      child: Column(
//                                  mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text("منظمة امل",
                                                textAlign: TextAlign.right,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: DeepBlueText),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                                "رقم التواصل:07712345678",
                                                textAlign: TextAlign.right,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: CardBorderTextstyle),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text("المحافظة:بغداد",
                                                textAlign: TextAlign.right,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: CardBorderTextstyle),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                                "مناطق التوزيع:حي اكد-النورين",
                                                textAlign: TextAlign.right,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: CardBorderTextstyle),
                                          ),
                                          SizedBox(
                                            height: 30.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 10,
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      Text(
                                                        'قراءة المزيد',
                                                        textAlign:
                                                            TextAlign.right,
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        style: smallCarText,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      Text(
                                                          '                     '),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      Text(
                                                        'ارسال رسالة على الهاتف',
                                                        textAlign:
                                                            TextAlign.right,
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        style: smallCarText,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )))
                            ],
                          )),
                      Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                          child: Column(
                            children: <Widget>[
                              Container(
                                  width: 350,
//                                          height: 250,
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.blue, width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      margin: EdgeInsets.symmetric(
                                          vertical: 7, horizontal: 30),
                                      child: Column(
//                                  mainAxisAlignment: MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text("منظمة امل",
                                                textAlign: TextAlign.right,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: DeepBlueText),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                                "رقم التواصل:07712345678",
                                                textAlign: TextAlign.right,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: CardBorderTextstyle),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text("المحافظة:بغداد",
                                                textAlign: TextAlign.right,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: CardBorderTextstyle),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Text(
                                                "مناطق التوزيع:حي اكد-النورين",
                                                textAlign: TextAlign.right,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style: CardBorderTextstyle),
                                          ),
                                          SizedBox(
                                            height: 30.0,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              right: 10,
                                            ),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      Text(
                                                        'قراءة المزيد',
                                                        textAlign:
                                                            TextAlign.right,
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        style: smallCarText,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 2,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      Text(
                                                          '                     '),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 5,
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: <Widget>[
                                                      Text(
                                                        'ارسال رسالة على الهاتف',
                                                        textAlign:
                                                            TextAlign.right,
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        style: smallCarText,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                        ],
                                      )))
                            ],
                          )),
                    ]),
              ])))),
      bottomNavigationBar: SizedBox(
        height: 48,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Color(0xff2356c7),
          onTap: onTabTapped, // new
          currentIndex: _currentIndex, // new
          items: [
            new BottomNavigationBarItem(
                icon: Icon(Icons.person_outline, color: Colors.white),
                title: Container(height: 10.0)),
            new BottomNavigationBarItem(
                icon: Icon(Icons.location_on, color: Colors.white),
                title: Container(height: 10.0)),
            new BottomNavigationBarItem(
                icon: Icon(Icons.map, color: Colors.white),
                title: Container(height: 10.0))
          ],
        ),
      ),
    );
  }
}
