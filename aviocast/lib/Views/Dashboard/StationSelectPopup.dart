import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Stationselectpopup extends StatelessWidget {
  const Stationselectpopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BackdropFilter(
            filter:ImageFilter.blur(sigmaX: 8,sigmaY: 8), 
            child: Container(
              color: Colors.black87,
            ),
            ),
            Center(
              
            )
        ],
      ),
    );
  }
}