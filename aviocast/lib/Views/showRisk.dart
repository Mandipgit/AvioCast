import 'package:aviocast/Models/flight_prediction.dart';
import 'package:aviocast/Views/Dashboard/animationRadar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Showrisk extends StatefulWidget {
  final String departureicao;
  final String destinationicao;
  final String departureiata;
  final String destinaitoniata;
  
  const Showrisk({
    super.key,
    required this.departureicao,
    required this.destinationicao,
    required this.departureiata,
    required this.destinaitoniata,
  });

  @override
  State<Showrisk> createState() => _ShowriskState();
}

class _ShowriskState extends State<Showrisk> {
  Map<String, dynamic>? flightData;
  bool isLoading = true;
  String? error;
  @override
  void initState() {
    super.initState();
    fetchFlights();
  }

  Future<void> fetchFlights() async {
    try {
      final data = await FlightAPI.getflightData(
        origin: widget.departureicao,
        destination: widget.destinationicao,
      );

      debugPrint(data.toString());

      if (!mounted) return;

      setState(() {
        flightData = data;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(body: Center(child: Animationradar()));
    }
    if (error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Flight Risk')),
        body: Center(child: Text(error!)),
      );
    }

    if (flightData == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Flight Risk')),
        body: const Center(child: Text('No data available')),
      );
    }

    final prediction = flightData?['flight_prediction'];
    final originRisk = flightData?['origin']?['risk'];
    final destinationRisk = flightData?['destination']?['risk'];
    final riskScore=flightData?['origin']?['risk_score'];
    if (prediction == null || originRisk == null || destinationRisk == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Flight Risk')),
        body: const Center(child: Text('Invalid data structure from server')),
      );
    }

    return Scaffold(
      backgroundColor: Color(0xFF213448),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFF213448),
        title: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0),
          child: const Text(
            'Flight Risk',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(top: 8.0, right: 20),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.04,
              width: MediaQuery.of(context).size.width * 0.25,
              decoration: BoxDecoration(
                color: Color(0xFF94B4C1),

                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 3),
                  ),
                ],
                border: Border.all(color: Colors.white38, width: 1.9),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${widget.departureiata}',
                    style: TextStyle(
                      color: Colors.red[300],
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Roboto Condensed',
                      fontSize: 18,
                    ),
                  ),
                  Icon(Icons.arrow_right, size: 25),
                  Text(
                    '${widget.destinaitoniata}',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Roboto Condensed',
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(left: 20,right: 20,top:10),
            child: Container(
              height: MediaQuery.of(context).size.height*0.7,
              width: MediaQuery.of(context).size.width*0.9,
              decoration: BoxDecoration(
                color: Color(0xFF547792),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black45,
                          blurRadius: 15,
                          offset: Offset(0, 4),
                  )
                ]
              ),
              child: Text('${riskScore}',
              style: TextStyle(
                color: Colors.white
              ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
