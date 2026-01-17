import 'package:flutter/material.dart';
import 'package:flutter_application_1/currency_converter_material_page.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});
  @override
  
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(home: CurrencyConverterMaterialPage());
  }
  
}