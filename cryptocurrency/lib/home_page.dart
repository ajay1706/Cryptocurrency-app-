import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';


class HomePage extends StatefulWidget {
  final List currencies;
  HomePage(this.currencies);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

   List currencies;
  final List<MaterialColor> _colors = [Colors.indigo, Colors.red, Colors.teal];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CryptoCurrency"),
        elevation: defaultTargetPlatform == TargetPlatform.iOS ? 0.0 : 5.0,
      ),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
            child: ListView.builder(
              itemCount: widget.currencies.length,
              itemBuilder: (BuildContext context, int index) {
                final Map currency = widget.currencies[index];

                final MaterialColor color = _colors[index % _colors.length];
                return _getListItemUI(currency, color);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _getListItemUI(Map currency, MaterialColor color) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: color,
        child: Text(currency['name'][0]),
      ),
      title: Text(
        currency['name'],
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: _getSubtitleText(
          currency['price_usd'], currency['percent_change_1h']),
      trailing: CircleAvatar(
        child: Text(currency['rank'],
        style: TextStyle(color: Colors.black,
        fontWeight: FontWeight.bold),),
        backgroundColor: Colors.amber,
        
      ),
      isThreeLine: true,
    );
  }

  Widget _getSubtitleText(String priceUSD, String percentageChange) {
    TextSpan priceTextWidget =
        TextSpan(text: "\$$priceUSD\n", style: TextStyle(color: Colors.black));

    String percentageChangeText = "1 hour: $percentageChange%";
    TextSpan percentageChangeTextWidget;

    if (double.parse(percentageChange) > 0) {
      percentageChangeTextWidget = TextSpan(
          text: percentageChangeText, style: TextStyle(color: Colors.green));
    } else {
      percentageChangeTextWidget = TextSpan(
          text: percentageChangeText, style: TextStyle(color: Colors.red));
    }

    return RichText(
      text: TextSpan(children: [priceTextWidget, percentageChangeTextWidget]),
    );
  }
}
