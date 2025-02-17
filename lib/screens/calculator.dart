import 'package:calculadora/screens/history_screen.dart'; 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../components/button.dart';
import '../models/memory.dart';
import 'package:calculadora/components/display.dart';
import 'package:calculadora/components/keyboard.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final Memory memory = Memory();

  _onPressed(String command) {
    setState(() {
      memory.applyCommand(command);
    });
  }

  void _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/');
  }

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
              left: 5,
              child: Container(
                    color: Colors.black,
                    child: IconButton(
                      icon: Icon(
                        Icons.list,
                        color: Button.OPERATION,),
                      onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => HistoryScreen()),
                      );
                    },
                    )
                  ),
                ),
              Positioned(
                top: 30,
                right: 5,
                child: Container(
                  child: Container(
                    color: Colors.black,
                    child: IconButton(
                      icon: Icon(
                        Icons.logout,
                        color: Button.OPERATION,),
                      onPressed: _logout,
                    )
                  ),
                )



              ),
                
          ],
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
