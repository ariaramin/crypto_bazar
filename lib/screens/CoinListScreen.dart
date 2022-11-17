import 'package:crypto_bazar/constants/constants.dart';
import 'package:crypto_bazar/models/Crypto.dart';
import 'package:flutter/material.dart';
import 'package:crypto_bazar/repository.dart';
import 'package:unicons/unicons.dart';

class CoinListScreen extends StatefulWidget {
  CoinListScreen({super.key, this.cryptoList});
  List<Crypto>? cryptoList;

  @override
  State<CoinListScreen> createState() => _CoinListScreenState();
}

class _CoinListScreenState extends State<CoinListScreen> {
  List<Crypto>? _cryptoList;
  bool _isSearchListEmpty = false;

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
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: TextField(
              onChanged: (value) {
                _search(value);
              },
              decoration: InputDecoration(
                hintText: "اسم رمزارز مورد نظر را وارد کنید...",
                hintStyle: TextStyle(
                  fontFamily: "Morabba",
                  color: blackColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
                prefixIcon: Icon(
                  UniconsLine.search,
                  color: blackColor,
                ),
                filled: true,
                fillColor: primaryColor,
              ),
            ),
          ),
        ),
        Visibility(
          visible: _isSearchListEmpty,
          child: Text(
            "!رمزارز مورد نظر یافت نشد",
            style: TextStyle(
              fontFamily: "Morabba",
              color: primaryColor,
            ),
          ),
        ),
        Visibility(
          visible: !_isSearchListEmpty,
          child: Expanded(
            child: RefreshIndicator(
              backgroundColor: primaryColor,
              color: blackColor,
              onRefresh: _refresh,
              child: ListView.builder(
                itemCount: _cryptoList!.length,
                itemBuilder: (context, index) {
                  return _getListTile(_cryptoList![index]);
                },
              ),
            ),
          ),
        ),
      ],
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
        width: 156,
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
              width: 48,
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

  Future<void> _search(String value) async {
    List<Crypto> searchedList = [];
    if (value.isEmpty) {
      _refresh();
      return;
    }

    var refreshedData = await getData();

    searchedList = refreshedData!.where((element) {
      return element.name.toLowerCase().contains(value.toLowerCase());
    }).toList();

    setState(() {
      _cryptoList = searchedList;
      searchedList.isEmpty
          ? _isSearchListEmpty = true
          : _isSearchListEmpty = false;
    });
  }
}
