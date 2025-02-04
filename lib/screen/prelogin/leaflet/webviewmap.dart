import 'dart:async';

import 'package:flutter/material.dart';
import 'package:idaman/api/api_service.dart';
import 'package:idaman/models/Bidang.dart';
import 'package:idaman/models/UmkmData.dart';
import 'package:idaman/screen/Messages/messages_screen.dart';
import 'package:idaman/screen/login/login_screen.dart';
import 'package:idaman/screen/penjual/usaha/usaha_screen.dart';
import 'package:idaman/screen/prelogin/leaflet/floatingSearchBar.dart';
import 'package:webview_flutter/webview_flutter.dart';
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:geolocator/geolocator.dart';

import '../../../constants.dart';
import '../../../main.dart';

List<BidangModel> bidang = [];

class WebViewMap extends StatefulWidget {
  WebViewMap({Key? key}) : super(key: key);

  static const routeName = '/webmap';

  @override
  WebViewerFSState createState() => WebViewerFSState();
}



// Future<bool> _exitApp(BuildContext context) async {
//   if (await _webViewController.canGoBack()) {
//     print("onwill goback");
//     _webViewController.goBack();
//   } else {
//     Scaffold.of(context).showSnackBar(
//       const SnackBar(content: Text("No back history item")),
//     );
//     return Future.value(false);
//   }
// }


class WebViewerFSState extends State<WebViewMap> {
  late final WebViewController _webViewController;
  static const String _kLocationServicesDisabledMessage = 'Location services are disabled.';
  static const String _kPermissionDeniedMessage = 'Permission denied.';
  static const String _kPermissionDeniedForeverMessage = 'Permission denied forever.';
  static const String _kPermissionGrantedMessage = 'Permission granted.';

  final GeolocatorPlatform _geolocatorPlatform = GeolocatorPlatform.instance;
  final List<_PositionItem> _positionItems = <_PositionItem>[];
  StreamSubscription<Position>? _positionStreamSubscription;
  StreamSubscription<ServiceStatus>? _serviceStatusStreamSubscription;
  bool positionStreamStarted = false;
  String lat = "0";
  String lon = "0";


  Future<bool> _onBack() async{
    bool goBack;
    var value = await _webViewController.canGoBack();
    if(value){
      _webViewController.goBack();
      return false;
    }

    return true;
  }

