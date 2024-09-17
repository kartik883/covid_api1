import 'dart:developer';
import 'package:covid_tracker/countries.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:covid_tracker/service/stat_service.dart';
import 'package:covid_tracker/worlddatamodel.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class Worldstatscreen extends StatefulWidget {
  const Worldstatscreen({Key? key}) : super(key: key);

  @override
  State<Worldstatscreen> createState() => _WorldstatscreenState();
}

class _WorldstatscreenState extends State<Worldstatscreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorlist = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    // Get the screen size
    final screenSize = MediaQuery.of(context).size;

    // Calculate a size for the pie chart based on screen size (using 40% of screen width)
    final pieChartSize = screenSize.width * 0.4;

    statesService stateservice = statesService();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                //SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                SizedBox(
                  height: screenSize.height * 0.1,
                  width: pieChartSize,
                ),
                FutureBuilder(
                    future: stateservice.fetchworldstat(),
                    builder: (context, AsyncSnapshot<Worlddatamodel> snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                          child: SizedBox(
                            child: Expanded(
                                flex: 1,
                                child: SpinKitFadingCircle(
                                  color: Colors.white,
                                  size: 50,
                                  controller: _controller,
                                )),
                          ),
                        );
                      } else {
                        return Column(
                          children: [
                            PieChart(
                              dataMap: {
                                "Total": double.parse(
                                    snapshot.data!.cases.toString()),
                                "Recover": double.parse(
                                    snapshot.data!.recovered.toString()),
                                "Death": double.parse(
                                    snapshot.data!.deaths.toString()),
                              },
                              chartValuesOptions: ChartValuesOptions(
                                showChartValuesInPercentage: true,
                              ),
                              chartRadius:
                                  MediaQuery.of(context).size.width / 3.2,
                              legendOptions: LegendOptions(
                                  legendPosition: LegendPosition.left),
                              animationDuration: Duration(milliseconds: 1200),
                              chartType: ChartType.ring,
                              colorList: colorlist,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical:
                                      MediaQuery.of(context).size.height * 0.6),
                              child: Card(
                                child: Column(
                                  children: [
                                    resuablerow(
                                      title: 'Total',
                                      value: snapshot.data!.cases.toString(),
                                    ),
                                    resuablerow(
                                      title: 'deaths',
                                      value: snapshot.data!.deaths.toString(),
                                    ),
                                    resuablerow(
                                      title: 'Recovered',
                                      value:
                                          snapshot.data!.recovered.toString(),
                                    ),
                                    resuablerow(
                                      title: 'Active',
                                      value: snapshot.data!.active.toString(),
                                    ),
                                    resuablerow(
                                      title: 'Crirtical',
                                      value: snapshot.data!.critical.toString(),
                                    ),
                                    resuablerow(
                                      title: ' Today rccovered',
                                      value: snapshot.data!.todayRecovered
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                // Add your action here (e.g., navigate to another screen)
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Countrieslist()));
                              },
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.blue.shade300,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Center(
                                    child: Text('track countries')),
                              ),
                            ),
                          ],
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class resuablerow extends StatelessWidget {
  String title, value;
  resuablerow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          SizedBox(height: 5),
          Divider(),
        ],
      ),
    );
  }
}
