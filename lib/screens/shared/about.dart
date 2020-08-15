import 'package:flutter/material.dart';

import '../../consts/consts.dart';

class About extends StatelessWidget {
  final bool isAboutApp;
  final bool fromNavBar;

  const About({this.isAboutApp, this.fromNavBar = false});

  @override
  Widget build(BuildContext context) {
    var title = isAboutApp ? 'حول التطبيق' : 'حول المبادرة ';
    return Scaffold(
      appBar: AppBar(
        backgroundColor: fromNavBar
            ? const Color.fromRGBO(35, 68, 199, 1)
            : Colors.white.withOpacity(0),
        elevation: 0,
        centerTitle: true,
        title: fromNavBar
            ? Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 24.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Cairo',
                ),
              )
            : null,
        leading: IconButton(
          icon: fromNavBar
              ? Container()
              : Icon(
                  Icons.arrow_back_ios,
                  color: fromNavBar ? Colors.white : Colors.black,
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
                const SizedBox(height: 20),
                !isAboutApp
                    ? SizedBox(
                        width: 200,
                        height: 200,
                        child: Image.asset(
                          'assets/icons/code_for_iraq.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    : Container(),
                SizedBox(height: isAboutApp ? 80 : 40),
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
