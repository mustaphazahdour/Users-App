import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:users_app/authentication/onbording.dart';
import 'package:users_app/authentication/welcome.dart';
import 'package:users_app/infoHandler/app_info.dart';
import 'package:users_app/mainScreens/about_screen.dart';
import 'package:users_app/mainScreens/profile_screen.dart';
import 'package:users_app/mainScreens/rate_driver_screen.dart';
import 'package:users_app/mainScreens/select_nearest_active_driver_screen.dart';
import 'package:users_app/mainScreens/trips_history_screen.dart';
import 'package:users_app/splashScreen/splash_screen.dart';
import 'package:users_app/widgets/history_design_ui.dart';
import 'package:users_app/widgets/info_design_ui.dart';
import 'package:users_app/widgets/my_drawer.dart';
import 'package:users_app/widgets/pay_fare_amount_dialog.dart';
import 'package:users_app/widgets/place_prediction_tile.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp( 
    MyApp(
      child: ChangeNotifierProvider(
        create: (context) => AppInfo(),
        child: MaterialApp(
          title: 'User App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: PlacePredictionTileDesign(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    ),
  );
}



class MyApp extends StatefulWidget
{
  final Widget? child;

  MyApp({this.child});

  static void restartApp(BuildContext context)
  {
    context.findAncestorStateOfType<_MyAppState>()!.restartApp();
  }

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>
{
  Key key = UniqueKey();

  void restartApp()
  {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child!,
    );
  }
}



