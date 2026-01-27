import 'package:aviocast/Models/airport_models.dart';
import 'package:aviocast/Views/Dashboard/StationSelectPopup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Color Combination:
// Primary:213448
// Secondary:547792
// Tertary:94B4C1
// Last:EAE0CF
bool TransferMode = false;
bool dest_deptSelected = false;

class Dashboard extends StatefulWidget {
  const Dashboard({super.key, selectedIcao});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  List airports = [];
  String? selectedIcao;
  String? selectedCity;
  String? selectedAirportName;

  @override
  void initState() {
    super.initState();
    loadAirports();
  }

  Future<void> loadAirports() async {
    final data = await ApiService.getAirports();
    setState(() => airports = data);
  }

  openStationSelector() {
    final result = Navigator.push(
      context,
      PageRouteBuilder(
        opaque: false,
        pageBuilder: (_, __, ___) => const Stationselectpopup(),
      ),
    );
  }

  bool TransferMode = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF213448),
        title: Padding(
          padding: const EdgeInsets.only(top: 10, left: 5),
          child: Text(
            "Aviocast",
            style: TextStyle(
              fontSize: 50,
              fontFamily: "Montserrat",
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
                              child: GestureDetector(
                                onTapUp: (_) => setState(() {
                                  dest_deptSelected = false;
                                }),
                                onTapDown: (_) => setState(() {
                                  dest_deptSelected = true;
                                }),
                                onTapCancel: () => setState(() {
                                  dest_deptSelected = false;
                                }),
                                onTap: () async {
                                  final result = await Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      opaque: false,
                                      pageBuilder: (_, __, ___) =>
                                          const Stationselectpopup(),
                                    ),
                                  );

                                  if (!mounted) return;

                                  if (result != null) {
                                    setState(() {
                                      selectedIcao = result['iata'];
                                      selectedCity=result['city'];
                                    });
                                  }
                                 },

                                child: AnimatedScale(
                                  scale: dest_deptSelected ? 0.85 : 1,
                                  duration: const Duration(milliseconds: 150),
                                  curve: Curves.easeOut,
                                  child: Container(
                                    height: 100,
                                    width: 110,
                                    decoration: BoxDecoration(
                                      color: (Color(0xFF213448)),

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
                                      padding: const EdgeInsets.only(left: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 15,
                                            ),
                                            child: Text(
                                              "DEPARTURE",
                                              style: TextStyle(
                                                color: Colors.white60,
                                                fontFamily: 'Montserrat',
                                                fontSize: 10,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                          Text(
                                            selectedIcao ?? " ",
                                            style: TextStyle(
                                              fontFamily: 'Roboto Condensed',
                                              color: Colors.white,
                                              fontSize: 30,
                                              fontWeight: FontWeight.w900,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 2,
                                              top: 5,
                                            ),
                                            child: Text(
                                              selectedCity ?? " ",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'Montserrat',
                                                fontSize: 12,
                                                fontWeight: FontWeight.w900,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
                                  padding: const EdgeInsets.only(left: 15),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 15),
                                        child: Text(
                                          "DESTINATION",
                                          style: TextStyle(
                                            color: Colors.white60,
                                            fontFamily: 'Montserrat',
                                            letterSpacing: 0.5,
                                            fontSize: 10,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        "BDP",
                                        style: TextStyle(
                                          fontFamily: 'Roboto Condensed',
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w900,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                          left: 2,
                                        ),
                                        child: Text(
                                          "Bhadrapur",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Montserrat',
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900,
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
                                  Icon(Icons.search, color: Colors.white),
                                  const SizedBox(width: 8),
                                  Text(
                                    "CHECK RISK LEVEL",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Montserrat',
                                      fontSize: 17,
                                      fontWeight: FontWeight.w900,
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
