import 'dart:developer';
import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/stacked_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_ecm/utils/auth_widget/widget_register.dart';
import 'package:firebase_auth_ecm/utils/widget_buttom.dart';
import 'package:firebase_auth_ecm/view/home/home_screen.dart';
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
      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));

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
                  child: WidgetRegister(
                    iconLeft: Icons.email, 
                    hintText: 'Enter Email', 
                    hintPass: 'Enter Password',
                    emailcontroller: emailcontroller, 
                    passwordcontroller: passwordcontroller,
                    forgot: "Forgot Password?", 
                    goToLogin: "Go to Login",
                    isShow: false,
                  ),
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: WidgetRegister(
                    iconLeft: Icons.email, 
                    hintText:  'Enter Email',
                    hintPass: 'Enter Password',
                    hintConfirmPass: 'Enter Confirm Password',
                    emailcontroller: emailcontroller, 
                    passwordcontroller: passwordcontroller,
                    confirmPasswordcontroller: confirmPasswordController,
                    forgot: "Forgot Password?", 
                    goToLogin: "Go to Login",
                    isShow: true,
                  ),
                );
              }
            },
          ),
          WidgetButtom(
            title: isSelected == "login".toLowerCase() ? "Login" : "Sign Up",
            onPressed: isSelected == "login".toLowerCase() ? _sign_in : _sign_up,
            color: Colors.amber,
            textColor: Colors.white,size: 20,FontWeight: FontWeight.bold,
            width: 300,
            height: 55.0,
          ),
        ],
      ),
    );
  }
}