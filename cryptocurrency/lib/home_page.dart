import 'dart:convert';
import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  List currencies ;
final List<MaterialColor> _colors = [Colors.indigo,Colors.red];


@override
  void initState()  {
super.initState();
getCurrencies();    
    
  }

Future<List> getCurrencies() async{
  String cryptoUrl = "https://api.coinmarketcap.com/v1/ticker/";
  http.Response response = await http.get(cryptoUrl);

  return jsonDecode(response.body);


}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CryptoCurrency"),
      ),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    return Container(
      child: Flexible(
        child: ListView.builder(
          itemCount: currencies.length,
          itemBuilder: (BuildContext context, int index){
            final Map currency = currencies[index];

            final MaterialColor color = _colors[index % _colors.length];
            return _getListItemUI(currency, color);




          },
        ),
      ),
    );
  }


Widget _getListItemUI(Map currency, MaterialColor color){
  return ListTile( 
    leading: CircleAvatar(backgroundColor: color,
    child: Text(currency['name'][0]), ),
    title:Text(currency['name'],
    style: TextStyle(fontWeight: FontWeight.bold)
    ,),
    subtitle:_getSubtitleText(currency['price_usd'], currency['percent_change_1h'] ) ,
    trailing: CircleAvatar( 
      child: Text(currency['rank']),
    ),
    isThreeLine: true,
     
  );
}



Widget _getSubtitleText(String priceUSD, String percentageChange){

TextSpan priceTextWidget = TextSpan(
  text: "\$$priceUSD\n",
  style: TextStyle(color: Colors.black)
);

String percentageChangeText = "1 hour: $percentageChange%";
TextSpan percentageChangeTextWidget;

if(double.parse(percentageChange)>0){
  percentageChangeTextWidget = TextSpan(  
    text: percentageChangeText,
    style: TextStyle(color: Colors.green)
  );

}
else {
  percentageChangeTextWidget = TextSpan(  
    text: percentageChangeText,
    style: TextStyle(color: Colors.red)
  );
  
}

return RichText(
text: TextSpan(
  children: [priceTextWidget,percentageChangeTextWidget]
),
);

}

}
