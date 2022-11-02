import 'package:parkingapp/mqtt/mqtt_manager.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:parkingapp/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
//import 'package:permission_handler/permission_handler.dart';

void main() async{
  ///var w = WrapperMQTT('4f65d161a8d94f0a89bf377bbe7164a4.s1.eu.hivemq.cloud', 8883, 'parksysapp','Psa12345678','android');
  ///w.connect();
  ///
  WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp(
       options: DefaultFirebaseOptions.currentPlatform,
  );
  MQTTClientWrapper client = MQTTClientWrapper();
  client.prepareMqttClient();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]
    );

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Parking App',
        theme: ThemeData(
            primarySwatch: const MaterialColor(0xFFFFD60A, <int, Color>{
              50: Color(0xFFFFFAE2),
              100: Color(0xFFFFF3B6),
              200: Color(0xFFFFEB85),
              300: Color(0xFFFFE254),
              400: Color(0xFFFFDC2F),
              500: Color(0xFFFFD60A),
              600: Color(0xFFFFD109),
              700: Color(0xFFFFCC07),
              800: Color(0xFFFFC605),
              900: Color(0xFFFFBC03),
            }),
            fontFamily: 'Menlo',
            scaffoldBackgroundColor: const Color(0xFF222222)),
        home: const MyHomePage(title: 'Parking App')
    );
  }
}