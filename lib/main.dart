
import 'dart:async';

import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/routes.dart';
import 'package:idaman/screen/splash/splash_screen.dart';
import 'package:idaman/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_background_service/flutter_background_service.dart';
// import 'package:flutter_background_service_android/flutter_background_service_android.dart';

import 'constants.dart';


import 'package:flutter/foundation.dart' show kIsWeb;

import 'models/profil_post.dart';
import 'models/profil_post_response_model.dart';



// final service = FlutterBackgroundService();

void main() async {
  // try {
  //   MyApp.localStorage = SharedPreferences.getInstance() as SharedPreferences;
  // }catch(e){
  //   print("SF Error "  + e.toString());
  // }

  // Uri url = Uri.parse("https://admin.indera.id/public/api/app?app_id=1208&app_token=124177417");
  // try{
  //   final response = await http.get(url);
  //
  //   if (response.statusCode == 200 || response.statusCode == 400) {
  //     AppModel appModel = AppModel.fromJson(json.decode(response.body));
  //     if(appModel.apiStatus==1){
  //       endPointUrl = appModel.url.toString();
  //       endPoint = appModel.url.toString() + "/api/";
  //       endPointLogin = appModel.url.toString() + "/api/";
  //       endPointPublic = appModel.url.toString() + "/";
  //       banner = appModel.photo.toString();
  //     }
  //   } else {
  //     throw Exception('Failed to load data!');
  //   }
  // }catch (e){
  //   print(e.toString());
  // }

  isWeb = kIsWeb;

  WidgetsFlutterBinding.ensureInitialized();

  // await NotificationController.initializeLocalNotifications();

  //initializeService();

  // AwesomeNotifications().initialize(
  //   'resource://drawable/res_notification_app_icon',
  //     [
  //       NotificationChannel(
  //           channelGroupKey: 'basic_channel_group',
  //           channelKey: 'basic_channel',
  //           channelName: 'Basic notifications',
  //           channelDescription: 'Notification channel for basic tests',
  //           defaultColor: Color(0xFF9D50DD),
  //           ledColor: Colors.white)
  //     ],
  //     // Channel groups are only visual and are not required
  //     channelGroups: [
  //       NotificationChannelGroup(
  //           channelGroupKey: 'basic_channel_group',
  //           channelGroupName: 'Basic group')
  //     ],
  //   // [
  //   //   NotificationChannel(
  //   //       channelKey: 'idaman_notifications',
  //   //       channelName: 'Notifikasi Idaman',
  //   //       channelDescription: 'Notification from Idaman',
  //   //       playSound: true,
  //   //       onlyAlertOnce: true,
  //   //       groupAlertBehavior: GroupAlertBehavior.Children,
  //   //       importance: NotificationImportance.High,
  //   //       defaultPrivacy: NotificationPrivacy.Private,
  //   //       defaultColor: Colors.deepPurple,
  //   //       ledColor: Colors.deepPurple
  //   //   ),
  //   //   // NotificationChannel(
  //   //   //   channelKey: 'scheduled_channel',
  //   //   //   channelName: 'Scheduled Notifications',
  //   //   //   defaultColor: Colors.teal,
  //   //   //   locked: true,
  //   //   //   importance: NotificationImportance.High,
  //   //   //   soundSource: 'resource://raw/res_custom_notification',
  //   //   //   channelDescription: '',
  //   //   // ),
  //   // ],
  //     debug: true);
  // // HttpOverrides.global = MyHttpOverrides();
  runApp(const Runner());
}



// class MyHttpOverrides extends HttpOverrides{
//   @override
//   HttpClient createHttpClient(SecurityContext? context){
//     return super.createHttpClient(context)
//       ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
//   }
// }


