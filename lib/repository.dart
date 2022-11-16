import 'package:dio/dio.dart';

import 'models/Crypto.dart';

const url =
    "https://api.coinmarketcap.com/data-api/v3/cryptocurrency/listing?start=1&limit=100&sortBy=market_cap&sortType=desc&convert=USD&cryptoType=all&tagType=all&audited=false&aux=ath,atl,high24h,low24h,num_market_pairs,cmc_rank,date_added,tags,platform,max_supply,circulating_supply,total_supply,volume_7d,volume_30d";
const image_url = "https://s2.coinmarketcap.com/static/img/coins/64x64/";

Future<List<Crypto>?> getData() async {
  var response = await Dio().get(url);
  List<Crypto>? cryptoList = response.data["data"]["cryptoCurrencyList"]
      .map<Crypto>((jsonMapObject) => Crypto.fromMapJson(jsonMapObject))
      .toList();
  return cryptoList;
}
