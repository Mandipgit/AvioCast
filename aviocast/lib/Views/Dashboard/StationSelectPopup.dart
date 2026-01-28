import 'dart:ui';

import 'package:aviocast/Models/airport_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Stationselectpopup extends StatefulWidget {
  const Stationselectpopup({super.key});

  @override
  State<Stationselectpopup> createState() => _StationselectpopupState();
}

class _StationselectpopupState extends State<Stationselectpopup> {
  List<Map<String,dynamic>> airports = [];
  String? selectedIcao;
    int? pressedIndex;

  @override
  void initState() {
    super.initState();
    loadAirports();
  }

  Future<void> loadAirports() async {
    final data = await ApiService.getAirports();
    setState(() => airports = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(color: Colors.black87),
          ),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              width: MediaQuery.of(context).size.width * 0.8,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: Color(0xFF0F1B2D),
                borderRadius: BorderRadius.circular(60),
                border: Border.all(color: Colors.white10),
                boxShadow: [BoxShadow(color: Colors.black54, blurRadius: 30)],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 30,
                      left: 35,
                      right: 35,
                    ),
                    child: _header(),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Divider(color: Colors.white10),
                  ),
                  Expanded(
                    child: airports.isEmpty
                        ? Center(
                            child: CircularProgressIndicator(
                              color: Colors.greenAccent,
                            ),
                          )
                        : _stationList(context),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _header() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "SELECT STATION",
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w900,
            fontSize: 21,
            color: Colors.white,
            letterSpacing: 0.1,
          ),
        ),
        Icon(Icons.keyboard_arrow_down, color: Colors.white54, size: 35),
      ],
    );
  }

  Widget stationCard({
    required String city,
    required String airport,
    required String code,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        padding: EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Color(0xFF16233A),
          border: Border.all(
            color:Colors.white10 
            ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  city,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'Montserrat',
                    letterSpacing: 0.1,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  airport,
                  style: TextStyle(
                    color: Colors.white54, 
                    fontSize: 10,
                    fontFamily: 'Montserrat',
                    ),
                ),
              ],
            ),
            Text(
              code,
              style: TextStyle(
                color: Colors.greenAccent,
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Roboto Condensed',
              ),
            ),
          ],
        ),
      ),
    );
  }

Widget _stationList(BuildContext context) {
  return ListView.builder(
    padding: const EdgeInsets.only(bottom: 20),
    itemCount: airports.length,
    itemBuilder: (context, index) {
      final airport = airports[index];
      final isPressed = pressedIndex == index;

      return GestureDetector(
        onTapDown: (_) {
          setState(() => pressedIndex = index);
        },
        onTapUp: (_) {
          setState(() => pressedIndex = null);
        },
        onTapCancel: () {
          setState(() => pressedIndex = null);
        },
        child: AnimatedScale(
          scale: isPressed ? 0.85 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isPressed ? 0.85 : 1,
            child: stationCard(
              city: airport['city'] ?? airport['name'] ?? "Unknown",
              airport: airport['name'] ?? "Unknown",
              code: airport['iata'] ?? "N/A",
              onTap: () { Navigator.of(context, rootNavigator: true).pop(airport);}, 
            ),
          ),
        ),
      );
    },
  );
}

}



