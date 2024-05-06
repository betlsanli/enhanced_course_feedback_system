import 'package:enhanced_course_feedback_system/SplashScreen.dart';
import 'package:enhanced_course_feedback_system/pages/LandingPage.dart';
import 'package:enhanced_course_feedback_system/pages/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:enhanced_course_feedback_system/constants.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  String supabaseUrl = dotenv.env['SUPABASE_URL']!;
  String supabaseAnonKey = dotenv.env['SUPABASE_ANON_KEY']!;
  await Supabase.initialize(
    url: supabaseUrl,
    anonKey: supabaseAnonKey,
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
