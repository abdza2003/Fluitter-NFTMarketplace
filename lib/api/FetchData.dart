import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sampleproject/api/listCoin.dart';

Future<dynamic> getInfByApi() async {
  ListCoinInf = [];
  const String apiKey = apiKeyFromCoinMarketCap;
  http.Response res = await http.get(
    Uri.parse(
        'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest'),
    headers: {'X-CMC_PRO_API_KEY': apiKey},
  );

  var data = json.decode(res.body);
  for (var item in data['data']) {
    ListCoinInf.add(ListCoin.fromjson(item));
  }

  print(ListCoinInf[1].price);
  print(ListCoinInf[1].symbol);
  // print(ListCoinInf[0].percent_change_1h);
  // print(ListCoinInf[0].percent_change_24h);
  // print(ListCoinInf[0].percent_change_7d);
  // print(ListCoinInf[0].percent_change_30d);
  // print(ListCoinInf[0].percent_change_60d);
  // print(ListCoinInf[0].percent_change_90d);
  return ListCoinInf;
}
