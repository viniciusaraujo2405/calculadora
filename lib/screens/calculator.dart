import 'package:calculadora/screens/display.dart';
import 'package:calculadora/screens/keyboard.dart';
import 'package:flutter/material.dart';

import '../models/memory.dart';

class Calculator extends StatefulWidget{
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final Memory memory = Memory();

  
  _onPressed(String command){
    setState(() {
      memory.applyCommand(command);
    });
    
  }

  @override 
  
  Widget build(BuildContext context){
    return MaterialApp(
      home: Scaffold(
        
        body: Column(
          children: [
            Display(memory.value),
            Keyboard(_onPressed),
          ]
          
        
      ),
      ),
        debugShowCheckedModeBanner: false,

    );
  }
}