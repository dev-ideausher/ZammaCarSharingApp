import 'dart:convert';


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:zammacarsharing/app/services/colors.dart';

const String darwinNotificationCategoryPlain = 'plainCategory';
const String darwinNotificationCategoryText = 'textCategory';
const String navigationActionId = 'id_3';
const DarwinNotificationDetails iosNotificationDetails =
    DarwinNotificationDetails(
  categoryIdentifier: darwinNotificationCategoryPlain,
);

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("BackGroound Message Handler Working...");

  try {
    await Future.delayed(const Duration(seconds: 1));
    if (message.data["notification_type"] == "2") {
      // Get.find<MainPageController>().index.value = 1;
      // Get.find<MobileChatScreenController>();
      //
      // Get.toNamed(Routes.MOBILE_CHAT_SCREEN, arguments: int.parse(message.data["user_id"]));
    } else {
      //Get.toNamed(Routes.NOTIFICATIONS);
    }
  } catch (e) {
    print(e);
  }
}

class FirebaseMessagingUtils {
  final List<DarwinNotificationCategory> darwinNotificationCategories =
      <DarwinNotificationCategory>[
    DarwinNotificationCategory(
      darwinNotificationCategoryText,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.text(
          'text_1',
          'Action 1',
          buttonTitle: 'Send',
          placeholder: 'Placeholder',
        ),
      ],
    ),
    DarwinNotificationCategory(
      darwinNotificationCategoryPlain,
      actions: <DarwinNotificationAction>[
        DarwinNotificationAction.plain('id_1', 'Action 1'),
        DarwinNotificationAction.plain(
          'id_2',
          'Action 2 (destructive)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.destructive,
          },
        ),
        DarwinNotificationAction.plain(
          navigationActionId,
          'Action 3 (foreground)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.foreground,
          },
        ),
        DarwinNotificationAction.plain(
          'id_4',
          'Action 4 (auth required)',
          options: <DarwinNotificationActionOption>{
            DarwinNotificationActionOption.authenticationRequired,
          },
        ),
      ],
      options: <DarwinNotificationCategoryOption>{
        DarwinNotificationCategoryOption.hiddenPreviewShowTitle,
      },
    )
  ];

  static final FirebaseMessagingUtils _firebaseMessagingUtils =
      FirebaseMessagingUtils();

  //   const AndroidNotificationDetails androidPlatformChannelSpecifics =
  // AndroidNotificationDetails(
  //     channelId,   //Required for Android 8.0 or after
  //     channelName: String, //Required for Android 8.0 or after
  //     channelDescription: String, //Required for Android 8.0 or after
  //     importance: Importance,
  //     priority: Priority

  late AndroidNotificationChannel channel;

  static FirebaseMessagingUtils get firebaseMessagingUtils =>
      _firebaseMessagingUtils;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> _onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    print("notification received");
  }

  initFirebaseMessaging() async {
    print("Initializeing the fireabse messaging");
    await Firebase.initializeApp(
        // name: 'get-on',
        // options: DefaultFirebaseOptions.currentPlatform,
        );
    channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        //'This channel is used for important notifications.', // description
        importance: Importance.high,
        playSound: true);

    var initializationSettingsAndroid =
        const AndroidInitializationSettings('noti');
    // var initializationSettingsIOS = IOSInitializationSettings(onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) async {
        await _onDidReceiveLocalNotification;
      },
      notificationCategories: darwinNotificationCategories,
    );

    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        linux: null,
        macOS: null);

    _flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse);

    FirebaseMessaging.onBackgroundMessage(
        await _firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      try {

        if (message.data["notificationType"] == "ignition") {
          if (message.notification!.body.toString().isNotEmpty) {
            //     Map<String, dynamic> jsond = json.decode(message.data["chat_data"]);
            String msg = message.notification!.body.toString();
            //  var msg = MyChatMessage.fromJson(jsond);
            /*if (Get.currentRoute == Routes.CHATS) {
          //    String reciverId = (message.from?.split("/").last).toString();
              String senderId = message.data["senderId"].toString();
              if (Get.find<ChatsController>().args == senderId) {
                Get.find<ChatsController>().addMsg(msg, sendByMe: false);
              }
            } else {
              Get.snackbar(
                message.notification!.title.toString(),
                message.notification!.body.toString(),
                duration: const Duration(seconds: 2),
                onTap: (_) {

                },
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }*/
          }
        }
        else {
        /*  if(message.data["notificationType"]=="block user") {
            if (message.data["userId"] == Get
                .find<GetStorageService>()
                .getCustomeUserId) {
              Get.snackbar(
                message.notification!.title.toString(),
                message.notification!.body.toString(),
                duration: const Duration(seconds: 2),
                onTap: (_) {

                },
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );


              _flutterLocalNotificationsPlugin.show(
                  message.data.hashCode,
                  message.notification!.title.toString(),
                  message.notification!.body.toString(),
                  NotificationDetails(
                    iOS: const DarwinNotificationDetails(),
                    android: AndroidNotificationDetails(
                      channel.id,
                      channel.name,
                    ),
                  ),
                  payload: message.data.toString()
              );


              Get
                  .find<SettingsController>()
                  .onBoardingStatus
                  .value = false;
              Get
                  .find<GlobalData>()
                  .loginData
                  .value = false;
              Get
                  .find<GetStorageService>()
                  .setisLoggedIn = false;
              Get.find<GetStorageService>().deleteLocation();
              Get.find<TokenCreateGenrate>().signOut();
            }
          }
        else if(message.data["notificationType"]=="unblock user") {
            if (message.data["userId"] == Get
                .find<GetStorageService>()
                .getCustomeUserId) {
            Get.snackbar(
              message.notification!.title.toString(),
              message.notification!.body.toString(),
              duration: const Duration(seconds: 2),
              onTap: (_) {

              },
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );

            _flutterLocalNotificationsPlugin.show(
                message.data.hashCode,
                message.notification!.title.toString(),
                message.notification!.body.toString(),
                NotificationDetails(
                  iOS: const DarwinNotificationDetails(),
                  android: AndroidNotificationDetails(
                    channel.id,
                    channel.name,
                  ),
                ),
                payload: message.data.toString()
            );
          }
          }*/


            Get.snackbar(
              message.notification!.title.toString(),
              message.notification!.body.toString(),

              onTap: (_) {

              },
              duration: const Duration(milliseconds: 2000),
              backgroundColor: ColorUtil.kPrimary, colorText: Colors.white,
            );

            _flutterLocalNotificationsPlugin.show(
                message.data.hashCode,
                message.notification!.title.toString(),
                message.notification!.body.toString(),
                NotificationDetails(
                  iOS: const DarwinNotificationDetails(),
                  android: AndroidNotificationDetails(
                    channel.id,
                    channel.name,
                  ),
                ),
                payload: message.data.toString()
                  );


        }


        /*else{
          _flutterLocalNotificationsPlugin.show(
            message.data.hashCode,
            message.notification!.title.toString(),
            message.notification!.body.toString(),
            NotificationDetails(
              iOS: iosNotificationDetails,
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
              ),
            ),
            payload:message.data["notificationType"],
          ); //message.data["user_id"],);
        }*/

        //  print(message.toString());

        // _flutterLocalNotificationsPlugin.show(
        //   message.data.hashCode,
        //   message.notification!.title.toString(),
        //   message.notification!.body.toString(),
        //   NotificationDetails(
        //     iOS: iosNotificationDetails,
        //     android: AndroidNotificationDetails(
        //       channel.id,
        //       channel.name,
        //     ),
        //   ),
        //   payload: json.encode(message.data),
        // );

      } catch (e) {
        print("Error in token listened");
        print(e);
      }
    });
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // It is assumed that all messages contain a data field with the key 'type'
    Future<void> setupInteractedMessage() async {
      // Get any messages which caused the application to open from
      // a terminated state.
      RemoteMessage? initialMessage =
          await FirebaseMessaging.instance.getInitialMessage();

      // If the message also contains a data property with a "type" of "chat",
      // navigate to a chat screen
      if (initialMessage != null) {
        await _firebaseMessagingBackgroundHandler(initialMessage);
      }

      // Also handle any interaction when the app is in the background via a
      // Stream listener
      await FirebaseMessaging.onMessageOpenedApp
          .listen(await _firebaseMessagingBackgroundHandler);
    }

    await setupInteractedMessage();
    _firebaseMessaging.requestPermission(
      sound: true,
      badge: true,
      alert: true,
      provisional: true,
    );

    // _firebaseMessaging.getToken().then((String? token) {
    //   print("Settings token: $token");
    //   // saveFCMTokenSF(token);
    // });
  }

  void _onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (payload != null) {
      Map<String, dynamic> data = json.decode(payload);
    //  Get.toNamed(Routes.NOTIFICATION);
    }else{
     // Get.toNamed(Routes.NOTIFICATION);
    }
  }

  Future<String?> getFcmToken() async {
    return await _firebaseMessaging.getToken();
  }

  Future<void> subFcm(String topic) async {
    await _firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void> unsubFcm(String topic) async {
    await _firebaseMessaging.unsubscribeFromTopic(topic);
  }
}
