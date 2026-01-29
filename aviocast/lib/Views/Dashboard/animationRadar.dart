import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Animationradar extends StatefulWidget {
  const Animationradar({super.key});

  @override
  State<Animationradar> createState() => _AnimationradarState();
}

class _AnimationradarState extends State<Animationradar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/lottie/Radar.json',
          width: 160,
          repeat: true,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
