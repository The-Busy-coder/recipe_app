import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/home.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(milliseconds: 2850), () {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => home(),));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: Center(
        child: Container(
          child: Column(
            children: [
              const SizedBox(height:265,),
              Lottie.asset("assets/Anim/cook.json",fit: BoxFit.cover,height: 260),
              RichText(text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(text: "Coo",
                        style: GoogleFonts.rubikGlitchPop(
                            textStyle: const TextStyle(fontSize: 47,
                                fontWeight: FontWeight.bold, color: Colors.black))),
                    TextSpan(text: " !< ",
                        style: GoogleFonts.rubikGlitchPop(
                            textStyle:const TextStyle(fontSize: 47,
                                fontWeight: FontWeight.bold, color: Colors.white))),
                    TextSpan(text: "ing",
                        style: GoogleFonts.rubikGlitchPop(
                            textStyle:const TextStyle(fontSize: 47,
                                fontWeight: FontWeight.bold, color: Colors.red))),
                  ]),),
            ],
          ),
        ),
      ),
    );
  }
}
