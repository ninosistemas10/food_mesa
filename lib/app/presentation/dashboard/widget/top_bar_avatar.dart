import 'package:flutter/material.dart';

class TopBarAvatar extends StatelessWidget {
    const TopBarAvatar({super.key});

    @override
    Widget build(BuildContext context) {
        return ClipOval(
            child: SizedBox(
                width: 30,
                height: 30,
                child: Image.asset('assets/images/male.png')
        )   ,
        );
    }
}