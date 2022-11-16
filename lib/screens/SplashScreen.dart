import 'package:crypto_bazar/constants/constants.dart';
import 'package:crypto_bazar/repository.dart';
import 'package:crypto_bazar/screens/CoinListScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage('images/logo.png'),
              width: 192,
            ),
            Text(
              "کریپتو بازار",
              style: TextStyle(
                fontSize: 22,
                color: primaryColor,
                fontFamily: "Morabba",
              ),
            ),
            SizedBox(
              height: 16,
            ),
            SpinKitWave(
              color: Colors.white,
              size: 32,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _getData() async {
    var cryptoList = await getData();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => CoinListScreen(
          cryptoList: cryptoList,
        ),
      ),
      (Route<dynamic> route) => false,
    );
  }
}
