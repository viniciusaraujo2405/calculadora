import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: Column(
        children: [
          Row(
            children: [
              Text('9'),
              Text('8'),
              Text('7'),
            ],
          ),
          Row(
            children: [
              Text('6'),
              Text('5'),
              Text('4'),

            ],
          ),
          Row(
            children: [
              Text('3'),
              Text('2'),
              Text('1'),
            ],
          ),
          
        ],
      ),
    );
  }
}