import 'package:aviocast/Models/flight_prediction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Showrisk extends StatefulWidget {
  final String departureicao;
  final String destinationicao;
  const Showrisk({super.key,required this.departureicao,required this.destinationicao});

  @override
  State<Showrisk> createState() => _ShowriskState();
}

class _ShowriskState extends State<Showrisk> {
  @override
  void initState() {
    super.initState();
    fetchFlights();
  }
  void fetchFlights()async{
    final data= await FlightAPI.getflightData(
      origin:widget.departureicao,
      destination:widget.destinationicao
    );
    
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}