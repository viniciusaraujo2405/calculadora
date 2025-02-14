import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final bool big;

    Button({
    Key? key,
    required this.text,
    this.big = false,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: big ? 2 : 1,
      child: ElevatedButton(
        onPressed: () {},
        child: Text(text),
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
        ),
        
      ),
      
    );
  }
}