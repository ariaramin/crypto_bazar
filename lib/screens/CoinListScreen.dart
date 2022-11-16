import 'package:crypto_bazar/constants/constants.dart';
import 'package:crypto_bazar/models/Crypto.dart';
import 'package:flutter/material.dart';
import 'package:crypto_bazar/repository.dart';

class CoinListScreen extends StatefulWidget {
  CoinListScreen({super.key, this.cryptoList});
  List<Crypto>? cryptoList;

  @override
  State<CoinListScreen> createState() => _CoinListScreenState();
}

class _CoinListScreenState extends State<CoinListScreen> {
  List<Crypto>? _cryptoList;

  @override
  void initState() {
    super.initState();
    _cryptoList = widget.cryptoList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      appBar: _getAppBar(),
      body: SafeArea(
        child: _getBody(),
      ),
    );
  }

  AppBar _getAppBar() {
    return AppBar(
      backgroundColor: blackColor,
      title: Text(
        'کریپتو بازار',
        style: TextStyle(fontFamily: "Morabba"),
      ),
      centerTitle: true,
      automaticallyImplyLeading: false,
    );
  }

  Widget _getBody() {
    return RefreshIndicator(
      backgroundColor: primaryColor,
      color: blackColor,
      onRefresh: _refresh,
      child: ListView.builder(
        itemCount: _cryptoList!.length,
        itemBuilder: (context, index) {
          return _getListTile(_cryptoList![index]);
        },
      ),
    );
  }

  Widget _getListTile(Crypto crypto) {
    return ListTile(
      title: Text(
        crypto.name,
        style: TextStyle(color: primaryColor),
      ),
      subtitle: Text(
        crypto.symbol,
        style: TextStyle(color: greyColor),
      ),
      leading: SizedBox(
        width: 62,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              crypto.rank.toString(),
              style: TextStyle(color: greyColor),
            ),
            SizedBox(
              child: Center(
                child: Image.network(
                  image_url + crypto.id + ".png",
                  width: 36,
                ),
              ),
            ),
          ],
        ),
      ),
      trailing: SizedBox(
        width: 148,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  r"$" + crypto.price.toStringAsFixed(2),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  crypto.changePercent24Hr.toStringAsFixed(2),
                  style: TextStyle(
                    color: _getColorChnageText(crypto.changePercent24Hr),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 50,
              child: Center(
                child: _getIconChangePercent(crypto.changePercent24Hr),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getIconChangePercent(double percentChange) {
    return percentChange <= 0
        ? Icon(
            Icons.trending_down,
            size: 24,
            color: redColor,
          )
        : Icon(
            Icons.trending_up,
            size: 24,
            color: primaryColor,
          );
  }

  Color _getColorChnageText(double percentChange) {
    return percentChange <= 0 ? redColor : primaryColor;
  }

  Future<void> _refresh() async {
    var refreshedData = await getData();
    setState(() {
      _cryptoList = refreshedData;
    });
  }
}
