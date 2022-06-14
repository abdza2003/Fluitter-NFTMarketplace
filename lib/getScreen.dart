import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sampleproject/extra/drawer.dart';

import 'package:sampleproject/screen/coinListScreen.dart';
import 'package:sampleproject/screen/homePageScreen.dart';
import 'package:sampleproject/screen/myAccountScreen.dart';
import 'package:sampleproject/screen/ownerScreen.dart';

class getScreen extends StatefulWidget {
  var idKey;
  getScreen({this.idKey});
  @override
  State<getScreen> createState() => _getScreenState();
}

class _getScreenState extends State<getScreen> {
  int next = 0;

  /// ل تحديد الصفحة الرئيسية عند فتح الصغحة
  void _nextPage(int index) {
    setState(() {
      next = index; // من اجل زيادة عندما يتم التغيير
    });
  }

  List<Widget> getBodyInf = [];
  @override
  void initState() {
    getBodyInf = [
      homePageScreen(idKey: widget.idKey),
      ownerScreen(idKey: widget.idKey),
      coinListScreen(idKey: widget.idKey),
      myAccountScreen(idKey: widget.idKey),
    ];

    super.initState();
  }

  // void showToast(String msg) {
  //   Toast.show(msg, duration: Toast.center, gravity: Toast.center);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: drawer(
          idKey: widget.idKey,
        ),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          getBodyInf[next],
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            label: 'Home Page',
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Icon(Icons.home),
            ),
            backgroundColor: Colors.blueGrey,
          ),
          BottomNavigationBarItem(
            label: 'Owner',
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Icon(FontAwesomeIcons.crown),
            ),
            backgroundColor: Colors.blueGrey,
          ),
          BottomNavigationBarItem(
            label: 'Currencies',
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Icon(FontAwesomeIcons.coins),
            ),
            backgroundColor: Colors.blueGrey,
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Icon(FontAwesomeIcons.user),
            ),
            backgroundColor: Colors.blueGrey,
          ),
        ],
        onTap: _nextPage,
        currentIndex: next,
        selectedLabelStyle:
            GoogleFonts.oswald(fontSize: 18, color: Colors.white),
        unselectedIconTheme: IconThemeData(size: 20),
        selectedIconTheme: IconThemeData(size: 25),

        ///  هنا ال INDEX الخاص ب كل صفحة
        showUnselectedLabels: false,
        selectedFontSize: 20,
        type: BottomNavigationBarType.shifting,
      ),
    );
  }
}
