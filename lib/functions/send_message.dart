import 'package:url_launcher/url_launcher.dart';

Future<void> sendMessage(String phoneNO) async {
  // Android
  var uri = 'sms:964$phoneNO';
  if (phoneNO.startsWith('0')) {
   uri = 'sms:964${phoneNO.substring(1)}';

  }
  if (await canLaunch(uri)) {
    await launch(uri);
  } else {
    // iOS
    final uri = 'sms:$phoneNO';

    if (await canLaunch(uri)) {
      await launch(uri);
    } else {
      throw 'Could not launch $uri';
    }
  }
}
