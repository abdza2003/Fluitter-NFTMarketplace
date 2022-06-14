import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sampleproject/start/authPageScreen.dart';

class startPageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SafeArea(
          child: Card(
            elevation: 10,
            margin: EdgeInsets.all(25),
            child: Container(
              height: 700,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'images/v3.png',
                    height: 175,
                    width: 175,
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Container(
                    // color: Colors.red,
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'Welcome to ',
                          style: GoogleFonts.rubik(
                              fontSize: 30, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          'OpenSea',
                          style: GoogleFonts.rubik(
                              fontSize: 30, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          'Start shopping now with',
                          style: GoogleFonts.rubik(
                            fontSize: 20, /* fontWeight: FontWeight.bold */
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 39,
                            ),
                            Text(
                              'NFT\'s',
                              style: GoogleFonts.rubik(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                            ),
                            Text(
                              ' collection',
                              style: GoogleFonts.rubik(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account ?!',
                        style: GoogleFonts.workSans(
                            fontSize: 15, fontWeight: FontWeight.normal),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      GestureDetector(
                        onTap: (() {
                          Navigator.pushReplacement(
                            context,
                            PageTransition(
                              child: authPageScreen(authMode: AuthMode.Login),
                              type: PageTransitionType.bottomToTop,
                              duration: Duration(milliseconds: 300),
                            ),
                          );
                        }),
                        child: Text(
                          'Log in',
                          style: GoogleFonts.roboto(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                            decoration: TextDecoration.underline,
                            decorationThickness: 2,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30),
                    child: ElevatedButton(
                      onPressed: (() {
                        Navigator.pushReplacement(
                          context,
                          PageTransition(
                            child: authPageScreen(authMode: AuthMode.SignUp),
                            type: PageTransitionType.bottomToTop,
                            duration: Duration(milliseconds: 300),
                          ),
                        );
                      }),
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        // padding: EdgeInsets.all(20),
                        child: Text(
                          'Create account now',
                          style: Theme.of(context).textTheme.headline1,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
