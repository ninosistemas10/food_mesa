import 'package:flutter/material.dart';


class CustomInputs {

    static InputDecoration loginInputDecoration({
        required String hint,
        required String label,
        required IconData icon,
    }){
        return InputDecoration(
            border: OutlineInputBorder( borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)) ),

            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),    
                borderSide: BorderSide( color: Colors.grey.withOpacity(0.3)) ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: const  BorderSide(color: Colors.grey)
            ),
            hintText: hint,
            labelText: label,
            prefixIcon: Icon( icon, color: Colors.grey ),
            labelStyle: const TextStyle( color: Colors.grey ),
            hintStyle: const TextStyle( color: Colors.grey ),
        );
    }

    static InputDecoration searchInputDecoration({
        required String hint,
        required IconData icon
    }) {
        return InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: hint,
            prefixIcon: Icon( icon, color: Colors.grey ),
            labelStyle: const TextStyle( color: Colors.grey ),
            hintStyle: const TextStyle( color: Colors.grey )
        );
    }
}