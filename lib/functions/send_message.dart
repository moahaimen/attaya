import 'package:url_launcher/url_launcher.dart';

void sendMessage(String phoneNO) async {
  // Android
  if (phoneNO.startsWith('0')) {
    phoneNO = phoneNO.substring(1);
  }
  final uri = 'sms:964$phoneNO';
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
