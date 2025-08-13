import 'package:flutter/material.dart';
class TextFieldRegisterWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool isObscureText;
  final IconData? iconData;
  TextFieldRegisterWidget({
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
    this.iconData,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: .5),
            spreadRadius: 0.5,
            blurRadius: 10,
            offset: Offset(0, 0.5), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        child: TextField(
          controller: controller,
          obscureText: isObscureText,
          decoration: InputDecoration(
            hintText: hintText,
            suffixIcon: isObscureText
                ? IconButton(
                    icon: Icon(
                      controller.text.isEmpty ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      // Toggle obscure text logic can be added here if needed
                    },
                  )
                : null,
            border: InputBorder.none,
            prefixIcon: iconData != null ? Icon(iconData) : null,
          ),
        ),
      ),
    );
  }
}
