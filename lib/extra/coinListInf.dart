import 'dart:async';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:sampleproject/screen/coinCalculatorScreen.dart';

class coinListInf extends StatefulWidget {
  int index;
  String name;
  String symbol;
  /////
  double percent_change_1h;
  double percent_change_24h;
  double percent_change_7d;
  double percent_change_30d;
  double percent_change_60d;
  double percent_change_90d;

  double price;
  coinListInf({
    required this.index,
    required this.name,
    required this.symbol,
    required this.price,
    required this.percent_change_1h,
    required this.percent_change_24h,
    required this.percent_change_7d,
    required this.percent_change_30d,
    required this.percent_change_60d,
    required this.percent_change_90d,
  });

  @override
  State<coinListInf> createState() => _coinListInfState();
}

class _coinListInfState extends State<coinListInf> {
  @override
  Widget build(BuildContext context) {
    print('coinImages/${widget.symbol.toLowerCase()}.png');
    return Padding(
      padding: EdgeInsets.all(5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                child: coinCalculatorScreen(
                  index: widget.index,
                  name: widget.name,
                  symbol: widget.symbol,
                  price: widget.price,
                  percent_change_1h: widget.percent_change_1h,
                  percent_change_24h: widget.percent_change_24h,
                  percent_change_7d: widget.percent_change_7d,
                  percent_change_30d: widget.percent_change_30d,
                  percent_change_60d: widget.percent_change_60d,
                  percent_change_90d: widget.percent_change_90d,
                ),
                type: PageTransitionType.rightToLeft,
                duration: Duration(milliseconds: 300),
              ),
            );
          },
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: widget.symbol != ''
                ? Row(
                    children: [
                      Transform.translate(
                        offset: Offset(-10, 0),
                        child: Container(
                          padding: EdgeInsets.only(top: 15),
                          width: 150,
                          height: 200,
                          child: Column(
                            children: [
                              Image.asset(
                                'coinImages/${widget.symbol.toLowerCase()}.png',
                                width: 60,
                                height: 60,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                widget.symbol,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                '${widget.price.toStringAsFixed(2)}',
                                style: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Transform.translate(
                        offset: Offset(-20, 0),
                        child: Container(
                          // padding: EdgeInsets.all(10),
                          // color: Colors.red,
                          width: 100,
                          height: 80,
                          child: Sparkline(
                            lineWidth: 2.5,
                            data: [
                              widget.percent_change_1h,
                              widget.percent_change_24h,
                              widget.percent_change_7d,
                              widget.percent_change_30d,
                              widget.percent_change_60d,
                              widget.percent_change_90d,
                            ],
                            lineColor: Colors.white,
                            useCubicSmoothing: true,
                          ),
                        ),
                      ),
                      Container(
                        width: 100,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: widget.percent_change_24h > 0
                              ? Colors.green
                              : Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          '${widget.percent_change_24h.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  )
                : Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                        child: AnimatedOpacity(
                          opacity: 0.2,
                          duration: Duration(seconds: 1),
                          child: Image.asset(
                            'images/v3.png',
                            height: 100,
                            width: 100,
                          ),
                        ),
                      ),
                      CircularProgressIndicator(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
