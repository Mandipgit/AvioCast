import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Color Combination:
// Primary: 213448
// Secondary:547792
// Tertary:94B4C1
// Last:EAE0CF

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF213448),
      appBar: AppBar(
        backgroundColor: Color(0xFF213448),
        title: Padding(
          padding: const EdgeInsets.only(top:10),
          child: Text("Aviocast",
          style: TextStyle(
            fontSize: 50,
            fontFamily: "Playfair Display",
            fontWeight: FontWeight.w900,
            color: Colors.white
          ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Padding(
             padding: const EdgeInsets.only(top:40,left:20,right:20),
             child: Container(
              height: MediaQuery.of(context).size.height*0.40,
              width: MediaQuery.of(context).size.width*1,
              decoration: BoxDecoration(
                color: Color(0xFF94B4C1),
                border: Border.all(
                  color: Color(0xFF547792)
                  ),
                  borderRadius: BorderRadius.circular(40)
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25,left:30),
                    child: Text("ROUTE SELECTION",
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Montserrat',
                      fontSize: 14
                    ),
                    ),
                  ),
                  Divider(
                    
                  )
                ],
              ),
             ),
           )
            
          ],

        ),
      ),
    );
  }
}