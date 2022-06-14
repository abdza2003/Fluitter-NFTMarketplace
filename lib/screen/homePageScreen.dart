import 'package:flutter/material.dart';
import 'package:sampleproject/Database/dataInf.dart';
import 'package:sampleproject/extra/accountStyle.dart';
import 'package:sampleproject/extra/drawer.dart';
import 'package:sampleproject/extra/imageStyle1.dart';
import 'package:sampleproject/extra/imageStyle2.dart';
import 'package:sampleproject/extra/sliderImage.dart';

class homePageScreen extends StatefulWidget {
  var idKey;
  homePageScreen({required this.idKey});
  @override
  State<homePageScreen> createState() => _homePageScreenState();
}

class _homePageScreenState extends State<homePageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        title: Text('Home Page'),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: drawer(
          idKey: widget.idKey,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //////
              /////
              ////
              sliderImage(
                idKey: widget.idKey,
              ),

              ///
              ////
              ////
              Container(
                padding: EdgeInsets.only(top: 5, left: 15),
                alignment: Alignment.topLeft,
                child: Text(
                  'NFT collections',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              ////
              /////
              SizedBox(
                height: 10,
              ),
              ////
              ////
              ////

              ////
              ////
              ////
              Container(
                padding: EdgeInsets.only(top: 5, left: 15),
                alignment: Alignment.topLeft,
                child: Text(
                  'Hot items',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              ///////
              ////
              ////
              SizedBox(
                height: 300,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  children: [
                    imageStyle1(
                      idKey: widget.idKey,
                      title: dataInf[3]['title'],
                      index: dataInf[3]['id'],
                      code: dataInf[3]['code'],
                      price: dataInf[3]['price'],
                      description: dataInf[3]['description'],
                      urlImage: dataInf[3]['imageUrl'],
                    ),
                    imageStyle1(
                      idKey: widget.idKey,
                      index: dataInf[4]['id'],
                      title: dataInf[4]['title'],
                      code: dataInf[4]['code'],
                      price: dataInf[4]['price'],
                      description: dataInf[4]['description'],
                      urlImage: dataInf[4]['imageUrl'],
                    ),
                    imageStyle1(
                      idKey: widget.idKey,
                      title: dataInf[5]['title'],
                      index: dataInf[5]['id'],
                      code: dataInf[5]['code'],
                      price: dataInf[5]['price'],
                      description: dataInf[5]['description'],
                      urlImage: dataInf[5]['imageUrl'],
                    ),
                  ],
                ),
              ),
              ////
              ////
              ////
              Container(
                padding: EdgeInsets.only(top: 5, left: 15),
                alignment: Alignment.topLeft,
                child: Text(
                  'Featured Paintigs',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              ////
              ////
              ////
              SizedBox(
                height: 320,
                child: imageStyle2(
                  idKey: widget.idKey,
                  index: dataInf[6]['id'],
                  title: dataInf[6]['title'],
                  code: dataInf[6]['code'],
                  description: dataInf[6]['description'],
                  price: dataInf[6]['price'],
                  urlImage: dataInf[6]['imageUrl'],
                ),
              ),
              SizedBox(
                height: 320,
                child: imageStyle2(
                  idKey: widget.idKey,
                  index: dataInf[7]['id'],
                  title: dataInf[7]['title'],
                  code: dataInf[7]['code'],
                  description: dataInf[7]['description'],
                  price: dataInf[7]['price'],
                  urlImage: dataInf[7]['imageUrl'],
                ),
              ),
              ////
              ////
              ////
            ],
          ),
        ),
      ),
    );
  }
}
