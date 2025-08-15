import 'dart:developer';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/stacked_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_ecm/view/auth/widget/text_field_register_widget.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isLoginLoading = false;
  String isSelected = '';
  bool isCheck = false;
  void showSuccessNotification(BuildContext context, String title, String description) {
  ElegantNotification.info(
    width: 390,
    isDismissable: true,
    stackedOptions: StackedOptions(
      key: 'top',
      type: StackedType.same,
      itemOffset: const Offset(-5, -5),
    ),
    title: Text(title),
    description: Text(description),
    onDismiss: () {},
    onNotificationPressed: () {},
  ).show(context);
}
  /// function to handle user login
  Future<void> _sign_in() async {
    if (emailcontroller.text.isEmpty || passwordcontroller.text.isEmpty) {
      showSuccessNotification(
        context,
        'Error',
        'Email and password cannot be empty',
      );
      return;
    }
    setState(() {
      isLoginLoading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      );
      log("Login successful");
    } on FirebaseAuthException catch (e) {
      log("Login failed: ${e.code} - ${e.message}");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.message ?? 'Login failed')));
    } finally {
      setState(() => isLoginLoading = false);
    }
  }

  /// fuction to handle user registration
  Future<void> _sign_up() async {
    if (emailcontroller.text.isEmpty ||
        passwordcontroller.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      return;
    }
    if (passwordcontroller.text != confirmPasswordController.text) {
      return;
    }
    setState(() {
      isLoginLoading = true;
    });
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailcontroller.text.trim(),
        password: passwordcontroller.text.trim(),
      );
      log("Registration successful");
    } on FirebaseAuthException catch (e) {
      log("Registration failed: ${e.code} - ${e.message}");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Registration failed')),
      );
    } finally {
      setState(() => isLoginLoading = false);
    }
  }

  /// function clear
  void clear() {
    emailcontroller.clear();
    passwordcontroller.clear();
    confirmPasswordController.clear();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.arrow_back_ios_new, color: Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isSelected = 'Login'.toLowerCase();
                          });
                          log("message ----------- selected is $isSelected");
                        },
                        child: Text(
                          "Sign In",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          setState(() {
                            isSelected = 'Sign Up'.toLowerCase();
                          });
                          log("message ----------- selected is $isSelected");
                        },
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 22,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome back!",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 25),
                ),
              ],
            ),
          ),
          Builder(
            builder: (context) {
              if (isSelected == "login".toLowerCase()) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFieldRegisterWidget(
                        hintText: 'Enter Email',
                        controller: emailcontroller,
                        iconData: Icons.email,
                      ),
                      TextFieldRegisterWidget(
                        hintText: 'Enter Password',
                        controller: passwordcontroller,
                        isObscureText: true,
                        iconData: Icons.lock,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("forgot password?"),
                          Text("Don't have an account?"),
                        ],
                      ),
                      SizedBox(height: 50),
                      InkWell(
                        onTap: () {
                          
                          _sign_in();
                          clear();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              width: 0.5,
                            ),
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 0.5),
                                color: Colors.grey.withValues(alpha: 0.5),
                                blurRadius: 10,
                                spreadRadius: 0.5,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Login",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFieldRegisterWidget(
                        hintText: 'Enter Email',
                        controller: emailcontroller,
                        iconData: Icons.email,
                      ),
                      TextFieldRegisterWidget(
                        hintText: 'Enter Password',
                        controller: passwordcontroller,
                        isObscureText: true,
                        iconData: Icons.lock,
                      ),
                      TextFieldRegisterWidget(
                        hintText: 'Enter confirm Password',
                        controller: confirmPasswordController,
                        isObscureText: true,
                        iconData: Icons.lock,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("forgot password?"),
                          Text("go to login"),
                        ],
                      ),
                      SizedBox(height: 50),
                      InkWell(
                        onTap: () {
                          log("next to register screen");
                          _sign_up();
                          clear();
                        },
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromARGB(255, 255, 255, 255),
                              width: 0.5,
                            ),
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                offset: Offset(0, 0.5),
                                color: Colors.grey.withValues(alpha: 0.5),
                                blurRadius: 10,
                                spreadRadius: 0.5,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "Sign Up",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}