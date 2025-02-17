import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  static const DARK = Color.fromRGBO(26, 26, 26, 1) ;
  static const DEFAULT = Color.fromRGBO(165, 165, 165, 1.0);
  static const OPERATION = Color.fromRGBO(255, 149, 0, 1.0);
  
  final String text;
  final bool big;
  final Color color;
  final void Function(String) cb;

    Button({
    Key? key,
    required this.text,
    this.big = false,
    this.color = DARK,
    required this.cb,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      
      flex: big ? 2 : 1,
      child: ElevatedButton(
        onPressed: () => cb(text),
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50), 
        ),
            backgroundColor: this.color,
      ),
        child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.w300,
                ),
           ),
        
        ),
        
      );
      
    
  }
}