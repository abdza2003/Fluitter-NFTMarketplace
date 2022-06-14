import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sampleproject/screen/myAccountScreen.dart';

class personalAccounts extends StatefulWidget {
  String image; /* 
  String fullName;
  String code; */
  personalAccounts({
    required this.image,
/*     required this.fullName,
    required this.code, */
  });
  @override
  State<personalAccounts> createState() => _personalAccountsState();
}

class _personalAccountsState extends State<personalAccounts> {
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (() {
        Navigator.push(
          context,
          PageTransition(
            child: myAccountScreen(
              idKey: '',
            ),
            type: PageTransitionType.rightToLeft,
            duration: Duration(milliseconds: 300),
          ),
        );
      }),
      child: Card(
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: double.infinity,
          padding: EdgeInsets.all(20),
          height: isClick ? 185 : 130,
          color: Colors.blueGrey,
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blue[200],
                      radius: 40,
                      child: CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: widget.image,
                        placeholder: (context, url) => Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedOpacity(
                              duration: Duration.zero,
                              opacity: .5,
                              child: Image.asset('images/v3.png'),
                            ),
                            CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'widget.fullName',
                            style: Theme.of(context).textTheme.headline2,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'widget.code',
                            style: GoogleFonts.oswald(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                isClick = !isClick;
                              });
                              print('object');
                            },
                            child: Text(
                              isClick == true ? '-less' : '+more',
                              style: TextStyle(
                                fontSize: 15,
                                color: Colors.white70,
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                if (isClick == true)
                  Column(
                    children: [
                      SizedBox(
                        width: 300,
                        child: Divider(
                          color: Colors.white54,
                          thickness: 1.2,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text(
                                '7.2',
                                style: GoogleFonts.arvo(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                              Text('items',
                                  style: GoogleFonts.oswald(
                                    fontSize: 15,
                                    color: Colors.white,
                                  )),
                            ],
                          ),
                          SizedBox(
                            width: 40,
                          ),
                          Column(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.ethereum,
                                  ),
                                  Text(
                                    '7.2',
                                    style: GoogleFonts.arvo(
                                      fontSize: 15,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              Text(
                                '   traded',
                                style: GoogleFonts.oswald(
                                  fontSize: 15,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
