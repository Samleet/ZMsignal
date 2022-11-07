import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final String label;
  final IconData icon;
  final TextInputType? type;
  final TextInputAction? action;
  final TextEditingController? controller;
  final bool password;

  const TextInput({
    required this.label,
    required this.icon,
    this.controller,
    this.type = TextInputType.text,
    this.action = TextInputAction.none,
    this.password = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Color(0XFFF6F6F6),
        borderRadius: BorderRadius.circular(10),
      ),
      
      child: TextField(
        controller: controller,
        autofocus: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(10),
          prefixIcon: Icon(icon, color: Colors.black, size: 15),
          hintText: label,
          hintStyle: TextStyle(fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide.none,
          ),
        ),
        obscureText: password,
        keyboardType: type,
        textInputAction: action,
      ),
    );

  }
}