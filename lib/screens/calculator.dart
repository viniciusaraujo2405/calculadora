import 'package:calculadora/components/display.dart';
import 'package:calculadora/components/keyboard.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/'); 
  }

  @override 
  
   @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Display(memory.value),
                Keyboard(_onPressed),
              ],
            ),
            Positioned(
              top: 30, 
              right: 5, 
              child: ElevatedButton(
                onPressed: _logout,
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(), 
                  padding: EdgeInsets.all(10),
                  backgroundColor: Colors.orange[800], 
                ),
                child: Icon(Icons.logout, color: Colors.white), 
              ),
            ),
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}