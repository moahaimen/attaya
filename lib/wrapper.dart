import 'package:attayairaq/services/size_config.dart';
import 'package:flutter/material.dart';


class Wrapper extends StatelessWidget {
  final Widget child;

  const Wrapper({@required this.child});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return child;
  }
}
