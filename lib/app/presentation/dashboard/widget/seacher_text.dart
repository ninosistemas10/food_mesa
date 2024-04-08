import 'package:dashboard_bloc/app/presentation/dashboard/widget/custom_input.dart';
import 'package:flutter/material.dart';


class SeacherText extends StatelessWidget {
    const SeacherText({super.key});

    @override
    Widget build(BuildContext context) {
        return Container(
            height: 40,
            decoration: buildBoxDecoration(),
            child: TextField(
                decoration: CustomInputs.searchInputDecoration(
                    hint: 'Buscar', 
                    icon: Icons.search_outlined
                )
            ),
        );
    }

    BoxDecoration buildBoxDecoration() => BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Colors.grey.withOpacity(0.1)
  );
}