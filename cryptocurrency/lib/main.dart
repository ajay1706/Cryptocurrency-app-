import 'dart:convert';

import 'package:flutter/material.dart';
import './home_page.dart';
import 'package:http/http.dart' as http;


void main() async{
  
  List currencies =   await  getCurrencies();
  print(currencies);

   runApp(MyApp(currencies));


}
class MyApp extends StatelessWidget {
  final List _currencies;
  MyApp(this._currencies);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(_currencies),
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      
    );
  }
}


  Future<List> getCurrencies() async {
    String cryptoUrl = "https://api.coinmarketcap.com/v1/ticker/";
    http.Response response = await http.get(cryptoUrl);

    return jsonDecode(response.body);
  }
