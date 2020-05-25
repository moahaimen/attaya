import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../consts/consts.dart';

Widget conformExit(BuildContext c) => AlertDialog(
      title: Text(
        'هل تريد الخروج من التطبيق؟',
        textDirection: TextDirection.rtl,
        style: textStyle,
      ),
      actions: [
        FlatButton(
          child: Text(
            'لا',
            style: textStyle,
          ),
          onPressed: () => Navigator.pop(c, false),
        ),
        FlatButton(
          child: Text(
            'نعم',
            style: textStyle,
          ),
          onPressed: () {
            Navigator.pop(c, false);
            Navigator.pop(c, false);
          },
        ),
      ],
    );
