import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import './screens/HomeScreen.dart';
import './services/size_config.dart';
import './services/shered_Preference.dart';
import './screens/authentication/authenticate.dart';
import './models/user.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
User _user;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  _user = await SharedPrefs().getUser();
  runApp(
    MaterialApp(
        showSemanticsDebugger: false,
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        home: Wrapper(isLogedIn: _user == null ? false : true)),
  );
}

class Wrapper extends StatelessWidget {
  final bool isLogedIn;

  const Wrapper({@required this.isLogedIn});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return isLogedIn ? HomeScreen() : Authenticate();
  }
}
