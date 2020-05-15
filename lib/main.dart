import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';

import './screens/HomeScreen.dart';
import './services/size_config.dart';
import './services/shered_Preference.dart';
import './screens/authentication/authenticate.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final user = await SharedPrefs().getUser();
  user == null
      ? runApp(
          MaterialApp(
            showSemanticsDebugger: false,
            builder: BotToastInit(), //1. call BotToastInit
            navigatorObservers: [BotToastNavigatorObserver()],
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            home: Wrapper(child: Authenticate()),
          ),
        )
      : runApp(
          MaterialApp(
            showSemanticsDebugger: false,
            builder: BotToastInit(), //1. call BotToastInit
            navigatorObservers: [BotToastNavigatorObserver()],
            debugShowCheckedModeBanner: false,
            navigatorKey: navigatorKey,
            home: Wrapper(
              child: HomeScreen(user: user),
            ),
          ),
        );
}

class Wrapper extends StatelessWidget {
  final Widget child;

  const Wrapper({@required this.child});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return child;
  }
}
