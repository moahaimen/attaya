import 'package:flutter/material.dart';

import '../../consts/consts.dart';

class About extends StatelessWidget {
  final bool isAboutApp;

  const About({this.isAboutApp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 50),
                Text(
                  isAboutApp ? 'حول التطبيق' : "Code For IRAQ",
                  style: textStyle.copyWith(fontSize: 40),
                ),
                const SizedBox(height: 100),
                isAboutApp
                    ? Text(
                        ' التطبيق يهدف الى مساعدة الفرق التطوعية والجمعيات الخيرية والحملات الإنسانية'
                        ' في ترتيب خطط توزيع المواد الغذائية عن طريق تسجيل وتأشير موقع كل بيت'
                        ' يتم التوزيع فيه على الخريطة لكي لا يحصل تكرار في التوزيع.'
                        ' وأيضا تستطيع كل عائلة طلب المساعدة مرة أخرى عن طريق وضع إشارة على الخريطة'
                        ' توكد حاجتها للمواد الغذائية لكي تستطيع الفرق التطوعية '
                        ' الوصول اليها وتقديم المساعدة بأسرع وقت ممكن',
                        style: textStyle,
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        ' وهي مبادرة إنسانية غير ربحية تهدف الى خدمة المجتمع عن طريق البرمجة'
                        ' وتعتبر "Code For IRAQ" مبادرة تعليمية حقيقية ترعى المهتمين بتعلم تصميم'
                        ' وبرمجة تطبيقات الهاتف الجوال ومواقع الانترنت وبرامج الحاسوب والشبكات'
                        ' والاتصالات ونظم تشغيل الحاسوب باستخدام التقنيات مفتوحة المصدر وبشكل مجاني تماماً'
                        '\n\n info@codeforiraq.org',
                        style: textStyle,
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.center,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}