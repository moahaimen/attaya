import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  const Loading();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitRing(
        color: Colors.blue[900],
        size: 50.0,
      ),
    );
  }
}
