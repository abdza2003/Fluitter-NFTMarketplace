import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sampleproject/extra/drawer.dart';
import 'package:sampleproject/screen/myAccountScreen2.dart';

class ownerScreen extends StatefulWidget {
  var idKey;
  ownerScreen({required this.idKey});
  @override
  State<ownerScreen> createState() => _ownerScreenState();
}

class _ownerScreenState extends State<ownerScreen> {
  String idKey2 = '3iD0Aafp8EOCf3XRwouRHrU75ob2';
  bool isClick = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          child: drawer(
            idKey: widget.idKey,
          ),
        ),
        appBar: AppBar(
          // elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text('Trending Collections',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('/newAccount/$idKey2/user/')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                  child: Transform.translate(
                offset: Offset(0, -130),
                child: Text(
                  'No Items',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ));
            }
            List<DocumentSnapshot> s1 = snapshot.data!.docs;

            return !s1.isEmpty
                ? GestureDetector(
                    onTap: (() {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: myAccountScreen2(
                            idKey: widget.idKey,
                            idKey2: idKey2,
                          ),
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 300),
                        ),
                      );
                    }),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      width: double.infinity,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 100, left: 20, right: 20),
                      height: 350,
                      alignment: Alignment.center,
                      color: Colors.blueGrey,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                CircleAvatar(
                                  backgroundColor: Colors.orange[200],
                                  radius: 70,
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      height: 130,
                                      width: 130,
                                      fit: BoxFit.cover,
                                      imageUrl: (s1[0] as dynamic)['image_url'],
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
                                ),
                                Transform.translate(
                                  offset: Offset(0, -10),
                                  child: Icon(
                                    FontAwesomeIcons.crown,
                                    color: Colors.orange,
                                    size: 40,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              '${(s1[0] as dynamic)['userName']}',
                              style: GoogleFonts.breeSerif(
                                fontSize: 30,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${(s1[0] as dynamic)['email']}',
                              style: GoogleFonts.oswald(
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : Text('');
          },
        ));
  }
}
