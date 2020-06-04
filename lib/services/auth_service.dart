import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../main.dart';
import '../models/user.dart';
import '../consts/consts.dart';
import '../services/data_base.dart';
import '../services/shered_Preference.dart';
import '../screens/authentication/authenticate.dart';
import '../functions/check_location_permission.dart';
import '../screens/authentication/family_information_for_profile.dart';
import '../screens/authentication/orginization_information_for_profile.dart';

enum PhoneAuthState {
  Started,
  Verified,
  Failed,
  Error,
  AutoRetrievalTimeOut,
  SetProfileCompleted,
}

Future showCostumeAuthErrorNotif(String title) async {
  //this will show in-app notification in case of some auth error
  //and will forward the user bake to auth screen(first screen)
  await Future.delayed(const Duration(seconds: 1));

  BotToast.showNotification(
    title: (child) {
      return Text(
        title,
        style: textStyle,
      );
    },
    duration: const Duration(seconds: 3),
  );
  await Future.delayed(const Duration(seconds: 2));
  navigatorKey.currentState.pushReplacement(
    CupertinoPageRoute(
      builder: (_) => const Wrapper(isLogedIn: false),
    ),
  );
}

class AuthService {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static String actualCode;
  static String phone;
  static String status;
  static UserType userType;

//confert firebase user to user model
  User userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user {
    return _firebaseAuth.onAuthStateChanged.map(userFromFirebaseUser);
  }

  ///these[statusStreamController,phoneAuthState] are for troubleshooting
//and don't effect on the app if deleted
  static StreamController<String> statusStreamController =
      StreamController.broadcast();
  static StreamController<PhoneAuthState> phoneAuthState =
      StreamController.broadcast();

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
      showCostumeAuthErrorNotif('حدث خطا ما، الرجاء المحاولة لاحقا');
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

  static final PhoneVerificationFailed verificationFailed = (authException) {
    addStatus(authException.message);
    addState(PhoneAuthState.Error);
    if (authException.message.contains('not authorized')) {
      addStatus('App not authroized');
    } else if (authException.message.contains('network')) {
      showCostumeAuthErrorNotif('الرجاء التاكد من اتصالك بالانترنت');
      addStatus('Please check your internet connection and try again');
    } else {
      showCostumeAuthErrorNotif(
          '${authException.message}\n خطا ما، الرجاء المحاولة لاحقا');
      addStatus(
          'Something has gone wrong, please try later ${authException.message}');
    }
  };

  static final PhoneVerificationCompleted verificationCompleted = (auth) {
    addStatus('Auto retrieving verification code');

    _firebaseAuth.signInWithCredential(auth).then((value) {
      if (value.user != null) {
        addStatus(status = 'Authentication successful');
        addState(PhoneAuthState.Verified);
        onAuthenticationSuccessful(user: value.user);
      } else {
        showCostumeAuthErrorNotif('الرقم الذي ادخلته غير صحيح');

        addStatus('Invalid code/invalid authentication');
        addState(PhoneAuthState.Failed);
      }
    }).catchError((error) {
      addState(PhoneAuthState.Error);
      addStatus('Something has gone wrong, please try later $error');
      showCostumeAuthErrorNotif('$error\nحدث خطا ما، الرجاء المحاولة لاحقا');
    });
  };

//if the app does'nt authenticate automatically the the user have to
//put the code himeself then this function dose the job to authenticate the user
  static Future<void> signInWithPhoneNumber({
    String smsCode,
  }) async {
    final _authCredential = PhoneAuthProvider.getCredential(
        verificationId: actualCode, smsCode: smsCode);

    _firebaseAuth.signInWithCredential(_authCredential).then((result) async {
      addStatus('Authentication successful');
      addState(PhoneAuthState.Verified);
      onAuthenticationSuccessful(user: result.user);
    }).catchError((error) {
      if (error is PlatformException) {
        if (error.code == 'ERROR_INVALID_VERIFICATION_CODE') {
          showCostumeAuthErrorNotif('رقم التاكيد اللذي ادخلته غير صحيح');
        }
      } else {
        showCostumeAuthErrorNotif('حدث خطا ما، الرجاء المحاولة لاحقا');
      }
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
            navigatorKey.currentState.pushAndRemoveUntil(
              CupertinoPageRoute(
                builder: (_) => FamilySignup(
                  user: user,
                  phoneNo: phone,
                ),
              ),
              (v) => false,
            );
          } else {
            await SharedPrefs().setUser(phone, user.uid, 'family');
            navigatorKey.currentState.pushAndRemoveUntil(
              CupertinoPageRoute(
                builder: (_) => const Wrapper(isLogedIn: true),
              ),
              (v) => false,
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
            navigatorKey.currentState.pushAndRemoveUntil(
              CupertinoPageRoute(
                builder: (_) => OrgiziationSignup(user: user),
              ),
              (route) => false,
            );
          } else {
            await SharedPrefs().setUser(phone, user.uid, 'organisation');
            checkLocationPermision(
              navigateToMap: () => navigatorKey.currentState.pushAndRemoveUntil(
                CupertinoPageRoute(
                  builder: (_) => const Wrapper(isLogedIn: true),
                ),
                (route) => false,
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
          if (admin.data != null && admin.data.isNotEmpty) {
            await SharedPrefs().setUser(phone, user.uid, 'admin');
            navigatorKey.currentState.pushAndRemoveUntil(
              CupertinoPageRoute(
                builder: (_) => const Wrapper(isLogedIn: true),
              ),
              (v) => false,
            );
          } else {
            showCostumeAuthErrorNotif('عذرا انت لست ادمن');
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
      return null;
    }
  }
}
