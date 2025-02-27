import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class Display extends StatelessWidget{
    final String text;

    Display(this.text);

    @override
    Widget build(BuildContext context){
        return Expanded(
            flex: 1,
            child: Container(
                color: Colors.black,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget> [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AutoSizeText(
                                text,
                                minFontSize: 20,
                                maxFontSize: 80,
                                maxLines: 1,
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    decoration: TextDecoration.none,
                                    fontSize: 80,
                                    color: Colors.white,
                                ),
                                
                                ),
                        )
                    ]
                )
            )
        );
    }

}