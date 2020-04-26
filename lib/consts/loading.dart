
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFA5D5EB).withOpacity(0.3),
      child: Center(
        child: SpinKitFadingCircle(
          color: Colors.blue[900],
          size: 50.0,
        ),
      ),
    );
  }
}