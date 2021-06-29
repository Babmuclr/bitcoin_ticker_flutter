import 'package:flutter/material.dart';
import 'bitcoin_card.dart';
import 'coin_data.dart';

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'JPY';
  Map<String, String> prices = {};

  @override
  void initState() {
    super.initState();
    updatePrice();
  }

  void updatePrice() async {
    var data = await CoinData().getCoinData(selectedCurrency);
    setState(() {
      prices = data;
    });
  }

  DropdownButton<String> Dropdown() {
    List<DropdownMenuItem<String>> dropdownItems = [];
    for (String currency in currenciesList) {
      var newItem = DropdownMenuItem(
        child: Text(
          currency,
          style: TextStyle(
            fontSize: 40.0,
          ),
        ),
        value: currency,
      );
      dropdownItems.add(newItem);
    }

    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropdownItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: BitcoinCard(
                    crypto: cryptoList[0],
                    price: (prices[cryptoList[0]] == null) ? '' :  prices[cryptoList[0]],
                    currency: selectedCurrency,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: BitcoinCard(
                    crypto: cryptoList[1],
                    price: (prices[cryptoList[1]] == null) ? '' :  prices[cryptoList[1]],
                    currency: selectedCurrency,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
                  child: BitcoinCard(
                    crypto: cryptoList[2],
                    price: (prices[cryptoList[2]] == null) ? '' :  prices[cryptoList[2]],
                    currency: selectedCurrency,
                  ),
                ),
              ],
            ),
            flex: 5,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent,
              ),
              child: Center(
                child: Dropdown(),
                ),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
