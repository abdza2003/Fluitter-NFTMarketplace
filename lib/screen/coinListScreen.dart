// import 'dart:async';

import 'package:flutter/material.dart';

import 'package:sampleproject/api/FetchData.dart';
import 'package:sampleproject/api/listCoin.dart';
import 'package:sampleproject/extra/coinListInf.dart';
import 'package:sampleproject/extra/drawer.dart';

class coinListScreen extends StatefulWidget {
  var idKey;
  coinListScreen({required this.idKey});
  @override
  State<coinListScreen> createState() => _coinListScreen();
}

class _coinListScreen extends State<coinListScreen> {
  @override
  void initState() {
    getInfByApi();
    Future.delayed(Duration.zero, (() => getInfByApi()));
    super.initState();
  }

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
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 5,
        centerTitle: true,
        title: Text(
          'coin List',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(top: 10),
        child: FutureBuilder(
            future: getInfByApi(),
            builder: (context, snapshot) {
              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    getInfByApi();
                  });
                },
                child: ListView(
                  children: [
                    getInfByIndex(1),
                    getInfByIndex(2),
                    getInfByIndex(3),
                    getInfByIndex(5),
                    getInfByIndex(7),
                    getInfByIndex(8),
                    getInfByIndex(10),
                    getInfByIndex(12),
                    getInfByIndex(16),
                    getInfByIndex(25),
                  ],
                ),
              );
            }),
      ),
    );
  }

  getInfByIndex(int index) {
    return coinListInf(
      index: index,
      name: ListCoinInf.isEmpty ? '' : ListCoinInf[index].name,
      symbol: ListCoinInf.isEmpty ? '' : ListCoinInf[index].symbol,
      price: ListCoinInf.isEmpty ? 0.0 : ListCoinInf[index].price,
      percent_change_1h:
          ListCoinInf.isEmpty ? 0.0 : ListCoinInf[index].percent_change_1h,
      percent_change_24h:
          ListCoinInf.isEmpty ? 0.0 : ListCoinInf[index].percent_change_24h,
      percent_change_7d:
          ListCoinInf.isEmpty ? 0.0 : ListCoinInf[index].percent_change_7d,
      percent_change_30d:
          ListCoinInf.isEmpty ? 0.0 : ListCoinInf[index].percent_change_30d,
      percent_change_60d:
          ListCoinInf.isEmpty ? 0.0 : ListCoinInf[index].percent_change_60d,
      percent_change_90d:
          ListCoinInf.isEmpty ? 0.0 : ListCoinInf[index].percent_change_90d,
    );
  }
}
