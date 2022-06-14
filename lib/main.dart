import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sampleproject/Firebase/Auth.dart';
import 'package:sampleproject/getScreen.dart';
import 'package:sampleproject/start/startPageScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    nftApp(),
  );
}

class nftApp extends StatefulWidget {
  @override
  State<nftApp> createState() => _nftAppState();
}

class _nftAppState extends State<nftApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Auth>(
          create: ((context) => Auth()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.blueGrey[800],
          primarySwatch: Colors.blue,
          textTheme: TextTheme(
            headline1: GoogleFonts.rubik(
              //// Botun theme
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            headline2: GoogleFonts.oswald(
              //// خط الكتابة على الصور
              fontSize: 25,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        home: welcomeScreen(),
      ),
    );
  }
}

class welcomeScreen extends StatefulWidget {
  @override
  State<welcomeScreen> createState() => _welcomeScreenState();
}

class _welcomeScreenState extends State<welcomeScreen> {
  @override
  void initState() {
    super.initState();
    _navigator();
  }

  _navigator() async {
    SharedPreferences a1 = await SharedPreferences.getInstance();
    var idKey = a1.getString('key');
    var fetch = a1.getBool('fetch');
    print('fetch ========== ${idKey}');
    await Future.delayed(Duration(seconds: 1), (() {
      Navigator.push(
        context,
        PageTransition(
          child: fetch == true
              ? getScreen(
                  idKey: idKey,
                )
              : startPageScreen(),
          type: PageTransitionType.fade,
          duration: Duration(milliseconds: 300),
        ),
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.cyan[900],
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/v3.png',
                width: 120,
                height: 120,
                fit: BoxFit.cover,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                'OpenSea',
                style: GoogleFonts.anton(
                    fontSize: 50, color: Colors.white, letterSpacing: 1),
              )
            ],
          ),
        ));
  }
}
