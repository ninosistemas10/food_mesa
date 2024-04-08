
import 'package:dashboard_bloc/app/presentation/dashboard/dashboard.dart';
import 'package:dashboard_bloc/app/presentation/mesas/mesas.dart';
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
    const MyApp({super.key});
  
    @override
    Widget build(BuildContext context) {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Dashboard(child: Mesas()),
            
            

        );
    }
}