  @override
  void initState() {
    loadBidang(context);
    super.initState();
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            _getCurrentPosition();
            _webViewController.runJavaScriptReturningResult("getTerdekat('"+ endPoint +"get_usaha?id=1&user_lon="+ lon +"&user_lat="+lat+"&radius=50&batas=25')");
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              debugPrint('blocking navigation to ${request.url}');
              return NavigationDecision.prevent;
            }
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
        ),
      )
      ..addJavaScriptChannel(
        'Android',
        onMessageReceived: (JavaScriptMessage message) async{
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text(message.message)),
          // );
          print(message.message);
          if(message.message == "getmylocation"){
            _getCurrentPosition();
            print("dari web = " + message.message);
          }
          if(message.message == "getmyicon"){
            //
          }
          List<String> koman = message.message.split(";");
          if(koman[0]== "openkomentar"){
            Navigator.pushNamed(
              context,
              "/messages",
              arguments: MessagesArguments(
                  koman[1],koman[2],koman[3]
              ),
            );
          }
          if(koman[0]== "backtologin"){
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context){
                    return LoginScreen();
                  }
              ),
                  (route) => false,
            );
          }
          if(koman[0]== "getnik"){
            _webViewController.runJavaScript("setMyData("+ MyApp.localStorage.get("nik").toString() + "," + MyApp.localStorage.get("displayName").toString()  + "')");
          }
          if(koman[0]== "detailusaha"){
            List<Umkm> nbumkm = [];
            APIService apiService = new APIService();
            await apiService.getUmkm("&cari=umkm_usaha.id&ini="+ koman[1], "0", "0", 0, 1).then((value) {
              nbumkm = value;
              setState(() {

              });
              Navigator.pushNamed(
                  context,
                  UsahaScreen.routeName,
                  arguments: UsahaScreenArguments(
                      namaUsaha: nbumkm[0].nama_usaha,
                      idUsaha: int.parse(koman[1]),
                      usaha: nbumkm[0]
                  )
              );
            });

          }
        },
      );

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _webViewController = controller;
    _toggleServiceStatusStream();

  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as WebViewFSArguments;

    return WillPopScope(
      onWillPop: _onBack,
      child: Scaffold(
        // appBar: AppBar(
        //   leading: (ModalRoute.of(context)?.canPop ?? false) ? BackButton() : null,
        //   backgroundColor: Colors.red,
        //   title: Text("Peta Tabe"),
        // ),
        endDrawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/flat_bg.png")
                  ),
                  //color: Colors.green,
                ),
                child: Text(
                    'Pilih Bidang Usaha',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25
                  ),
                ),
              ),
              ...List.generate(
                  bidang.length,
                      (index) => ListTile(
                        // leading: SvgPicture.network(
                        //     bidang[index].icon,
                        //   width: 20,
                        //   height: 20,
                        // ),
                        title: Text(bidang[index].bidang),
                        onTap: () {
                          print("klik kategori ");
                          _webViewController.runJavaScript("getTerdekat('"+ endPoint +"get_usaha?id=1&user_lon="+ lon +"&user_lat="+lat+"&radius=5&batas=100&cariapa=bidang_usaha&cariini="+bidang[index].bidang+"')");
                          Navigator.of(context).pop();
                          },
                      ),
              )
            ],
          ),
        ),
        body: Stack(
          children: [
            WebViewWidget(
               controller: _webViewController
              ..loadRequest(Uri.parse(args.url)),
            ),
            FloatingSearchCustom(cariCallback: (query) {
               _webViewController.runJavaScript("getTerdekat('"+ endPoint +"get_usaha?id=1&user_lon="+ lon +"&user_lat="+lat+"&radius=5&batas=100&cariapa=nama_usaha&cariini="+query+"')");
            })
          ],
        ),
       // bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
      ),
    );
  }

  translateCmd(BuildContext context,String cmd){
    List<String> koman = cmd.split(";");
    if(koman[0]=="goToScreen"){
      Navigator.pushNamed(
          context,
          "/" + koman[1]
      );
    }else if(koman[0]=="openGrup"){
      Navigator.pushNamed(
        context,
        "/messages",
        arguments: MessagesArguments(
            koman[1],koman[2],koman[3]
        ),
      );
    }
  }

  //untuk penggunaan gps

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handlePermission();

    if (!hasPermission) {
      return;
    }

    final position = await _geolocatorPlatform.getCurrentPosition();
    _updatePositionList(
      _PositionItemType.position,
      position.toString(),
    );

    print(position.toString());
    lat = position.latitude.toString();
    lon = position.longitude.toString();

    //print("my location is " + position.toString() + ", icon = " + KejaksaanApp.localStorage.get("icon").toString());
    _webViewController.runJavaScript("setMyLoc("+ position.latitude.toString() + "," + position.longitude.toString() + ",'" + MyApp.localStorage.get("icon").toString() + "')");
  }


  Future<bool> _handlePermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await _geolocatorPlatform.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      _updatePositionList(
        _PositionItemType.log,
        _kLocationServicesDisabledMessage,
      );

      return false;
    }

    permission = await _geolocatorPlatform.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await _geolocatorPlatform.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        _updatePositionList(
          _PositionItemType.log,
          _kPermissionDeniedMessage,
        );

        return false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      _updatePositionList(
        _PositionItemType.log,
        _kPermissionDeniedForeverMessage,
      );

      return false;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    _updatePositionList(
      _PositionItemType.log,
      _kPermissionGrantedMessage,
    );
    return true;
  }

  void _updatePositionList(_PositionItemType type, String displayValue) {
    _positionItems.add(_PositionItem(type, displayValue));
    setState(() {});
  }

  bool _isListening() => !(_positionStreamSubscription == null ||
      _positionStreamSubscription!.isPaused);

  Color _determineButtonColor() {
    return _isListening() ? Colors.green : Colors.red;
  }

  void _toggleServiceStatusStream() {
    if (_serviceStatusStreamSubscription == null) {
      final serviceStatusStream = _geolocatorPlatform.getServiceStatusStream();
      _serviceStatusStreamSubscription =
          serviceStatusStream.handleError((error) {
            _serviceStatusStreamSubscription?.cancel();
            _serviceStatusStreamSubscription = null;
          }).listen((serviceStatus) {
            String serviceStatusValue;
            if (serviceStatus == ServiceStatus.enabled) {
              if (positionStreamStarted) {
                _toggleListening();
              }
              serviceStatusValue = 'enabled';
            } else {
              if (_positionStreamSubscription != null) {
                setState(() {
                  _positionStreamSubscription?.cancel();
                  _positionStreamSubscription = null;
                  _updatePositionList(
                      _PositionItemType.log, 'Position Stream has been canceled');
                });
              }
              serviceStatusValue = 'disabled';
            }
            _updatePositionList(
              _PositionItemType.log,
              'Location service has been $serviceStatusValue',
            );
          });
    }
  }

  void _toggleListening() {
    if (_positionStreamSubscription == null) {
      final positionStream = _geolocatorPlatform.getPositionStream();
      _positionStreamSubscription = positionStream.handleError((error) {
        _positionStreamSubscription?.cancel();
        _positionStreamSubscription = null;
      }).listen((position) => _updatePositionList(
        _PositionItemType.position,
        position.toString(),
      ));
      _positionStreamSubscription?.pause();
    }

    setState(() {
      if (_positionStreamSubscription == null) {
        return;
      }

      String statusDisplayValue;
      if (_positionStreamSubscription!.isPaused) {
        _positionStreamSubscription!.resume();
        statusDisplayValue = 'resumed';
      } else {
        _positionStreamSubscription!.pause();
        statusDisplayValue = 'paused';
      }

      _updatePositionList(
        _PositionItemType.log,
        'Listening for position updates $statusDisplayValue',
      );
    });
  }

  @override
  void dispose() {
    if (_positionStreamSubscription != null) {
      _positionStreamSubscription!.cancel();
      _positionStreamSubscription = null;
    }

    super.dispose();
  }

  void _getLastKnownPosition() async {
    final position = await _geolocatorPlatform.getLastKnownPosition();
    if (position != null) {
      _updatePositionList(
        _PositionItemType.position,
        position.toString(),
      );
    } else {
      _updatePositionList(
        _PositionItemType.log,
        'No last known position available',
      );
    }
  }

  void _getLocationAccuracy() async {
    final status = await _geolocatorPlatform.getLocationAccuracy();
    _handleLocationAccuracyStatus(status);
  }

  void _requestTemporaryFullAccuracy() async {
    final status = await _geolocatorPlatform.requestTemporaryFullAccuracy(
      purposeKey: "TemporaryPreciseAccuracy",
    );
    _handleLocationAccuracyStatus(status);
  }

  void _handleLocationAccuracyStatus(LocationAccuracyStatus status) {
    String locationAccuracyStatusValue;
    if (status == LocationAccuracyStatus.precise) {
      locationAccuracyStatusValue = 'Precise';
    } else if (status == LocationAccuracyStatus.reduced) {
      locationAccuracyStatusValue = 'Reduced';
    } else {
      locationAccuracyStatusValue = 'Unknown';
    }
    _updatePositionList(
      _PositionItemType.log,
      '$locationAccuracyStatusValue location accuracy granted.',
    );
  }

  void _openAppSettings() async {
    final opened = await _geolocatorPlatform.openAppSettings();
    String displayValue;

    if (opened) {
      displayValue = 'Opened Application Settings.';
    } else {
      displayValue = 'Error opening Application Settings.';
    }

    _updatePositionList(
      _PositionItemType.log,
      displayValue,
    );
  }

  void _openLocationSettings() async {
    final opened = await _geolocatorPlatform.openLocationSettings();
    String displayValue;

    if (opened) {
      displayValue = 'Opened Location Settings';
    } else {
      displayValue = 'Error opening Location Settings';
    }

    _updatePositionList(
      _PositionItemType.log,
      displayValue,
    );
  }

  loadBidang(BuildContext context) async{
    APIService apiService = new APIService();
    await apiService.getBidang("").then((value) {
      bidang = value;
    });
    setState(() {

    });
  }
}

enum _PositionItemType {
  log,
  position,
}

class _PositionItem {
  _PositionItem(this.type, this.displayValue);

  final _PositionItemType type;
  final String displayValue;
}

class WebViewFSArguments {
  final String url;

  WebViewFSArguments(this.url);
}