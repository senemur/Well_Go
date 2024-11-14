import 'package:flutter/material.dart';
import 'package:well_go/pages/onboard_travel.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  //Bu kod, Flutter'ın widgetları yüklemeden önce bazı asenkron işlemleri tamamlamanızı sağlar. ensureInitialized() işlevi, Firebase gibi asenkron işlemler için kullanılabilir hale getirir.
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TravelOnBoardingScreen(),
    );
  }
}
