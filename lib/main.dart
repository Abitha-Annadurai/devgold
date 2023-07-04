import 'package:devgold/register_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Intro_screen.dart';
import 'my_home_page.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 await Firebase.initializeApp();
 //await Future.delayed(const Duration(milliseconds: 500)).then((value) => FlutterNativeSplash.remove());
 // final prefs = await SharedPreferences.getInstance();
  //final showHome = prefs.getBool('showHome') ?? false;
  //runApp(MyApp(showHome: showHome));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  void moveToNextPage(){
    Future.delayed(Duration(seconds: 2), () async {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final bool? move = prefs.getBool('isLoggedIn');
      if (move == true) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return MyHomePage();
        }),
        );
      }
      else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
          return IntroScreen();
        }),
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    moveToNextPage();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/splash.jpg'),
          fit: BoxFit.fill
        ),
      ),
    );
  }
}

