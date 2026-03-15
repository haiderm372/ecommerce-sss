import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import './firebase_options.dart';
import './configs/routes/routes.dart';
import './configs/themes/themes.dart';
import './configs/global/context.dart';
import './configs/themes/settings.dart';
import './data/local_db/local_db_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await LocalDbService.isar;
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  AppSettings().configureEasyLoading();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppThemes.context = context;

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarDividerColor: Colors.white,
        //Brightness
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return ProviderScope(
      child: MaterialApp.router(
        title: 'Flutter Ecommerce',
        themeMode: ThemeMode.light,
        routerConfig: AppRoutes.routes,
        debugShowCheckedModeBanner: false,
        theme: AppThemes().lightTheme(),
        darkTheme: AppThemes().darkTheme(),
        scaffoldMessengerKey: AppContext.scaffoldMessengerKey,
        builder: EasyLoading.init(),
      ),
    );
  }
}
