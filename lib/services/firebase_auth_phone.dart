import 'package:attayairaq/screens/SignInorSignUp/family_information_for_profile.dart';
import 'package:attayairaq/screens/SignInorSignUp/signUpChoice.dart';
import 'package:attayairaq/services/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class Firebase_auth_phone {
  final _codeController = TextEditingController();
  Future<bool> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth= FirebaseAuth.instance;
    print(phone);
    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          Navigator.of(context).pop();

          AuthResult result = await _auth.signInWithCredential(credential);

          FirebaseUser user = result.user;

          if (user != null) {
            await SharedPreferencesOperations().store_user(user);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpChoices()));
          } else {
            print("Error");
          }

          //This callback would gets called when verification is done auto maticlly
        },
        verificationFailed: (AuthException exception) {
          print(exception.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]) {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return AlertDialog(
                  title: Text("هل استلمت الكود"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      TextField(
                        controller: _codeController,
                      ),
                    ],
                  ),
                  actions: <Widget>[
                    FlatButton(
                      child: Text("Confirm"),
                      textColor: Colors.white,
                      color: Colors.blue,
                      onPressed: () async {
                        final code = _codeController.text.trim();
                        AuthCredential credential =
                            PhoneAuthProvider.getCredential(
                                verificationId: verificationId, smsCode: code);

                        AuthResult result =
                            await _auth.signInWithCredential(credential);

                        FirebaseUser user = result.user;

                        if (user != null) {
                          await SharedPreferencesOperations().store_user(user);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SignUpChoices(), //user: user,)
                              ));
                        } else {
                          print("Error");
                        }
                      },
                    )
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: null);
  }
}
