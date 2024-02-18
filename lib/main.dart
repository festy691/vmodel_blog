import 'package:blog/core/di/injection_container.dart';
import 'package:blog/core/provider/get_provider.dart';
import 'package:blog/core/utils/constants.dart';
import 'package:blog/screens/home_screens/home_screen.dart';
import 'package:blog/screens/intro_screens/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import 'core/network/url_config.dart';

void main()  async{
  WidgetsFlutterBinding.ensureInitialized();

  await initHiveForFlutter();
  //initialize singletons
  await init(
      environment: kReleaseMode ? Environment.production : Environment.staging);

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then(
        (_) => runApp(MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: Providers.getProviders,
      child: ScreenUtilInit(
        designSize: const Size(414, 896),
        builder: (context, widget) {
          return GetMaterialApp(
            title: appName,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: const SplashScreen(),
          );
        }
      ),
    );
  }
}
