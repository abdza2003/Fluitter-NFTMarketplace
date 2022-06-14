class ListCoin {
  String name = '';
  String symbol = '';
  /////
  double percent_change_1h = 0.0;
  double percent_change_24h = 0.0;
  double percent_change_7d = 0.0;
  double percent_change_30d = 0.0;
  double percent_change_60d = 0.0;
  double percent_change_90d = 0.0;

  double price;
  ListCoin({
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

  factory ListCoin.fromjson(Map<String, dynamic> item) {
    return ListCoin(
      name: ListCoinInf.isEmpty ? '' : item['name'],
      symbol: ListCoinInf.isEmpty ? '' : item['symbol'],
      price: item['quote']['USD']['price'] == null
          ? 0.0
          : item['quote']['USD']['price'],
      percent_change_1h: item['quote']['USD']['percent_change_1h'] == null
          ? 4.0
          : item['quote']['USD']['percent_change_1h'],
      percent_change_24h: item['quote']['USD']['percent_change_24h'] == null
          ? 2.3
          : item['quote']['USD']['percent_change_24h'],
      percent_change_7d: item['quote']['USD']['percent_change_7d'] == null
          ? 6.0
          : item['quote']['USD']['percent_change_7d'],
      percent_change_30d: item['quote']['USD']['percent_change_30d'] == null
          ? 3.3
          : item['quote']['USD']['percent_change_30d'],
      percent_change_60d: item['quote']['USD']['percent_change_60d'] == null
          ? 7.2
          : item['quote']['USD']['percent_change_60d'],
      percent_change_90d: item['quote']['USD']['percent_change_90d'] == null
          ? 4
          : item['quote']['USD']['percent_change_90d'],
    );
  }
}

List<ListCoin> ListCoinInf = [];
