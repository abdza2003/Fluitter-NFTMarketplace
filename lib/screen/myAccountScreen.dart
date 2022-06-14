import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sampleproject/Firebase/Auth.dart';
import 'package:sampleproject/screen/addNewItemWitFirebaseScreen.dart';
import 'package:sampleproject/extra/drawer.dart';
import 'package:sampleproject/screen/DetailsScreen.dart';

class myAccountScreen extends StatefulWidget {
  var idKey;
  myAccountScreen({required this.idKey});
  @override
  State<myAccountScreen> createState() => _myAccountScreenState();
}

class _myAccountScreenState extends State<myAccountScreen> {
  double top = 0.0;
  String yourBio = '';
  double top2 = 200;
  String name =
      'Opensea opensea opensea opensea opensea opensea opensea opensea opensea opensea';
  bool isLoading = false;

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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: (() {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: ((context) => addNewItemWitFirebaseScreen(
                        Id: widget.idKey,
                      ))));
        }),
        label: Text('add new item'),
        icon: Icon(Icons.add),
      ),
      body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('/newAccount/${widget.idKey}/user/')
            .snapshots(),
        builder: ((context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<DocumentSnapshot> s1 = snapshot.data!.docs;

          return !s1.isEmpty
              ? Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 200),
                      opacity: isLoading ? .4 : 1,
                      child: CustomScrollView(
                        physics: BouncingScrollPhysics(),
                        slivers: [
                          SliverAppBar(
                              actions: [
                                PopupMenuButton(
                                    onSelected: (item) =>
                                        onSelected(context, item as int),
                                    itemBuilder: (context) => [
                                          PopupMenuItem(
                                            value: 0,
                                            child: Text('add profile photo'),
                                          ),
                                          PopupMenuItem(
                                            value: 1,
                                            child: Text('add background'),
                                          ),
                                        ]),
                              ],
                              title: AnimatedOpacity(
                                duration: Duration(milliseconds: 200),
                                opacity: top2 < 140 ? 1 : 0,
                                child: Text(
                                  '${(s1[0] as dynamic)['userName']}',
                                  style: Theme.of(context).textTheme.headline2,
                                ),
                              ),
                              backgroundColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              pinned: true,
                              expandedHeight: 200,
                              centerTitle: true,
                              flexibleSpace: LayoutBuilder(
                                builder: (context, constraints) {
                                  top = constraints.biggest.height;
                                  Future.delayed(Duration.zero, () {
                                    setState(() {
                                      top2 = top;
                                    });
                                  });

                                  return FlexibleSpaceBar(
                                    background: Container(
                                      decoration: BoxDecoration(
                                        border: Border(
                                          bottom: BorderSide(
                                              color: Colors.white, width: 2),
                                        ),
                                      ),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            '${(s1[0] as dynamic)['background']}',
                                        placeholder: (context, url) => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            AnimatedOpacity(
                                              duration: Duration.zero,
                                              opacity: .5,
                                              child: Image.asset(
                                                'images/v3.png',
                                              ),
                                            ),
                                            CircularProgressIndicator(
                                              color: Colors.blue,
                                            ),
                                          ],
                                        ),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                    ),
                                  );
                                },
                              )),
                          SliverList(
                            delegate: SliverChildListDelegate(
                              [
                                Transform.translate(
                                  offset: Offset(0, 60),
                                  child: Container(
                                    height: 790,
                                    alignment: Alignment.topLeft,
                                    padding:
                                        EdgeInsets.only(left: 10, right: 10),
                                    width: double.infinity,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    child: ListView(
                                      physics: BouncingScrollPhysics(),
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${(s1[0] as dynamic)['userName']}',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2,
                                            ),
                                            Text(
                                              // x[0].Id.toString().substring(0, 3).toLowerCase()
                                              '${widget.idKey.toString().substring(0, 3).toLowerCase()}-${(s1[0] as dynamic)['userName'].toString().split(' ')[0]}',
                                              style: GoogleFonts.oswald(
                                                //// خط الكتابة على الصور
                                                fontSize: 15,
                                                color: Colors.white54,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            (s1[0] as dynamic)['bio'] != ''
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          AnimatedContainer(
                                                            duration: Duration(
                                                                milliseconds:
                                                                    200),
                                                            width: 300,
                                                            height: isClick &&
                                                                    s1[0]['bio']
                                                                            .toString()
                                                                            .length >=
                                                                        35
                                                                ? s1[0]['bio']
                                                                        .toString()
                                                                        .length
                                                                        .toDouble() +
                                                                    s1[0]['bio']
                                                                            .toString()
                                                                            .length
                                                                            .toDouble() /
                                                                        10
                                                                : s1[0]['bio']
                                                                            .toString()
                                                                            .length >=
                                                                        35
                                                                    ? s1[0]['bio']
                                                                            .toString()
                                                                            .length
                                                                            .toDouble() -
                                                                        s1[0]['bio'].toString().length.toDouble() /
                                                                            3
                                                                    : 40,
                                                            child: Text(
                                                              isClick ||
                                                                      s1[0]['bio']
                                                                              .toString()
                                                                              .length <=
                                                                          35
                                                                  ? '${s1[0]['bio'].toString().substring(0, s1[0]['bio'].toString().length)}'
                                                                  : '${s1[0]['bio'].toString().substring(0, (s1[0]['bio'].toString().length.toInt() - 30))} ....',
                                                              style: TextStyle(
                                                                fontSize: 18,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 40,
                                                          ),
                                                          GestureDetector(
                                                            onTap: (() async {
                                                              await showDialogWithBio(
                                                                  widget.idKey);
                                                            }),
                                                            child: Icon(
                                                              FontAwesomeIcons
                                                                  .pencilAlt,
                                                              color:
                                                                  Colors.white,
                                                              size: 15,
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      if (s1[0]['bio']
                                                              .toString()
                                                              .length >=
                                                          35)
                                                        GestureDetector(
                                                          onTap: () {
                                                            setState(() {
                                                              isClick =
                                                                  !isClick;
                                                            });
                                                          },
                                                          child: Text(
                                                            isClick
                                                                ? '-less'
                                                                : '+more',
                                                            style: TextStyle(
                                                              fontSize: 15,
                                                              color: Colors
                                                                  .white54,
                                                            ),
                                                          ),
                                                        ),
                                                    ],
                                                  )
                                                : Row(
                                                    children: [
                                                      Icon(
                                                        FontAwesomeIcons
                                                            .pencilAlt,
                                                        color: Colors.white,
                                                        size: 15,
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      GestureDetector(
                                                        onTap: (() async {
                                                          await showDialogWithBio(
                                                              widget.idKey);
                                                        }),
                                                        child: Text(
                                                          'add bio',
                                                          style: TextStyle(
                                                            fontSize: 15,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Column(
                                                  children: [
                                                    Text(
                                                      '7.2',
                                                      style: TextStyle(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      'items',
                                                      style: TextStyle(
                                                        color: Colors.white54,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                Column(
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          FontAwesomeIcons
                                                              .ethereum,
                                                          color: Colors.black,
                                                        ),
                                                        Text(
                                                          '8',
                                                          style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(
                                                      '     traded',
                                                      style: TextStyle(
                                                        color: Colors.white54,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Text(
                                              'Items',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headline2,
                                            ),
                                            Transform.translate(
                                              offset: Offset(0, -4),
                                              child: SizedBox(
                                                width: 150,
                                                child: Divider(
                                                  color: Colors.blue,
                                                  thickness: 2,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 500,
                                              width: 580,
                                              child:
                                                  StreamBuilder<QuerySnapshot>(
                                                stream: FirebaseFirestore
                                                    .instance
                                                    .collection('newAccount')
                                                    .doc('${widget.idKey}')
                                                    .collection('items')
                                                    .snapshots(),
                                                builder: ((context, snapshot) {
                                                  if (!snapshot.hasData) {
                                                    return Center(
                                                        child:
                                                            Transform.translate(
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
                                                  List<DocumentSnapshot> s2 =
                                                      snapshot.data!.docs;

                                                  return GridView.builder(
                                                    physics:
                                                        BouncingScrollPhysics(),
                                                    itemCount: s2.length,
                                                    gridDelegate:
                                                        const SliverGridDelegateWithMaxCrossAxisExtent(
                                                            maxCrossAxisExtent:
                                                                250,
                                                            childAspectRatio:
                                                                1 / 1.7,
                                                            crossAxisSpacing: 5,
                                                            mainAxisSpacing: 5),
                                                    itemBuilder:
                                                        (BuildContext context,
                                                            index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            PageTransition(
                                                              child:
                                                                  DetailsScreen(
                                                                idKey: widget
                                                                    .idKey,
                                                                current_price: s2[
                                                                        index][
                                                                    'current_price'],
                                                                description: s2[
                                                                        index][
                                                                    'description'],
                                                                image_code: s2[
                                                                        index][
                                                                    'image_code'],
                                                                image_url_items:
                                                                    s2[index][
                                                                        'image_url_items'],
                                                                label: s2[index]
                                                                    ['label'],
                                                                Id: widget
                                                                    .idKey,
                                                              ),
                                                              type: PageTransitionType
                                                                  .rightToLeft,
                                                              duration: Duration(
                                                                  milliseconds:
                                                                      300),
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          width: 210,
                                                          margin:
                                                              EdgeInsets.all(
                                                                  10),
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            color:
                                                                Colors.blueGrey,
                                                          ),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Container(
                                                                height: 200,
                                                                width: 200,
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(
                                                                            10),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                ),
                                                                child:
                                                                    CachedNetworkImage(
                                                                  height:
                                                                      top2 - 55,
                                                                  width:
                                                                      top2 - 55,
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  imageUrl: (s2[
                                                                              index]
                                                                          as dynamic)[
                                                                      'image_url_items'],
                                                                  placeholder:
                                                                      (context,
                                                                              url) =>
                                                                          Stack(
                                                                    alignment:
                                                                        Alignment
                                                                            .center,
                                                                    children: [
                                                                      AnimatedOpacity(
                                                                          duration: Duration
                                                                              .zero,
                                                                          opacity:
                                                                              .5,
                                                                          child:
                                                                              Image.asset('images/v3.png')),
                                                                      CircularProgressIndicator(
                                                                        color: Colors
                                                                            .blue,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                10),
                                                                    alignment:
                                                                        Alignment
                                                                            .topLeft,
                                                                    child: Text(
                                                                      '${(s2[index] as dynamic)['label']}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 20,
                                                                  ),
                                                                ],
                                                              ),
                                                              SizedBox(
                                                                height: 4,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .spaceBetween,
                                                                children: [
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .only(
                                                                            left:
                                                                                15),
                                                                    child: Row(
                                                                      children: [
                                                                        Icon(
                                                                          FontAwesomeIcons
                                                                              .ethereum,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              5,
                                                                        ),
                                                                        Text(
                                                                          '${(s2[index] as dynamic)['current_price']}',
                                                                          style:
                                                                              TextStyle(
                                                                            fontSize:
                                                                                15,
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight:
                                                                                FontWeight.bold,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets.only(
                                                                        right:
                                                                            25),
                                                                    child: Text(
                                                                      '#${(s2[index] as dynamic)['image_code']}',
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            15,
                                                                        color: Colors
                                                                            .white,
                                                                        fontWeight:
                                                                            FontWeight.bold,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  // Container(
                                                                  //   margin: EdgeInsets.only(right: 15),
                                                                  //   child: LikeButton(
                                                                  //     size: 20,
                                                                  //     circleSize: 40,
                                                                  //     onTap: (isLike) async {
                                                                  //       print('object');

                                                                  //       ///
                                                                  //       ///
                                                                  //       ////
                                                                  //       ////نكتب هنا الاكواد التي نريدها
                                                                  //       return !isLike;
                                                                  //     },
                                                                  //     likeBuilder: (isLike) {
                                                                  //       return Icon(
                                                                  //         Icons.favorite,
                                                                  //         size: 20,
                                                                  //         color: isLike ? Colors.red : Colors.white,
                                                                  //       );
                                                                  //     },
                                                                  //   ),
                                                                  // ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                  );
                                                }),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 300),
                      opacity: top2 < 110 ? 0 : 1,
                      child: Transform.translate(
                        offset: Offset(0, top2 - 90),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 4),
                            borderRadius: BorderRadius.circular(110),
                          ),
                          child: AnimatedOpacity(
                            duration: Duration(milliseconds: 200),
                            opacity: isLoading ? .4 : 1,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(110)),
                                  child: CachedNetworkImage(
                                    height: top2 - 55,
                                    width: top2 - 55,
                                    fit: BoxFit.cover,
                                    imageUrl: (s1[0] as dynamic)['image_url'],
                                    placeholder: (context, url) => Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        AnimatedOpacity(
                                            duration: Duration.zero,
                                            opacity: .5,
                                            child:
                                                Image.asset('images/v3.png')),
                                        CircularProgressIndicator(
                                          color: Colors.blue,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (isLoading == true)
                      Transform.translate(
                        offset: Offset(0, 250),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            AnimatedOpacity(
                              duration: Duration.zero,
                              opacity: 1,
                              child: Image.asset(
                                'images/v3.png',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                              ),
                            ),
                            CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          ],
                        ),
                      ),
                  ],
                )
              : Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      AnimatedOpacity(
                          duration: Duration.zero,
                          opacity: .5,
                          child: Image.asset('images/v3.png')),
                      CircularProgressIndicator(
                        color: Colors.blue,
                      ),
                    ],
                  ),
                );
        }),
      )),
    );
  }

  Future showDialogWithBio(String usetId) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.blueGrey,
        title: Text(
          'add your bio',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        content: TextField(
          style: TextStyle(
            color: Colors.white,
          ),
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'Enter your bio',
            label: Text('Bio'),
            border: OutlineInputBorder(),
          ),
          maxLength: 100,
          onChanged: (value) {
            setState(() {
              yourBio = value;
            });
          },
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await FirebaseFirestore.instance
                  .collection('newAccount')
                  .doc(usetId)
                  .collection('user')
                  .doc('personalInf')
                  .update({
                'bio': yourBio,
              });

              Navigator.of(context).pop();
            },
            child: Text(
              'Submit',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Close'),
          ),
          SizedBox(
            width: 10,
          )
        ],
      ),
    );
  }

  void onSelected(BuildContext context, int item) async {
    Random x = new Random();
    switch (item) {
      case 0:
        final ImagePicker _picker = ImagePicker();
        File? pickedImage;

        final image = await _picker.pickImage(
            source: ImageSource.gallery, imageQuality: 60);
        if (image == null) {
          return;
        }

        setState(() {
          isLoading = true;

          pickedImage = File(image.path);
        });

        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child('${widget.idKey}${x.nextInt(1000)}.jpg');

        ///
        ////
        var urlImage;
        if (pickedImage != null) {
          await ref.putFile(pickedImage!);
          urlImage = await ref.getDownloadURL();
          await ref.putFile(pickedImage!);
        } else {
          urlImage =
              'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png';
        }
        await FirebaseFirestore.instance
            .collection('newAccount')
            .doc('${widget.idKey}')
            .collection('user')
            .doc('personalInf')
            .update({
          'image_url': urlImage,
        });
        setState(() {
          isLoading = false;
        });
        break;
      case 1:
        final ImagePicker _picker = ImagePicker();
        File? pickedImage;

        final image = await _picker.pickImage(
            source: ImageSource.gallery, imageQuality: 60);
        if (image == null) {
          return;
        }

        setState(() {
          isLoading = true;

          pickedImage = File(image.path);
        });
        final ref = FirebaseStorage.instance
            .ref()
            .child('user_image')
            .child('${widget.idKey}${x.nextInt(1000)}.jpg');

        ///
        ////
        var urlImage;
        if (pickedImage != null) {
          await ref.putFile(pickedImage!);
          urlImage = await ref.getDownloadURL();
          await ref.putFile(pickedImage!);
        } else {
          urlImage =
              'https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png';
        }
        await FirebaseFirestore.instance
            .collection('newAccount')
            .doc('${widget.idKey}')
            .collection('user')
            .doc('personalInf')
            .update({
          'background': urlImage,
        });
        setState(() {
          isLoading = false;
        });
        break;
    }
  }
}
