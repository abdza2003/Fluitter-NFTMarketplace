import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';

import 'package:sampleproject/Database/dataInf.dart';
import 'package:sampleproject/screen/DetailsScreen2.dart';
import 'package:sampleproject/screen/detailsScreen.dart';

class favoritePageScreen extends StatefulWidget {
  var idKey;
  favoritePageScreen({required this.idKey});
  @override
  State<favoritePageScreen> createState() => _favoritePageScreenState();
}

class _favoritePageScreenState extends State<favoritePageScreen> {
  bool isClick = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: Text('Favorite'),
          centerTitle: true,
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('/newAccount/${widget.idKey}/favorite')
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
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            }
            var newItem = [];
            var s2 = snapshot.data!.docs;

            for (int i = 0; i < s2.length; i++) {
              if (s2[i]['id'] != '') {
                newItem.add(s2[i]['id']);
              }
            }
            print('========== ${newItem}');
            return ListView.builder(
              itemCount: newItem.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding: EdgeInsets.only(top: 10, left: 10, right: 10),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          child: DetailsScreen2(
                              idKey: widget.idKey,
                              index: dataInf[int.parse(newItem[index])]['id'],
                              current_price: dataInf[int.parse(newItem[index])]
                                  ['price'],
                              description: dataInf[int.parse(newItem[index])]
                                  ['description'],
                              image_code: dataInf[int.parse(newItem[index])]
                                  ['code'],
                              image_url_items:
                                  dataInf[int.parse(newItem[index])]
                                      ['imageUrl'],
                              label: '124GA'),
                          type: PageTransitionType.rightToLeft,
                          duration: Duration(milliseconds: 300),
                        ),
                      );
                    },
                    child: Card(
                      color: Colors.blue,
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(),
                          color: Colors.blueGrey[400],
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 100,
                                    height: 100,
                                    child: Image.asset(
                                      dataInf[int.parse(newItem[index])]
                                          ['imageUrl'],
                                      width: 150,
                                      height: 150,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 200,
                                          child: Text(
                                            '${dataInf[int.parse(newItem[index])]['title']} Nft Collactions',
                                            style: GoogleFonts.oswald(
                                              fontSize: 20,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          child: Row(
                                            children: [
                                              Icon(
                                                FontAwesomeIcons.ethereum,
                                                color: Colors.black,
                                              ),
                                              SizedBox(
                                                width: 5,
                                              ),
                                              Text(
                                                '${dataInf[int.parse(newItem[index])]['price']}', ////
                                                style: TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            );
          },
        ));
  }
}