Future<void> showCustomTrackingDialog(BuildContext context) async =>
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pengguna Yang Terhormat'),
        content: const Text(
          'Kami peduli dengan privasi data anda. Aplikasi ini akan membagikan data umum anda. '
              'Apakah anda setuju dengan hal ini ?'
              '\n\nPengunjung dapat melihat produk anda tapi tidak dapat melihat data diri anda.'
              '\n\nNamun Anda dapat mengubah ini di app settings.',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Lanjutkan'),
          ),
        ],
      ),
    );

Future<void> initPlugin(BuildContext context) async {

  final TrackingStatus status = await AppTrackingTransparency.trackingAuthorizationStatus;
  trackAuthStatus = '$status';
  // If the system can show an authorization request dialog
  if (status == TrackingStatus.notDetermined) {
    // Show a custom explainer dialog before the system dialog
    await showCustomTrackingDialog(context);
    // Wait for dialog popping animation
    await Future.delayed(const Duration(milliseconds: 200));
    // Request system's tracking authorization dialog
    final TrackingStatus status =
    await AppTrackingTransparency.requestTrackingAuthorization();
    trackAuthStatus = '$status';
  }
  print(trackAuthStatus);
  String sharing = trackAuthStatus == "TrackingStatus.authorized" ? "1" : "0";
  //if(trackAuthStatus != "Unknown") {
  APIService api = new APIService();
  ProfilPostResponseModel prm = await api.updateProfil(
      ProfilPostModel(
          id: MyApp.localStorage.getString("id").toString(),
          display_name: "",
          photo: "",
          email: "",
          icon: "",
          spesimen_tte: "",
          sharing: sharing
      )
  );
  if (prm.apiStatus == 1) {
    final snackBar = SnackBar(
        content: Text(
            "Tracking updated")
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}

Future<void> initializeService() async {
  // final service = FlutterBackgroundService();
  // await service.configure(
  //   androidConfiguration: AndroidConfiguration(
  //     // this will be executed when app is in foreground or background in separated isolate
  //     onStart: onStart,
  //
  //     // auto start service
  //     autoStart: true,
  //     isForegroundMode: true,
  //   ),
  //   iosConfiguration: IosConfiguration(
  //     // auto start service
  //     autoStart: true,
  //
  //     // this will be executed when app is in foreground in separated isolate
  //     onForeground: onStart,
  //
  //     // you have to enable background fetch capability on xcode project
  //     onBackground: onIosBackground,
  //   ),
  // );
  // service.startService();
}


// bool onIosBackground(ServiceInstance service) {
//   WidgetsFlutterBinding.ensureInitialized();
//   print('FLUTTER BACKGROUND FETCH');
//
//   return true;
// }

// void onStart(ServiceInstance service) async {
//
//   // Only available for flutter 3.0.0 and later
//  // DartPluginRegistrant.ensureInitialized();
//
//   // For flutter prior to version 3.0.0
//   // We have to register the plugin manually
//
//
//   MyApp.localStorage = await SharedPreferences.getInstance();
//   // await preferences.setString("hello", "world");
//
//   if (service is AndroidServiceInstance) {
//     service.on('setAsForeground').listen((event) {
//       service.setAsForegroundService();
//     });
//
//     service.on('setAsBackground').listen((event) {
//       service.setAsBackgroundService();
//     });
//   }
//
//   service.on('stopService').listen((event) {
//     service.stopSelf();
//   });
//
//   // bring to foreground
//   Timer.periodic(const Duration(seconds: 30), (timer) async {
//     //final hello = preferences.getString("hello");
//     print("service on");
//
//     if (service is AndroidServiceInstance) {
//       service.setForegroundNotificationInfo(
//         title: "Idaman Service",
//         content: "",
//       );
//     }
//
//     /// you can see this log in logcat
//     // test using external plugin
//     final deviceInfo = DeviceInfoPlugin();
//     String? device;
//     if (Platform.isAndroid) {
//       final androidInfo = await deviceInfo.androidInfo;
//       device = androidInfo.model;
//     }
//
//     if (Platform.isIOS) {
//       final iosInfo = await deviceInfo.iosInfo;
//       device = iosInfo.model;
//     }
//
//     print('IDAMAN BACKGROUND SERVICE: ${DateTime.now()}');
//       //print(MyApp.localStorage.getString("nik").toString().length);
//     if(MyApp.localStorage.getString('nik').toString().length==16) {
//       MyApp.getNotif();
//     }
//
//     service.invoke(
//       'update',
//       {
//         "current_date": DateTime.now().toIso8601String(),
//         "device": device,
//       },
//     );
//   });
// }

class Runner extends StatelessWidget {
  const Runner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      builder: (context, child) {
        return MyApp();
      }
    );
  }
}



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  static late SharedPreferences localStorage;

  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // static getNotif() async {
  //   // if (localStorage.getString("nik").toString().isNotEmpty && localStorage.getString("nik")!=null) {
  //     APIService api = new APIService();
  //     NotifikasiModel nm = await api.getNotif(MyApp.localStorage.getString("nik").toString(), 'baru', 0, 10);
  //     List<Data>? datas = nm.data;
  //     for (Data data in datas!) {
  //       print(data.content);
  //       NotificationController.createChatProdukNotification(data.id.toString(), "Pesan masuk", data.content.toString());
  //       // NotificationLayout nl = NotificationLayout.Default;
  //       // if (data.gambar.toString().isNotEmpty && data.gambar.toString()!="null") {
  //       //   nl = NotificationLayout.BigPicture;
  //       // }
  //       // createTabeBasicNotification(
  //       //     int.parse(data.masterNotifId.toString()), "Idaman",
  //       //     data.content.toString(), data.gambar.toString(), nl
  //       // );
  //     }
  //   // }else{
  //   //   localStorage.reload();
  //   // }
  // }

  static reloadSF(){
    localStorage.reload();
    // service.invoke("stopService");
  }

  static startBGService(){
    // service.startService();
  }

  static initBGService() async{
    await initializeService();
  }

  static stopBGService(){
    //service.stopSelf();
  }


  static initTrackAuth(BuildContext context) {
    initPlugin(context);
  }


  static void useCamera (BuildContext ctx, String title, String konten, Function() ifNo, Function() ifYes){
    showDialog(
        context: ctx,
        builder: (context) => AlertDialog(
          title: Text(title),
          content: Text(konten),
          actions: [
            TextButton(
              onPressed: ifNo,
              child: Text(
                'Tidak',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ),
            TextButton(
              onPressed: ifYes,
              child: Text(
                'Ijinkan',
                style: TextStyle(
                  color: Colors.teal,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        )
    );
  }

  @override
  State<MyApp> createState() => _MyAppState();

}


class _MyAppState extends State<MyApp> {

  @override
  initState() {
    // NotificationController.startListeningNotificationEvents();
    super.initState();
    // loadAll();
  }

  void loadAll() async{
    MyApp.localStorage = await SharedPreferences.getInstance();
    // setUpTimedFetch();
  }

  // setUpTimedFetch() {
  //   Timer.periodic(Duration(milliseconds: 10000), (timer) {
  //     setState(() {
  //       MyApp.getNotif();
  //     });
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    String text = "Stop Service";
    //init();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IDAMAN',
      theme: theme(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}


// ThemeData theme(){
//   return ThemeData(
//     scaffoldBackgroundColor: Colors.white,
//     fontFamily: "Muli",
//     appBarTheme: const AppBarTheme(
//       color: Colors.white,
//       elevation: 0,
//       iconTheme: IconThemeData(
//         color: Colors.black,
//     ),
//     textTheme: const TextTheme(
//       bodyText1: TextStyle(color: Colors.black),
//       bodyText2: TextStyle(color: Colors.black),
//       headline6: TextStyle(color: Colors.black,
//           fontSize: 18
//       ),
//     ),
//     systemOverlayStyle: SystemUiOverlayStyle.light
//   )
//   );
// }