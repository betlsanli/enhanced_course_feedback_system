import 'package:enhanced_course_feedback_system/SplashScreen.dart';
import 'package:enhanced_course_feedback_system/pages/LandingPage.dart';
import 'package:enhanced_course_feedback_system/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:enhanced_course_feedback_system/constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://nzhnrpjexclcxkoyczob.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im56aG5ycGpleGNsY3hrb3ljem9iIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MTM3MDQwODMsImV4cCI6MjAyOTI4MDA4M30.nIpNVrDuIAcYo5ixk_G3_VmzlDplvv7VbM5Q268QsNY',
  );
  runApp(ECFS());
}

class  ECFS extends StatelessWidget {
  const ECFS ({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'), // English
        Locale('tr'),
      ],
      debugShowCheckedModeBanner: false,
      title: "ECFS",
      routes: {
        // '/register' : (context) =>  RegisterPage(isRegistering: false,),
        '/landing' : (context) =>  LandingPage(),
        '/login' : (context) => LoginPage(),
      },
      theme: appTheme,
      home: SplashScreen(),
    );
  }
}
