import 'package:aviocast/Models/flight_prediction.dart';
import 'package:aviocast/Views/Dashboard/animationRadar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Showrisk extends StatefulWidget {
  final String departureicao;
  final String destinationicao;
  const Showrisk({
    super.key,
    required this.departureicao,
    required this.destinationicao,
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
      return Scaffold(
        body: Center(
          child: Animationradar(),
        ),
      );
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
    if (prediction == null || originRisk == null || destinationRisk == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Flight Risk')),
        body: const Center(child: Text('Invalid data structure from server')),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Flight Risk')),
      body: Center(
        child: Text(
          'Overall Risk: ${prediction['level']} where ${widget.departureicao} risk = ${originRisk['risk_level']} as well as ${widget.destinationicao} risk is ${destinationRisk['risk_level']}',
        ),
      ),
    );
  }
}
