// import 'dart:async';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sampleproject/api/FetchData.dart';
import 'package:sampleproject/api/listCoin.dart';

class _ extends StatefulWidget {
  @override
  State<_> createState() => __();
}

class __ extends State<_> {
  @override
  void initState() {
    getInfByApi();
    Future.delayed(Duration.zero, (() => getInfByApi()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20),
        child: FutureBuilder(
            future: getInfByApi(),
            builder: (context, snapshot) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: RefreshIndicator(
                  onRefresh: () async {
                    setState(() {
                      getInfByApi();
                    });
                  },
                  child: ListView(
                    children: [
                      ///
                      ////
                      ////
                      ////
                      ///
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
