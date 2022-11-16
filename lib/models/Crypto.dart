class Crypto {
  String id;
  String name;
  String symbol;
  double changePercent24Hr;
  double price;
  double marketCap;
  int rank;

  Crypto(
    this.id,
    this.name,
    this.symbol,
    this.changePercent24Hr,
    this.price,
    this.marketCap,
    this.rank,
  );

  factory Crypto.fromMapJson(Map<String, dynamic> jsonMapObject) {
    return Crypto(
      jsonMapObject["id"].toString(),
      jsonMapObject["name"],
      jsonMapObject["symbol"],
      jsonMapObject["quotes"][0]["percentChange24h"],
      jsonMapObject["quotes"][0]["price"],
      jsonMapObject["quotes"][0]["marketCap"],
      jsonMapObject["cmcRank"],
    );
  }
}
