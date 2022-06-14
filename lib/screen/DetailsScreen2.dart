import 'dart:async';
import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sampleproject/Database/dataInf.dart';
import 'package:sampleproject/extra/imageStyle1.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailsScreen2 extends StatefulWidget {
  String image_url_items;
  double current_price;
  String description;
  String image_code;
  String label;
  int index;
  String idKey;

  DetailsScreen2({
    required this.index,
    required this.current_price,
    required this.description,
    required this.image_code,
    required this.image_url_items,
    required this.label,
    required this.idKey,
  });
  @override
  State<DetailsScreen2> createState() => _descriptionPage2State();
}

class _descriptionPage2State extends State<DetailsScreen2> {
  var top = 0.0;
  var top2 = 400.0;
  var top3 = 0.0;
  var iconColor = Colors.blueGrey[200];
  bool isClick = false;
  bool isClickCard = false;
  bool isClickmore = false;
  @override
  String newName = '';

  String newId = '';

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('/newAccount/${widget.idKey}/favorite/')
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            List<DocumentSnapshot> s1 = snapshot.data!.docs;
            return Stack(
              alignment: Alignment.center,
              children: [
                CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverAppBar(
                      elevation: 0,
                      pinned: true,
                      centerTitle: true,
                      leading: top2 < 130
                          ? IconButton(
                              onPressed: (() {
                                Navigator.of(context).pop(context);
                              }),
                              icon: Icon(
                                FontAwesomeIcons.arrowLeft,
                              ))
                          : Text(''),
                      title: AnimatedOpacity(
                        duration: Duration(milliseconds: 300),
                        opacity: top2 > 130 ? 0 : 1.0,
                        child: Container(
                          height: 60,
                          width: 60,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Image.asset((widget.image_url_items)),
                        ),
                      ),
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      expandedHeight: 350,
                      flexibleSpace: LayoutBuilder(
                        builder: ((context, constraints) {
                          ////
                          ///
                          top = constraints.biggest.height;
                          print(constraints.maxHeight);
                          Future.delayed(Duration.zero, () {
                            setState(() {
                              top2 = top;
                              top3 = top2;
                            });
                            // print('new name =========== ${newName}');

                            // print(top2);
                          });
                          return FlexibleSpaceBar(
                            background: Container(
                              height: 400,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                // gradient: LinearGradient(
                                //   colors: [
                                //     Colors.yellow.withOpacity(.1),
                                //     Colors.blueGrey.withOpacity(1),
                                //   ],
                                //   begin: Alignment.topCenter,
                                //   end: Alignment.bottomCenter,
                                // ),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          Transform.translate(
                            offset: Offset(0, -20),
                            child: Container(
                              color: Theme.of(context).scaffoldBackgroundColor,
                              alignment: Alignment.topLeft,
                              margin:
                                  EdgeInsets.only(top: 20, left: 10, right: 10),
                              width: double.infinity,
                              // height: 780,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '#${widget.image_code}',
                                            style: GoogleFonts.oswald(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.blue,
                                            ),
                                          ),
                                          Text(
                                            '${widget.label}',
                                            style: GoogleFonts.oswald(
                                              fontSize: 25,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Text(
                                                'Created by ',
                                                style: GoogleFonts.oswald(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white54,
                                                ),
                                              ),
                                              Container(
                                                padding:
                                                    EdgeInsets.only(left: 10),
                                                child: Text(
                                                  '${widget.image_code.toString().substring(0, 2)}-${widget.label.toString().split(' ')[0]}',
                                                  style: GoogleFonts.oswald(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 200),
                                    width: 300,
                                    height: isClickmore &&
                                            widget.description
                                                    .toString()
                                                    .length >=
                                                35
                                        ? widget.description
                                                .toString()
                                                .length
                                                .toDouble() +
                                            widget.description
                                                    .toString()
                                                    .length
                                                    .toDouble() /
                                                10
                                        : widget.description
                                                    .toString()
                                                    .length >=
                                                35
                                            ? widget.description
                                                    .toString()
                                                    .length
                                                    .toDouble() -
                                                widget.description
                                                        .toString()
                                                        .length
                                                        .toDouble() /
                                                    3
                                            : 30,
                                    child: Text(
                                      isClickmore ||
                                              widget.description
                                                      .toString()
                                                      .length <=
                                                  35
                                          ? '${widget.description.toString().substring(0, widget.description.toString().length)}'
                                          : '${widget.description.toString().substring(0, (widget.description.toString().length.toInt() - 30))} ....',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  if (widget.description.toString().length >=
                                      35)
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isClickmore = !isClickmore;
                                        });
                                      },
                                      child: Text(
                                        isClickmore ? '-less' : '+more',
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white54,
                                        ),
                                      ),
                                    ),
                                  //////////////////
                                  ////
                                  ////
                                  ////
                                  ////
                                  ////
                                  ///
                                  /////
                                  ///
                                  Center(
                                    child: Column(
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            setState(() {
                                              if (s1[widget.index]['id'] !=
                                                  widget.index.toString()) {
                                                FirebaseFirestore.instance
                                                    .collection('newAccount')
                                                    .doc('${widget.idKey}')
                                                    .collection('favorite')
                                                    .doc('${widget.index}')
                                                    .set({
                                                  'id': '${widget.index}'
                                                });
                                              } else {
                                                FirebaseFirestore.instance
                                                    .collection('newAccount')
                                                    .doc('${widget.idKey}')
                                                    .collection('favorite')
                                                    .doc('${widget.index}')
                                                    .set({'id': ''});
                                              }
                                            });
                                          },
                                          icon: Icon(
                                            Icons.favorite,
                                            size: 40,
                                            color: s1[widget.index]['id'] ==
                                                    widget.index.toString()
                                                ? Colors.red
                                                : Colors.white,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        AnimatedOpacity(
                                          opacity: (s1[widget.index]
                                                      as dynamic)['id'] ==
                                                  widget.index.toString()
                                              ? 0
                                              : 1,
                                          duration: Duration(milliseconds: 300),
                                          child: Text(
                                            'Add to favorite',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                        Transform.translate(
                                          offset: Offset(0, -15),
                                          child: AnimatedOpacity(
                                            opacity: (s1[widget.index]
                                                        as dynamic)['id'] ==
                                                    widget.index.toString()
                                                ? 1
                                                : 0,
                                            duration:
                                                Duration(milliseconds: 300),
                                            child: Text(
                                              'Added',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // StreamBuilder<QuerySnapshot>(
                                  //   stream: FirebaseFirestore.instance
                                  //       .collection(
                                  //           '/newAccount/${widget.idKey}/favorite/')
                                  //       .snapshots(),
                                  //   builder: (context, snapshot) {
                                  //     if (!snapshot.hasData) {
                                  //       return Center(
                                  //         child: CircularProgressIndicator(),
                                  //       );
                                  //     }

                                  //     List<DocumentSnapshot> s1 =
                                  //         snapshot.data!.docs;

                                  //   },
                                  // ),
                                  /////////////////
                                  ////
                                  ////
                                  //////////
                                  ////
                                  ////
                                  Container(
                                    alignment: Alignment.center,
                                    width: double.infinity,
                                    height: 125,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.blueGrey,
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Current Price',
                                          style: GoogleFonts.oswald(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '  ${widget.current_price}',
                                              style: GoogleFonts.oswald(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                            Icon(
                                              FontAwesomeIcons.ethereum,
                                              color: Colors.black,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Card(
                                    color: Colors.blueGrey,
                                    child: ExpansionTile(
                                      iconColor: Colors.white,
                                      title: Text(
                                        'Details',
                                        style: GoogleFonts.oswald(
                                          fontSize: 25,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 10, left: 20, bottom: 20),
                                          child: Row(
                                            children: [
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Token ID',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Token Standards',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Blockchain',
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                width: 120,
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    '#705124',
                                                    style: TextStyle(
                                                      color: Colors.white54,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Erc-1155',
                                                    style: TextStyle(
                                                      color: Colors.white54,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Ethereum',
                                                    style: TextStyle(
                                                      color: Colors.white54,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      'similar items',
                                      style: GoogleFonts.oswald(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 300,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      physics: BouncingScrollPhysics(),
                                      children: [
                                        imageStyle1(
                                          index: dataInf[3]['id'],
                                          idKey: widget.idKey,
                                          description: dataInf[3]
                                              ['description'],
                                          title: dataInf[3]['title'],
                                          code: dataInf[3]['code'],
                                          price: dataInf[3]['price'],
                                          urlImage: dataInf[3]['imageUrl'],
                                        ),
                                        imageStyle1(
                                          index: dataInf[4]['id'],
                                          idKey: widget.idKey,
                                          title: dataInf[4]['title'],
                                          description: dataInf[4]
                                              ['description'],
                                          code: dataInf[4]['code'],
                                          price: dataInf[4]['price'],
                                          urlImage: dataInf[4]['imageUrl'],
                                        ),
                                        imageStyle1(
                                          index: dataInf[5]['id'],
                                          idKey: widget.idKey,
                                          description: dataInf[5]
                                              ['description'],
                                          title: dataInf[5]['title'],
                                          code: dataInf[5]['code'],
                                          price: dataInf[5]['price'],
                                          urlImage: dataInf[5]['imageUrl'],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Transform.translate(
                  offset: Offset(0, top3 - 540),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    height: top2 - 56,
                    width: top2 + 60,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      height: top2 - 55,
                      width: top2 - 55,
                      // fit: BoxFit.cover,
                      child: Image.asset(
                        widget.image_url_items,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
