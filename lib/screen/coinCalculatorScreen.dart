import 'dart:async';

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sampleproject/api/FetchData.dart';
import 'package:sampleproject/api/listCoin.dart';

class coinCalculatorScreen extends StatefulWidget {
  int index;
  String name;
  String symbol;
  // /////
  double percent_change_1h;
  double percent_change_24h;
  double percent_change_7d;
  double percent_change_30d;
  double percent_change_60d;
  double percent_change_90d;

  double price;
  coinCalculatorScreen({
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
  State<coinCalculatorScreen> createState() => _coinCalculatorScreen();
}

enum Calculator {
  coin,
  dollar,
}

class _coinCalculatorScreen extends State<coinCalculatorScreen> {
  var calculatorMode = Calculator.coin;
  var eth = 0.0;
  var dollar = 0.0;
  var ethToken = '0.0';
  @override
  void initState() {
    getInfByApi();
    Future.delayed(Duration.zero, (() => getInfByApi()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          '${widget.name}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
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
                      Image.asset(
                        'coinImages/${widget.symbol.toLowerCase()}.png',
                        // color: Colors.white,
                        width: 120,
                        height: 120,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              !ListCoinInf.isEmpty ? widget.name : '\$\$\$',
                              style: GoogleFonts.oswald(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Container(
                            // alignment: Alignment.center,
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              !ListCoinInf.isEmpty
                                  ? ' - ${widget.symbol}  '
                                  : '',
                              style: GoogleFonts.oswald(
                                fontSize: 20,
                                // fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            !ListCoinInf.isEmpty
                                ? '${widget.price.toStringAsFixed(2)}\$'
                                : '0.0',
                            style: GoogleFonts.arvo(
                              fontSize: 30,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            !ListCoinInf.isEmpty
                                ? '${widget.percent_change_24h.toStringAsFixed(2)} %'
                                : '0.0%',
                            style: GoogleFonts.arvo(
                              fontSize: 20,
                              color: !ListCoinInf.isEmpty
                                  ? (widget.percent_change_24h > 0
                                      ? Colors.green
                                      : Colors.red)
                                  : Colors.green,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      !ListCoinInf.isEmpty
                          ? Sparkline(
                              lineWidth: 2.5,
                              data: [
                                widget.percent_change_1h,
                                widget.percent_change_24h,
                                widget.percent_change_7d,
                                widget.percent_change_30d,
                                widget.percent_change_60d,
                                widget.percent_change_90d,

                                // 5,
                                // 4, 6, 7, 12,
                                // 9,
                                // 5,
                                // 7,
                                // 3,
                                // 6, 9,
                                // 4,
                                // 6,
                              ],
                              lineColor: Colors.white,
                              fillMode: FillMode.below,
                              sharpCorners: true,
                              useCubicSmoothing: true,
                              fallbackHeight: 150,

                              // fillColor: Colors.orange,
                              // thresholdSize: 40,
                              // pointColor: Colors.teal,
                              // pointsMode: PointsMode.all,
                              // pointSize: 15,
                              fillGradient: LinearGradient(
                                colors: [
                                  Colors.orange.withOpacity(1),
                                  Colors.deepOrange.withOpacity(.3),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
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
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Transform.translate(
                              offset: Offset(0, 0),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  left: 50,
                                  right: 50,
                                ),
                                child: TextField(
                                  style: GoogleFonts.arvo(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),

                                    icon: calculatorMode == Calculator.coin
                                        ? Image.asset(
                                            'coinImages/${widget.symbol.toLowerCase()}.png',
                                            width: 50,
                                            height: 50,
                                          )
                                        : Text(
                                            '\$',
                                            style: GoogleFonts.arvo(
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                    // filled: true,
                                    hintText: '0.00',
                                    hintStyle: GoogleFonts.arvo(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black45,
                                    ),
                                    // border: OutlineInputBorder(),
                                  ),
                                  keyboardType: TextInputType.number,
                                  cursorColor: Colors.white,
                                  textAlign: TextAlign.center,
                                  onSubmitted: (value) {
                                    setState(() {
                                      ethToken = value as String;
                                      calculatorMode == Calculator.coin
                                          ? dollar = !ListCoinInf.isEmpty
                                              ? widget.price *
                                                  double.parse(ethToken)
                                              : 0.0
                                          : dollar = !ListCoinInf.isEmpty
                                              ? double.parse(ethToken) /
                                                  widget.price
                                              : 0.0;
                                    });

                                    print('============ $ethToken');
                                  },
                                ),
                              ),
                            ),
                          ),
                          Transform.translate(
                            offset: Offset(-40, 0),
                            child: IconButton(
                              icon: Icon(
                                Icons.change_circle,
                                color: Colors.white,
                                size: 35,
                              ),
                              onPressed: () {
                                setState(() {
                                  dollar = 0.0;
                                  calculatorMode == Calculator.coin
                                      ? calculatorMode = Calculator.dollar
                                      : calculatorMode = Calculator.coin;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          snapshot.connectionState != ConnectionState.waiting
                              ? Transform.translate(
                                  offset: Offset(
                                      calculatorMode == Calculator.coin
                                          ? 10
                                          : 25,
                                      0),
                                  child: Text(
                                    '${dollar.toStringAsFixed(2)}',
                                    style: GoogleFonts.arvo(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              : Transform.translate(
                                  offset: Offset(
                                      calculatorMode == Calculator.coin
                                          ? 10
                                          : 25,
                                      0),
                                  child: Text(
                                    '0.00',
                                    style: GoogleFonts.arvo(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                          SizedBox(
                            width: 10,
                          ),
                          calculatorMode != Calculator.coin
                              ? Transform.translate(
                                  offset: Offset(30, 0),
                                  child: Image.asset(
                                    'coinImages/${widget.symbol.toLowerCase()}.png',
                                    width: 50,
                                    height: 50,
                                  ),
                                )
                              : Transform.translate(
                                  offset: Offset(10, 0),
                                  child: Text(
                                    '\$',
                                    style: GoogleFonts.arvo(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
