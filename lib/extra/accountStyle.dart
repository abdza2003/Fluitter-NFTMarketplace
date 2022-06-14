import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

class accountStyle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //   context,
        //   PageTransition(
        //     child: myAccountScreen(idKey: ''),
        //     type: PageTransitionType.rightToLeft,
        //     duration: Duration(milliseconds: 300),
        //   ),
        // );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        width: 250,
        height: 230,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blueGrey,
        ),
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 120,
                  width: 250,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      image: DecorationImage(
                        image: AssetImage('images/bage2.jpg'),
                        fit: BoxFit.cover,
                      )),
                ),
                Transform.translate(
                  offset: Offset(0, 60),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 40,
                    child: Image.asset(
                      'images/v3.png',
                      width: 70,
                      height: 70,
                    ),
                  ),
                ),
              ],
            ),
            Transform.translate(
              offset: Offset(0, 40),
              child: Text(
                'Full Name',
                style: GoogleFonts.oswald(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(0, 35),
              child: Text(
                'Code',
                style: GoogleFonts.oswald(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
