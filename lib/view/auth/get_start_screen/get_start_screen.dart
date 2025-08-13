import 'dart:developer';
import 'package:firebase_auth_ecm/view/auth/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
class GetStartScreen extends StatefulWidget {
  const GetStartScreen({super.key});
  @override
  State<GetStartScreen> createState() => _GetStartScreenState();
}
class _GetStartScreenState extends State<GetStartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage(""),fit: BoxFit.cover),
            ),
          ),
          Positioned(
            bottom: 100,
            left: 100,
            right: 100,
            child: 
            InkWell(
              onTap: (){
                log("next to login screen");
                Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromARGB(255, 255, 255, 255), width: 0.5),
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
                child: Center(child: Text("Get Started",style: TextStyle(fontWeight: FontWeight.w700,fontSize: 18,color: Colors.white),)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
