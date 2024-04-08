import 'package:flutter/material.dart';

class WhiteCard extends StatelessWidget {
    final String? title;
    final Widget child;
    final double? width;
    const WhiteCard({super.key, 
        this.title, 
        required this.child, 
        this.width
    });

    @override
    Widget build(BuildContext context) {
        return Container(
            width:  ( width != null ) ? width : null,
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(10),
            decoration: buildBoxdecoration()
        );
    }

    BoxDecoration buildBoxdecoration(){
        return  BoxDecoration(
            color: Colors.grey[400],
            borderRadius: BorderRadius.circular(8),
            boxShadow: [ 
                BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    blurRadius: 5
                )
            ]
        );  
    }

}