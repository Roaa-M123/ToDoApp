import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'on_boarding_screen.dart';
class ToDosplashScreen extends StatefulWidget {
  const ToDosplashScreen({super.key});

  @override
  State<ToDosplashScreen> createState() => _ToDosplashScreenState();
}

class _ToDosplashScreenState extends State<ToDosplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), (){
      final snackBar = SnackBar(
        content: SizedBox(
          child: Center(
            child: Text(
              'Welcome to ToDo App!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
        ),
        backgroundColor: Color(0xFF3584B5),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(30),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        duration: Duration(seconds: 5),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });

    Future.delayed(const Duration(seconds:8), () {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
        return const OnBoardingScreen();
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        backgroundColor: Color(0XffC5EDF6),
        body: Container(
          child:Center(
            child: Stack(
              children: [
                Positioned(
                  left: 0,
                  right: 0,
                  top:200,
                  child: Center(
                    child: Text("To Do App",style:TextStyle (
                      color: Color(0xFF3584B5),
                      fontSize: 60,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                          offset: Offset(4.0, 4.0),
                          blurRadius: 11.0,
                          color: Colors.black26.withOpacity(0.2),
                        ),
                      ],
                    ),

                    ),
                  ),
                ),
                Positioned(
                  right:16,
                  width: 400,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 43),
                    child: Lottie.asset(
                        height:700,
                        width:700,
                        "assets/splashUsed.json"
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}