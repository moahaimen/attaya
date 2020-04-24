import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:attayairaq/consts/consts.dart';

class FamilyAddAprrov extends StatefulWidget {
  @override
  _FamilyAddAprrovState createState() => _FamilyAddAprrovState();
}

class _FamilyAddAprrovState extends State<FamilyAddAprrov> {
  int _currentIndex = 0;
  // final List<Widget> _children = [];
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  txt() {
    print("family added");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: apBar('معلومات المنظمة', context),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(6.0),
          child: Center(
            child: ListView(
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(top: 10.0),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                      child: Column(
                        children: <Widget>[
                          Container(
                            width: 350,
                            height: 250,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.blue, width: 1),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              margin: EdgeInsets.symmetric(
                                  vertical: 55, horizontal: 30),
                              child: Column(
//                                  mainAxisAlignment: MainAxisAlignment.end,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text("منظمة امل",
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                        style: DeepBlueText),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text("رقم التواصل:07712345678",
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                        style: CardBorderTextstyle),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text("المحافظة:بغداد",
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                        style: CardBorderTextstyle),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: Text("مناطق التوزيع:حي اكد-النورين",
                                        textAlign: TextAlign.right,
                                        textDirection: TextDirection.rtl,
                                        style: CardBorderTextstyle),
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
                        child: buttonBlueOldShape(
                            'ارسال رسالة للمنظمة', context, txt()),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: 10.0, top: 28, bottom: 5),
                        child: Text(
                          "نبذه عن المنظمة",
                          style: TextStyle(
                            color: const Color(0xFF130f40),
                            fontWeight: FontWeight.bold,
                            fontSize: 26.0,
                            fontFamily: 'Changa',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: 10, right: 10.0, top: 28, bottom: 5),
                        child: Text(
                          "منظمة خيرية تعمل من اجل العراق والشعب العراقي تاسست سنة 2003 تقوم بتوزيع المعونات الشهرية  للعوائل",
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: const Color(0xFFC95555),
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
