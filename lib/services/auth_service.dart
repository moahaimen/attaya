import 'package:attayairaq/main.dart';
import 'dart:async';
import 'package:attayairaq/models/user.dart';
import 'package:attayairaq/screens/HomeScreen.dart';
import 'package:attayairaq/screens/SignInorSignUp/family_information_for_profile.dart';
import 'package:attayairaq/screens/SignInorSignUp/orginization_information_for_profile.dart';
import 'package:attayairaq/screens/authenticate.dart';
import 'package:attayairaq/services/data_base.dart';
import 'package:attayairaq/services/shered_Preference.dart';
import 'package:attayairaq/wrapper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum PhoneAuthState {
  Started,
  Verified,
  Failed,
  Error,
  AutoRetrievalTimeOut,
  SetProfileCompleted,
}

class AuthService {
  static FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static var _authCredential, actualCode, phone, status, userType;

  User userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _firebaseAuth.onAuthStateChanged.map(userFromFirebaseUser);
  }

  static StreamController<String> statusStream = StreamController.broadcast();
  static StreamController<PhoneAuthState> phoneAuthState =
      StreamController.broadcast();
  static Stream<PhoneAuthState> stateStream = phoneAuthState.stream;

  static instantiate({String phoneNumber, UserType type}) async {
    assert(phoneNumber != null);
    phone = phoneNumber;
    userType = type;
    print(phone);
    startAuth();
  }

  static dispose() {
    statusStream.close();
    phoneAuthState.close();
  }

  static startAuth() {
    statusStream.stream
        .listen((String status) => print("PhoneAuth: " + status));
    addStatus('Phone auth started');
    _firebaseAuth
        .verifyPhoneNumber(
            phoneNumber: phone.toString(),
            timeout: Duration(seconds: 60),
            verificationCompleted: verificationCompleted,
            verificationFailed: verificationFailed,
            codeSent: codeSent,
            codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
        .then((value) {
      addStatus('Code sent');
    }).catchError((error) {
      addStatus(error.toString());
    });
  }

  static final PhoneCodeSent codeSent =
      (String verificationId, [int forceResendingToken]) async {
    actualCode = verificationId;
    addStatus("\nEnter the code sent to " + phone);
  };

  static final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
      (String verificationId) {
    actualCode = verificationId;
    addStatus("\nAuto retrieval time out");
  };

  static final PhoneVerificationFailed verificationFailed =
      (AuthException authException) {
    addStatus('${authException.message}');
    addState(PhoneAuthState.Error);
    if (authException.message.contains('not authorized'))
      addStatus('App not authroized');
    else if (authException.message.contains('Network'))
      addStatus('Please check your internet connection and try again');
    else
      addStatus('Something has gone wrong, please try later ' +
          authException.message);
  };

  static final PhoneVerificationCompleted verificationCompleted =
      (AuthCredential auth) {
    addStatus('Auto retrieving verification code');

    _firebaseAuth.signInWithCredential(auth).then((AuthResult value) {
      if (value.user != null) {
        addStatus(status = 'Authentication successful');
        addState(PhoneAuthState.Verified);
        onAuthenticationSuccessful(user: value.user);
      } else {
        addStatus('Invalid code/invalid authentication');
        addState(PhoneAuthState.Failed);
      }
    }).catchError((error) {
      addState(PhoneAuthState.Error);
      addStatus('Something has gone wrong, please try later $error');
    });
  };

  static void signInWithPhoneNumber({
    String smsCode,
  }) async {
    _authCredential = PhoneAuthProvider.getCredential(
        verificationId: actualCode, smsCode: smsCode);

    _firebaseAuth
        .signInWithCredential(_authCredential)
        .then((AuthResult result) async {
      addStatus('Authentication successful');
      addState(PhoneAuthState.Verified);
      onAuthenticationSuccessful(user: result.user);
    }).catchError((error) {
      addState(PhoneAuthState.Error);
      addStatus(
          'Something has gone wrong, please try later(signInWithPhoneNumber) $error');
    });
  }

  static onAuthenticationSuccessful({
    @required FirebaseUser user,
  }) async {
    switch (userType) {
      case UserType.family:
        {
          var family = await DatabaseService('')
              .familiesCollection
              .document(user.uid)
              .get();

          if (family.data == null || family.data.isEmpty) {
            navigatorKey.currentState.pushReplacement(
              MaterialPageRoute(
                builder: (_) => FamilySignup(
                  user: user,
                  phoneNo: phone,
                ),
              ),
            );
          } else {
            await SharedPrefs().setUser(phone, user.uid, 'family');
            navigatorKey.currentState.pushReplacement(
              MaterialPageRoute(
                builder: (_) => Wrapper(
                  child: HomeScreen(
                    user: User(
                        uid: user.uid,
                        phoneNo: phone,
                        userType: UserType.family),
                  ),
                ),
              ),
            );
          }
        }

        break;
      case UserType.organisation:
        {
          var org = await DatabaseService('')
              .organizationsCollection
              .document(user.uid)
              .get();

          if (org.data == null || org.data.isEmpty) {
            navigatorKey.currentState.pushReplacement(
              MaterialPageRoute(
                builder: (_) => OrgiziationSignup(user: user),
              ),
            );
          } else {
            await SharedPrefs().setUser(phone, user.uid, 'organisation');
            navigatorKey.currentState.pushReplacement(
              MaterialPageRoute(
                builder: (_) => Wrapper(
                  child: HomeScreen(
                    user: User(
                        uid: user.uid,
                        phoneNo: phone,
                        userType: UserType.organisation),
                  ),
                ),
              ),
            );
          }
        }

        break;
      case UserType.admin:
        {
          var admin = await Firestore.instance
              .collection('admins')
              .document(phone)
              .get();
          if (admin.documentID == phone) {
            await SharedPrefs().setUser(phone, user.uid, 'admin');
            navigatorKey.currentState.pushReplacement(
              MaterialPageRoute(
                builder: (_) => Wrapper(
                  child: HomeScreen(
                    user: User(
                      uid: user.uid,
                      phoneNo: phone,
                      userType: UserType.admin,
                    ),
                  ),
                ),
              ),
            );
          }
        }

        break;
      default:
    }
  }

  static void addStatus(String s) {
    statusStream.sink.add(s);
    print(s);
  }

  static addState(PhoneAuthState state) {
    print(state);
    phoneAuthState.sink.add(state);
  }

  Future signOut() async {
    try {
      SharedPrefs().deleteUser();
      navigatorKey.currentState.pushReplacement(
        MaterialPageRoute(
          builder: (_) => Authenticate(),
        ),
      );

      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e);
      return null;
    }
  }
}
