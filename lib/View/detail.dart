import 'package:covid_tracker/world_stat.dart';
import 'package:flutter/material.dart';

class detailcountrie extends StatefulWidget {
  String image;
  String name;
  int totalcases, totaldeaths, active, critical, todayrescovered, test;
  detailcountrie({
    required this.image,
    required this.name,
    required this.totalcases,
    required this.totaldeaths,
    required this.active,
    required this.critical,
    required this.todayrescovered,
    required this.test,
  });

  @override
  State<detailcountrie> createState() => _detailcountrieState();
}

class _detailcountrieState extends State<detailcountrie> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .067),
                  child: Card(
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .06,
                        ),
                        resuablerow(
                            title: 'Cases',
                            value: widget.totalcases.toString()),
                        resuablerow(
                            title: 'totaldeaths',
                            value: widget.totaldeaths.toString()),
                        resuablerow(
                            title: 'active', value: widget.active.toString()),
                        resuablerow(
                            title: 'critical',
                            value: widget.critical.toString()),
                        resuablerow(
                            title: 'todayrescovered',
                            value: widget.todayrescovered.toString()),
                        resuablerow(
                            title: 'test', value: widget.test.toString()),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(widget.image),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
