import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:speakerclener/screens/settingscreen.dart';

/// Create By Parth 16/03/23
class FirebaseLog {
  static logEvent(title) {
    try {
      String eventName = AppName.replaceAll(' ', '').toLowerCase();
      eventName = eventName.length >= 12 ? eventName.substring(0, 12) : eventName;
      FirebaseAnalytics.instance.logEvent(name: '${eventName}_${title}', parameters: {"Date": '${DateTime.now().year - DateTime.now().month - DateTime.now().day}'});
    } catch (e) {
      print(e);
    }
  }
}
