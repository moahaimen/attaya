import 'package:attayairaq/models/user.dart';
import 'package:attayairaq/screens/HomeScreen.dart';
import 'package:attayairaq/screens/authenticate.dart';
import 'package:attayairaq/services/auth_service.dart';
import 'package:attayairaq/services/shered_Preference.dart';
import 'package:attayairaq/services/size_config.dart';
import 'package:attayairaq/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final user = await SharedPrefs().getUser();
  user == null
      ? runApp(
          MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            home: Wrapper(child: Authenticate()),
          ),
        )
      : runApp(
          MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            home: Wrapper(
              child: HomeScreen(user: user),
            ),
          ),
        );
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return StreamProvider<PhoneAuthState>.value(
//       value: AuthService.stateStream,
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         navigatorKey: navigatorKey,
//         home: Wrapper(),
//       ),
//     );
//   }
// }
