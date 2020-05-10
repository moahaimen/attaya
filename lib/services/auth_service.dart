import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../consts/consts.dart';
import '../main.dart';
import '../models/user.dart';
import '../screens/HomeScreen.dart';
import '../screens/authentication/authenticate.dart';
import '../screens/authentication/family_information_for_profile.dart';
import '../screens/authentication/orginization_information_for_profile.dart';
import '../services/data_base.dart';
import '../services/shered_Preference.dart';

enum PhoneAuthState {
  Started,
  Verified,
  Failed,
  Error,
  AutoRetrievalTimeOut,
  SetProfileCompleted,
}

Future showcostumeNotife(String title) async {
  await Future.delayed(const Duration(seconds: 1));

  BotToast.showNotification(
    title: (child) {
      return Text(
        title,
        style: textStyle,
      );
    },
    duration:const Duration(seconds: 3),
  );
  await Future.delayed(const Duration(seconds: 2));
  navigatorKey.currentState.pushReplacement(
    CupertinoPageRoute(
      builder: (_) => Wrapper(
        child: Authenticate(),
      ),
    ),
  );
}

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static String actualCode;
  static String phone;
  static String status;
  static UserType userType;

  User userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _firebaseAuth.onAuthStateChanged.map(userFromFirebaseUser);
  }

  static StreamController<String> statusStreamController =
      StreamController.broadcast();
  static StreamController<PhoneAuthState> phoneAuthState =
      StreamController.broadcast();
  static Stream<PhoneAuthState> stateStream = phoneAuthState.stream;
  static Stream<String> statusStream = statusStreamController.stream;

  static Future instantiate({
    @required String phoneNumber,
    @required UserType type,
  }) async {
    assert(phoneNumber != null);
    phone = phoneNumber;
    userType = type;
    startAuth();
  }

  static void dispose() {
    statusStreamController.close();
    phoneAuthState.close();
  }

  static void startAuth() {
    statusStreamController.stream.listen((status) {
      print("PhoneAuth: $status");
    });
    addStatus('Phone auth started');
    _firebaseAuth
        .verifyPhoneNumber(
            phoneNumber: phone.toString(),
            timeout: const Duration(seconds: 60),
            verificationCompleted: verificationCompleted,
            verificationFailed: verificationFailed,
            codeSent: codeSent,
            codeAutoRetrievalTimeout: codeAutoRetrievalTimeout)
        .then((value) {
      addStatus('Code sent');
    }).catchError((error) {
      showcostumeNotife('حدث خطا ما، الرجاء المحاولة لاحقا');
      addStatus(error.toString());
    });
  }

  static final PhoneCodeSent codeSent =
      (verificationId, [forceResendingToken]) async {
    actualCode = verificationId;
    addStatus("\nEnter the code sent to $phone");
  };

  static final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
      (verificationId) {
    actualCode = verificationId;
    addStatus("\nAuto retrieval time out");
  };

  static final PhoneVerificationFailed verificationFailed =
      (authException) {
    addStatus(authException.message);
    addState(PhoneAuthState.Error);
    if (authException.message.contains('not authorized')) {
      addStatus('App not authroized');
    } else if (authException.message.contains('network')) {
      showcostumeNotife('الرجاء التاكد من اتصالك بالانترنت');
      addStatus('Please check your internet connection and try again');
    } else {
      showcostumeNotife('حدث خطا ما، الرجاء المحاولة لاحقا');
      addStatus(
          'Something has gone wrong, please try later ${authException.message}');
    }
  };

  static final PhoneVerificationCompleted verificationCompleted =
      (auth) {
    addStatus('Auto retrieving verification code');

    _firebaseAuth.signInWithCredential(auth).then((value) {
      if (value.user != null) {
        addStatus(status = 'Authentication successful');
        addState(PhoneAuthState.Verified);
        onAuthenticationSuccessful(user: value.user);
      } else {
        showcostumeNotife('الرقم الذي ادخلته غير صحيح');

        addStatus('Invalid code/invalid authentication');
        addState(PhoneAuthState.Failed);
      }
    }).catchError((error) {
      addState(PhoneAuthState.Error);
      addStatus('Something has gone wrong, please try later $error');
      showcostumeNotife('حدث خطا ما، الرجاء المحاولة لاحقا');
    });
  };

  static Future<void> signInWithPhoneNumber({
    String smsCode,
  }) async {
    final _authCredential = PhoneAuthProvider.getCredential(
        verificationId: actualCode, smsCode: smsCode);

    _firebaseAuth
        .signInWithCredential(_authCredential)
        .then((result) async {
      addStatus('Authentication successful');
      addState(PhoneAuthState.Verified);
      onAuthenticationSuccessful(user: result.user);
    }).catchError((error) {
      showcostumeNotife('حدث خطا ما، الرجاء المحاولة لاحقا');
      addState(PhoneAuthState.Error);
      addStatus(
          'Something has gone wrong, please try later(signInWithPhoneNumber) $error');
    });
  }

  static Future onAuthenticationSuccessful({
    @required FirebaseUser user,
  }) async {
    switch (userType) {
      case UserType.family:
        {
          final family = await DatabaseService('')
              .familiesCollection
              .document(user.uid)
              .get();

          if (family.data == null || family.data.isEmpty) {
            navigatorKey.currentState.pushReplacement(
              CupertinoPageRoute(
                builder: (_) => FamilySignup(
                  user: user,
                  phoneNo: phone,
                ),
              ),
            );
          } else {
            await SharedPrefs().setUser(phone, user.uid, 'family');
            navigatorKey.currentState.pushReplacement(
              CupertinoPageRoute(
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
          final org = await DatabaseService('')
              .organizationsCollection
              .document(user.uid)
              .get();

          if (org.data == null || org.data.isEmpty) {
            navigatorKey.currentState.pushReplacement(
              CupertinoPageRoute(
                builder: (_) => OrgiziationSignup(user: user),
              ),
            );
          } else {
            await SharedPrefs().setUser(phone, user.uid, 'organisation');
            navigatorKey.currentState.pushReplacement(
              CupertinoPageRoute(
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
          final admin = await Firestore.instance
              .collection('admins')
              .document(phone)
              .get();
          if (admin.documentID == phone) {
            await SharedPrefs().setUser(phone, user.uid, 'admin');
            navigatorKey.currentState.pushReplacement(
              CupertinoPageRoute(
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
    statusStreamController.sink.add(s);
  }

  static void addState(PhoneAuthState state) {
    print(state);
    phoneAuthState.sink.add(state);
  }

  Future signOut() async {
    try {
      SharedPrefs().deleteUser();
      navigatorKey.currentState.pushReplacement(
        CupertinoPageRoute(
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
