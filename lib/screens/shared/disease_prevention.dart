import 'package:flutter/material.dart';

import '../../consts/consts.dart';

class DiseasePrevention extends StatelessWidget {
  const DiseasePrevention({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const thingsYouShouldDo = [
      'البقاء في المنزل',
      'ارتداء الكمامات',
      'غسل اليدين بستمرار',
      'طبخ الطعام بشكل جيد',
      'البحث عن طبيب في حالة الشك',
      'تجنب الاماكن المزدحمة',
    ];
    return Scaffold(
      appBar: apBar('الوقاية من المرض', context),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text(
                'اشياء يجب ان تفعلها',
                style: textStyle.copyWith(fontSize: 25),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 350,
                child: ListView.builder(
                  itemCount: thingsYouShouldDo.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: <Widget>[
                          Image.asset('assets/icons/correct_icon.png'),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            thingsYouShouldDo[i],
                            style: textStyle,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
