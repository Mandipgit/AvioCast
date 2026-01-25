import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Color Combination:
// Primary:213448
// Secondary:547792
// Tertary:94B4C1
// Last:EAE0CF
bool TransferMode = false;

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool TransferMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF213448),
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Text(
            "Aviocast",
            style: TextStyle(
              fontSize: 50,
              fontFamily: "Playfair Display",
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF213448), // Primary
                        Color(0xFF547792), // Secondary
                        Color(0xFF94B4C1), // Tertary
                      ],
                    ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.37,
                  width: MediaQuery.of(context).size.width * 1,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0xFF547792), // Primary
                        Color(0xFF94B4C1), // Secondary
                        Color(0xFFEAE0CF), // Tertary
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black45,
                        blurRadius: 15,
                        offset: Offset(0, 4), // x, y
                      ),
                    ],
                    border: Border.all(color: Color(0xFF547792)),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 25, left: 30),
                        child: Text(
                          "ROUTE SELECTION",
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          left: 30,
                          right: 30,
                        ),
                        child: Divider(color: Colors.grey.shade600),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Container(
                                height: 100,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: Color(0xFF213448),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black45,
                                      blurRadius: 10,
                                      offset: Offset(0, 4), // x, y
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left:15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top:15),
                                        child: Text("DEPARTURE",
                                        style: TextStyle(
                                          color: Colors.white60,
                                          fontFamily: 'Roboto Condensed',
                                          letterSpacing: 0.5,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w900
                                        ),
                                        ),
                                      ),
                                      Text("KTM",
                                      style: TextStyle(
                                        fontFamily: 'Playfair Display',
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w900
                                      ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:3),
                                        child: Text("Kathmandu",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Roboto Condensed',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w900
                                        ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTapDown: (_) =>
                                  setState(() => TransferMode = true),
                              onTapUp: (_) =>
                                  setState(() => TransferMode = true),
                              onTapCancel: () =>
                                  setState(() => TransferMode = true),
                              onTap: () {
                                setState(() {
                                  TransferMode = !TransferMode;
                                });
                              },
                              child: AnimatedOpacity(
                                duration: Duration(milliseconds: 120),
                                opacity: TransferMode ? 0.6 : 1,
                                child: Container(
                                  height: TransferMode ? (45) : (50),
                                  width: TransferMode ? (45) : (50),
                                  decoration: BoxDecoration(
                                    color: TransferMode
                                        ? (Color(0xFF213448))
                                        : Color(0xFFEAE0CF),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black45,
                                        blurRadius: 10,
                                        offset: Offset(0, 4), // x, y
                                      ),
                                    ],
                                    borderRadius: TransferMode
                                        ? (BorderRadius.circular(45))
                                        : (BorderRadius.circular(50)),
                                  ),
                                  child: Icon(
                                    Icons.swap_horiz,
                                    color: TransferMode
                                        ? (Colors.white)
                                        : Color(0xFF213448),
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: Container(
                                height: 100,
                                width: 110,
                                decoration: BoxDecoration(
                                  color: Color(0xFF213448),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black45,
                                      blurRadius: 10,
                                      offset: Offset(0, 4), // x, y
                                    ),
                                  ],
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left:15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top:15),
                                        child: Text("DESTINATION",
                                        style: TextStyle(
                                          color: Colors.white60,
                                          fontFamily: 'Roboto Condensed',
                                          letterSpacing: 0.5,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w900
                                        ),
                                        ),
                                      ),
                                      Text("BDP",
                                      style: TextStyle(
                                        fontFamily: 'Playfair Display',
                                        color: Colors.white,
                                        fontSize: 40,
                                        fontWeight: FontWeight.w900
                                      ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(left:3),
                                        child: Text("Bhadrapur",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Roboto Condensed',
                                          fontSize: 12,
                                          fontWeight: FontWeight.w900
                                        ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 30,
                          right: 30,
                          top: 30,
                        ),
                        child: Container(
                          height: 60,
                          width: MediaQuery.of(context).size.width * 1,
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black45,
                                blurRadius: 10,
                                offset: Offset(0, 4), // x, y
                              ),
                            ],
                            borderRadius: BorderRadius.circular(30),
                            color: Color(0xFF213448),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.search,
                                  color: Colors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  Text("CHECK RISK LEVEL",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Montserrat',
                                    fontSize: 17,
                                    fontWeight: FontWeight.w900
                                  ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
