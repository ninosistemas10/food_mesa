import 'package:dashboard_bloc/app/presentation/dashboard/widget/notification_indicator.dart';
import 'package:dashboard_bloc/app/presentation/dashboard/widget/seacher_text.dart';
import 'package:dashboard_bloc/app/presentation/dashboard/widget/top_bar_avatar.dart';

import 'package:flutter/material.dart';


class TopBar extends StatelessWidget {
    const TopBar({super.key});

    @override
    Widget build(BuildContext context) {
        final size = MediaQuery.of(context).size;
        return Container(
            padding: const EdgeInsets.only(top: 10),
            width: double.infinity,
        
            height: 50,
            child: Row(
                children: [
                    const SizedBox(width: 10),
                    if (size.width <= 650) 
                        IconButton(
                            icon: const Icon(Icons.menu_outlined),
                            onPressed: () {
                                print('hola mundo');
                               // SideMenuProvider.openMenu();
                            }, 
                            
                            
                        ),

                    const SizedBox(width: 5),
                    if ( size.width > 390 )
                        ConstrainedBox(
                            constraints: const  BoxConstraints(maxWidth: 250),
                            child: const SeacherText(),
                        ),

                    const  Spacer(),

                    const NotificatorIndicator(),

                    const SizedBox(width: 20),
                    const TopBarAvatar(),
                    const SizedBox(width: 20),
                ],
            ),
        );
    }


}


