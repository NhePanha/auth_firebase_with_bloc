import 'package:firebase_auth_ecm/view/auth/widget/text_field_register_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WidgetRegister extends StatelessWidget {
  final IconData? iconLeft;
  final IconData? iconRight;
  final String? title;
  final TextEditingController? emailcontroller;
  final TextEditingController? passwordcontroller;
  final TextEditingController? confirmPasswordcontroller;
  final String? hintText;
  final String? hintPass; 
  final String? hintConfirmPass;
  final String? forgot; 
  final String? goToLogin;
  bool isShow;

   WidgetRegister({
    Key? key,
    this.iconLeft,
    this.iconRight,
    this.title,
    this.hintText, this.forgot, this.goToLogin, this.emailcontroller, this.passwordcontroller, this.confirmPasswordcontroller,
    this.isShow = false, this.hintPass, this.hintConfirmPass,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFieldRegisterWidget(
          hintText: hintText.toString(),
          controller: emailcontroller!,
          iconData: Icons.email,
        ),
        TextFieldRegisterWidget(
          hintText: hintPass.toString(),
          controller: passwordcontroller!,
          isObscureText: true,
          iconData: Icons.lock,
        ),
        if(isShow)
        TextFieldRegisterWidget(
          hintText: hintConfirmPass.toString(),
          controller: confirmPasswordcontroller!,
          isObscureText: true,
          iconData: Icons.lock,
        ),
       SizedBox.shrink(),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(forgot.toString()),
            Text(goToLogin.toString())
          ],
        ),
      ],
    );
  }
}