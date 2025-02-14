import 'package:calculadora/screens/keyboard.dart';
import 'package:flutter/material.dart';

class Calculator extends StatelessWidget{
  const Calculator({Key? key}) : super(key: key);

  @override 

  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        
        body: Column(
          children: [
            Text('Display'),
            Keyboard(),
          ]
          
        
      ),
      ),
        debugShowCheckedModeBanner: false,

    );
  }
}