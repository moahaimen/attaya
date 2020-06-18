import 'package:flutter/material.dart';

import '../../consts/consts.dart';
import '../../consts/loading.dart';

class ConformDelete extends StatefulWidget {
  final String deleteType; //المنظمة او العائلة
  final Function deleteFunction;
  const ConformDelete({
    this.deleteType,
    this.deleteFunction,
  });

  @override
  _ConformDeleteState createState() => _ConformDeleteState();
}

class _ConformDeleteState extends State<ConformDelete> {
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: apBar('حذف ${widget.deleteType}', context),
      body: _loading
          ? const Loading()
          : Directionality(
              textDirection: TextDirection.rtl,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'هل انت متاكد من حذف ${widget.deleteType}؟',
                      style: textStyle.copyWith(fontSize: 30),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    buttonBlueShape('لا', context, () {
                      Navigator.of(context).pop();
                    }),
                    const SizedBox(height: 10),
                    buttonRedShape(
                      'نعم',
                      context,
                      () async {
                        setState(() {
                          _loading = true;
                        });
                        await widget.deleteFunction();
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
