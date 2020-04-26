import 'package:attayairaq/consts/consts.dart';
import 'package:attayairaq/consts/loading.dart';
import 'package:flutter/material.dart';

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
    TextStyle textStyle = TextStyle(
      fontSize: 18,
      fontFamily: 'Changa',
      fontWeight: FontWeight.bold,
      color: deepTxtBlue,
    );
    return Scaffold(
      appBar: apBar('حذف ${widget.deleteType}', context, false),
      body: _loading
          ? Loading()
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
                    SizedBox(
                      height: 40,
                    ),
                    buttonBlueShape('لا', context, () {
                      Navigator.of(context).pop();
                    }),
                    SizedBox(
                      height: 10,
                    ),
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
