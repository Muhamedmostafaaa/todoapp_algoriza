import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart'as tz;
import 'package:timezone/data/latest.dart'as tz;
class LocalNotificationService {
  LocalNotificationService();
  final _localnotificationservice = FlutterLocalNotificationsPlugin();
  final BehaviorSubject<String>onNotificationclick=BehaviorSubject();
  Future<void> intialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@drawable/ic_stat_notifications_none');
    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    final InitializationSettings settings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: iosInitializationSettings);
    await _localnotificationservice.initialize(settings,
        onSelectNotification: onSelectNotification);
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails('channel_id', 'channel_name',
            channelDescription: 'description',
            importance: Importance.max,
            priority: Priority.max,
            playSound: true);
    const IOSNotificationDetails iOSNotificationDetails=IOSNotificationDetails();
    return const NotificationDetails(android: androidNotificationDetails,iOS: iOSNotificationDetails);
  }
  Future<void> shownotification({required int id,required String title, required String body})async{
   final details=await _notificationDetails();
    await _localnotificationservice.show(id, title, body, details);

  }
  Future<void> showShedulenotification(
      {required int id,required String title,
        required String body,required int minutes})async{
    final details=await _notificationDetails();
    await _localnotificationservice.zonedSchedule(id, title, body,tz.TZDateTime.from(DateTime.now().add(Duration(minutes: minutes)), tz.local) ,details,
    androidAllowWhileIdle: true,uiLocalNotificationDateInterpretation:UILocalNotificationDateInterpretation.absoluteTime );

  }
  Future<void> shownotificationwithpayload({required int id,required String title, required String body,required String payload})async{
    final details=await _notificationDetails();
    await _localnotificationservice.show(id, title, body, details,payload: payload);

  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('$id id');
  }

  void onSelectNotification(String? payload) {
    print('payload $payload');
    if(payload!=null&&payload.isNotEmpty){
      onNotificationclick.add(payload);
    }
  }
}
